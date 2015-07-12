//
//  UILabel+Event.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-19.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
typedef void (^myLabelBlock)();
#import <UIKit/UIKit.h>

@interface UILabel (Event)


-(void)showWithBlock:(myLabelBlock)block;
@end
