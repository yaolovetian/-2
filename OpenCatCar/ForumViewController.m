//
//  ForumViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "ForumViewController.h"
#import "ADView.h"
@interface ForumViewController ()

@end

@implementation ForumViewController

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
    
    
    
    [heardView downloadDataWithPage1:NO];
    
    
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
//        if (mySelf.tableView.tableHeaderView) {
//            mySelf.tableView.tableHeaderView=nil;
//        }
        
        ADView *heardView=[[ADView alloc]init];
        if (kScreenSize.width>=375) {
            heardView.frame=CGRectMake(0, 0, 320,220);
            
        }else{
            heardView.frame=CGRectMake(0, 0, 320,160);
            
        }
        
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
