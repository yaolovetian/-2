//
//  ADView.h
//  UITableView_Cell定制
//
//  Created by LZXuan on 14-12-18.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaMaiModel.h"
//广告位 视图  按页显示
@interface ADView : UIView <UIScrollViewDelegate>

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *ProjectID;
@property (nonatomic, copy)  NSString *Pic;
@property (nonatomic, copy) NSString *ProjType;
@property (nonatomic, copy) NSString *Url;

-(void)showDataWithModel1:(DaMaiModel*)model;
@end
