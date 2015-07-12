//
//  ADView.h
//  UITableView_Cell定制
//
//  Created by LZXuan on 14-12-18.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
#import "NewestModel.h"
//广告位 视图  按页显示
@interface ADView : UIView <UIScrollViewDelegate>

{
    NSMutableArray *_dataArr;
    NSMutableArray *_requesetArr;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    AFHTTPRequestOperationManager*_manager;
    
}
@property (nonatomic,copy)NSMutableArray *TytpArr;
@property (nonatomic,copy)NSMutableArray *requesetArr;
@property (nonatomic,copy)NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *ProjectID;
@property (nonatomic, copy) NSString *Pic;
@property (nonatomic,copy) NSString *Tytp;
@property (nonatomic, copy) NSString *Url;
- (void)downloadDataWithPage1 :(BOOL)Title;

@end
