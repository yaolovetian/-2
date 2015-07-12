//
//  newestViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "NewestViewController.h"
#import "ADView.h"
#define kUrl1 @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=1&ver=6.1.3&"
@implementation NewestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatRefreshView];
    [self firstDownload];
  
    ADView *heardView=[[ADView alloc]init];
    if (kScreenSize.width>=375) {
        heardView.frame=CGRectMake(0, 0, 320,220);

    }else{
     heardView.frame=CGRectMake(0, 0, 320,160);
    
    }
    
      
    [heardView downloadDataWithPage1:YES];
    self.tableView.tableHeaderView=heardView;
    
    
  }

- (void)firstDownload{
    
    _isLoadMoring=NO;
    _isRefreshing=NO;
    _currentPage=0;
    
    [self addTaskUrl:self.requestUrl isRefresh:NO];
}



- (void)creatRefreshView{
    __weak typeof (self)mySelf=self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (mySelf.isRefreshing) {
            return ;
        }
        mySelf.tableView.tableHeaderView=nil;
        
        ADView *heardView=[[ADView alloc]init];
        if (kScreenSize.width>=375) {
            heardView.frame=CGRectMake(0, 0, 320,220);
            
        }else{
            heardView.frame=CGRectMake(0, 0, 320,160);
            
        }
        
        
        
        [heardView downloadDataWithPage1:YES];
        mySelf.tableView.tableHeaderView=heardView;
        
        
        
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


/*
 - (void)creatRefreshView{
 __weak typeof (self)mySelf=self;
 [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
 if (mySelf.isRefreshing) {
 return ;
 }
 //        if (mySelf.tableView.tableHeaderView) {
 //            mySelf.tableView.tableHeaderView=nil;
 //        }
 
 ADView *heardView=[[ADView alloc]initWithFrame:CGRectMake(0, 0, 320,160)];
 [heardView downloadDataWithPage1:NO];
 
 
 mySelf.tableView.tableHeaderView=heardView;
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
 



*/
@end
