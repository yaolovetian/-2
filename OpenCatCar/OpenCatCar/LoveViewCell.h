//
//  LoveViewCell.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-20.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "NewestModel.h"
#import <UIKit/UIKit.h>

@interface LoveViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

-(void)showWithModel:(NewestModel*)model;



@end
