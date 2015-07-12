//
//  BaseViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "LZXHelper.h"
#import "HotCell.h"
#import "WebViewController.h"
#import "BaseViewController.h"
#import "MyCell.h"
#import "NewestModel.h"
#import "ADView.h"
#define kUrl1 @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=1&ver=6.1.3&"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self creatTableView];
    _manager=[AFHTTPRequestOperationManager manager];
    _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
}
 - (void)viewWillAppear:(BOOL)animated
 {
        [super viewWillAppear:animated];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
     
     }


#pragma mark-TabView

-(void)creatTableView{
    self.dataArr=[[NSMutableArray alloc]init];
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kScreenSize.width, kScreenSize.height-49-55) style:UITableViewStylePlain];
   
    if (kScreenSize.width>=375) {
        self.tableView.rowHeight=120;
    }
    
    
    
    else{
    
     self.tableView.rowHeight = 80;
    
    }
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.Tytp isEqualToString:kHotTytp]) {
        
        static NSString *cellId = @"HotCell";
        HotCell *cell1=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell1) {
            cell1=[[[NSBundle mainBundle]loadNibNamed:@"HotCell" owner:self options:nil]lastObject];
        }
    
        NewestModel *model=_dataArr[indexPath.row];


        [cell1 showWithModel:model];
      
        return cell1;
    }
    else{

        static NSString *ce = @"MyCell";

        
        MyCell *cell=[tableView dequeueReusableCellWithIdentifier:ce];
        
        if (!cell) {
              cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:self options:nil]lastObject];
                 }
        
    NewestModel *model=_dataArr[indexPath.row];
    cell.Tytp=self.Tytp;
    
        [cell showWithModel:model];
         return cell;

  }
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    WebViewController *web=[[WebViewController alloc]init];
    NewestModel *model=_dataArr[indexPath.row];
    
    if ([self.Tytp isEqualToString:kZuiXinTytP]) {
         web.RequestURL=model.newsLink;
        
    }else{
        web.RequestURL=model.postLink;
    
    
    }    
     web.urlTytp=self.Tytp;
     [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:web animated:YES completion:nil];


}


#pragma mark-刷新

- (void)creatRefreshView{
    __weak typeof (self)mySelf=self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (mySelf.isRefreshing) {
            return ;
        }
        
        mySelf.isRefreshing=YES;
        mySelf.currentPage=0;
        
        [mySelf addTaskUrl:mySelf.requestUrl isRefresh:YES];
        
    }];
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        if (mySelf.isLoadMoring) {
            return ;
        }mySelf.isLoadMoring=YES;
        mySelf.currentPage+=10;
        [mySelf addTaskUrl:mySelf.requestUrl isRefresh:YES];
        
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



- (void)firstDownload{
 
    _isLoadMoring=NO;
    _isRefreshing=NO;
    _currentPage=0;
    
    [self addTaskUrl:self.requestUrl isRefresh:NO];
}

#pragma mark-下载数据

- (void)addTaskUrl:(NSString *)url isRefresh:(BOOL)isRefresh;{
    __weak typeof (self)weakSelf=self;
    NSString*str=[NSString stringWithFormat:url,self.currentPage];
    BOOL isExist=[[NSFileManager defaultManager]fileExistsAtPath:[LZXHelper getFullPathWithMyCacheFile:str]];
    BOOL isTime=[LZXHelper isTimeOutFile:str time:60*60];
    if (isRefresh==NO&&isExist==YES&&isTime==NO) {

        NSData *data=[NSData dataWithContentsOfFile:[LZXHelper getFullPathWithMyCacheFile:str]];
        
        
        if ([self.Tytp isEqualToString:kZuiXinTytP]) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr=dict[@"newsList"];
            for (NSDictionary *dict in arr) {
                NewestModel *model=[[NewestModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [weakSelf.dataArr addObject:model];
            }
        }
        
        else if ([self.Tytp isEqualToString:kHotTytp]){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr=dict[@"postList"];
            
            for (NSDictionary *dict in arr) {
                NewestModel *model=[[NewestModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [weakSelf.dataArr addObject:model];
            }
            
            
            
        }
        
        
        else{
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr=dict[@"postList"];
            
            for (NSDictionary *dict in arr) {
                NewestModel *model=[[NewestModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [weakSelf.dataArr addObject:model];
            }
            
            
        }
        
        
        
        [weakSelf.tableView reloadData];
          return;

        
    }

    
    
    



  [_manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            
            if (weakSelf.currentPage==0) {
            [weakSelf.dataArr removeAllObjects];
                NSData *data=(NSData*)responseObject;
                NSString *filePath=[LZXHelper getFullPathWithMyCacheFile:str];
                [data writeToFile:filePath atomically:YES];
                
                
            }
            if ([self.Tytp isEqualToString:kZuiXinTytP]) {
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray *arr=dict[@"newsList"];
                for (NSDictionary *dict in arr) {
                    NewestModel *model=[[NewestModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArr addObject:model];
                    }
            }
            
            else if ([self.Tytp isEqualToString:kHotTytp]){
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray *arr=dict[@"postList"];
                
                for (NSDictionary *dict in arr) {
                    NewestModel *model=[[NewestModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArr addObject:model];
                }
                

            
            }
            
            
            else{
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray *arr=dict[@"postList"];
                
                for (NSDictionary *dict in arr) {
                    NewestModel *model=[[NewestModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArr addObject:model];
                }

                
                }
            
            
            
                      [weakSelf.tableView reloadData];
            
            [self endRefreshing];
       
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
     
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
