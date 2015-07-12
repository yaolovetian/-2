//
//  MyTytpViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-18.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "HotCell.h"
#import "WebViewController.h"
#import "NewestModel.h"
#import "MyTytpViewController.h"

@interface MyTytpViewController ()

@end

@implementation MyTytpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame=CGRectMake(0,64, kScreenSize.width, kScreenSize.height-64-49);
    self.view.backgroundColor=[UIColor colorWithRed:255/255.0 green:248/255.0 blue:220/255.0 alpha:1];
    
    [self creatButton];
    [self firstDownload];

}

-(void)creatButton{

    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(20, 30, 30, 30);
    //button.backgroundColor=[UIColor greenColor];
    
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

}

-(void)btnClick:(UIButton*)btn{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];


}


- (void)firstDownload{
    
    _isLoadMoring=NO;
    _isRefreshing=NO;
    _currentPage=0;
    
    [self addTaskUrl:kFoundURl isRefresh:NO];
}




-(void)addTaskUrl:(NSString *)url isRefresh:(BOOL)isRefresh{

    __weak typeof(self) mySelf=self;
    
    NSString *str=[NSString stringWithFormat:kFoundURl,self.requestUrl,self.currentPage];
  
    
 [_manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     
     if (mySelf.currentPage==0) {
         
        [mySelf.dataArr removeAllObjects];
         
     }

     
     NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
     NSArray *arr=dict[@"postList"];
     
     
     
     for (NSDictionary *dictTytp in arr) {
         
         NewestModel *model=[[NewestModel alloc]init];
         [model setValuesForKeysWithDictionary:dictTytp];
         
         
         [mySelf.dataArr addObject:model];
         
         
         
        }
     
     [self.tableView reloadData]
     ;
      [self endRefreshing];
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
 }];
    
    


}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellId = @"HotCell";
    HotCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HotCell" owner:self options:nil]lastObject];
    }

    
    NewestModel *model=self.dataArr[indexPath.row];
    
    
    [cell showWithModel:model];
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    NewestModel *model=self.dataArr[indexPath.row];
    
    WebViewController *web=[[WebViewController alloc]init];
    
    web.RequestURL=model.postLink;
    
    
    [self presentViewController:web animated:YES completion:nil];
    

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
