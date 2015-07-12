//
//  BaseViewController.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "JHRefresh.h"
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSInteger _currentPage;
    BOOL _isRefreshing;
    BOOL _isLoadMoring;
    
    AFHTTPRequestOperationManager *_manager;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic)NSInteger currentPage;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMoring;
@property (nonatomic,copy) NSString *Tytp;
@property (nonatomic,copy) NSString *requestUrl;
- (void)creatRefreshView;
//结束刷新
- (void)endRefreshing;
- (void)firstDownload;
//增加下载任务
- (void)addTaskUrl:(NSString *)url isRefresh:(BOOL)isRefresh;

@end
