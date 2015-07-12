//
//  DepreciateViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "SDImageCache.h"
#import "UMSocial.h"
#import "PriceModel.h"
#import "MyPriceViewCell.h"
#import "DepreciateViewController.h"
#import "WebViewController.h"
@interface DepreciateViewController ()<UMSocialUIDelegate>

@end

@implementation DepreciateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstDownload];
    [self creatRefreshView];
    self.view.backgroundColor=[UIColor colorWithRed:255/255.0 green:248/255.0 blue:220/255.0 alpha:1];

    [self.tableView registerNib:[UINib nibWithNibName:@"MyPriceViewCell" bundle:nil] forCellReuseIdentifier:@"MyPriceViewCell"];
    self.tableView.frame=CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64-49);

    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(kScreenSize.width-80, 20,60, 40);
    [button setTitle:@"清除缓存" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
}


-(void)btnClick:(UIButton *)btn{

    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"总共有%.2fM缓存",[self getCachSize]] preferredStyle:UIAlertControllerStyleActionSheet];
    //增加按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //删除
        //删除两部分
        //1.删除 sd 图片缓存
        //先清除内存中的图片缓存
        [[SDImageCache sharedImageCache] clearMemory] ;
        //清除磁盘的缓存
        [[SDImageCache sharedImageCache] clearDisk];
        
        //2.删除自己缓存
        NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
        [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
        
        
        
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //取消
    }]];
    //跳转
    [self presentViewController:sheet animated:YES completion:nil];



}
//
//
- (CGFloat)getCachSize {
 
    NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
    //获取自定义缓存大小
    //用枚举器遍历 一个文件夹的内容
    //1.获取 文件夹枚举器
    //
    
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    __block NSUInteger count = 0;
    //2.遍历
    for (NSString *fileName in enumerator) {
        NSString *path = [myCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        count += fileDict.fileSize;//自定义所有缓存大小
    }
    // 得到是字节  转化为M
    CGFloat totalSize = ((CGFloat)imageCacheSize+count)/1024/1024;
    return totalSize;
}







-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   if (kScreenSize.width>=375) {
       return 300;
    }
    else{
        
        return 240;
        
    }
    //return 240;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    MyPriceViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyPriceViewCell" forIndexPath:indexPath];

    PriceModel *model=_dataArr[indexPath.row];

    NSString *str=[NSString stringWithFormat:@"快来参与活动把%@",model.eventLink];
   [cell showWith:^(UITableViewCell *block) {
    
       [UMSocialSnsService presentSnsIconSheetView:self
                                            appKey:@"557f970c67e58e3104000eaf"
                                         shareText:str shareImage:[UIImage imageNamed:@"navigationBarItem_favorite_normal@2x"]shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToSms] delegate:self];
       
   }];
    
    
    [cell showWithModel:model];
    
    
    return cell;

}



-(void)firstDownload{

    _isLoadMoring=NO;
    _isRefreshing=NO;
 
    [self addTaskUrl:self.requestUrl];

}

- (void)creatRefreshView{
    __weak typeof (self)mySelf=self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (mySelf.isRefreshing) {
            return ;
        }
        
        mySelf.isRefreshing=YES;
     
        
        [mySelf addTaskUrl:mySelf.requestUrl];
     
    }];
    
    
}
//结束刷新
- (void)endRefreshing{
    if (self.isRefreshing) {
        self.isRefreshing=NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadMoring) {
        self.isLoadMoring=NO;
        [self.tableView footerEndRefreshing];
    }
    
}






-(void)addTaskUrl:(NSString *)url{
    __weak typeof (self)weakSelf=self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [weakSelf.dataArr removeAllObjects];
        
        for (NSDictionary*dict in arr) {
            
            PriceModel *model=[[PriceModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.dataArr addObject:model];
            
        }
        
        [self.tableView reloadData];
         [self endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *web=[[WebViewController alloc]init];
    PriceModel *model=_dataArr[indexPath.row];
    web.RequestURL=model.eventLink;
    
    [self presentViewController:web animated:YES completion:nil];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
