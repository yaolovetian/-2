//
//  TytpTalkViewController.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-18.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "BaseViewController.h"

@interface TytpTalkViewController : BaseViewController
@property (nonatomic,copy) NSString *requestUrl;
@property(nonatomic,strong)NSMutableArray *tableArr;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSMutableArray *loveCarArr;
@property(nonatomic,strong)NSMutableArray *loveTitleArr;
@property(nonatomic,strong)NSMutableArray *nextArr;
@property(nonatomic,strong)UITableView *loveTableView;
@property(nonatomic,strong)UITableView *tytpTableView;
@property(nonatomic,strong)NSMutableArray *nextTitleArr;
@property(nonatomic,strong)NSMutableArray *tytpArr;
@end
