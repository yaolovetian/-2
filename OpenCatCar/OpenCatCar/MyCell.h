//
//  MyCell.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewestModel.h"
@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *LikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;
@property(nonatomic,copy)NSString *Tytp;

@property (weak, nonatomic) IBOutlet UIImageView *firstTotalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondTotalImageView;



-(void)showWithModel:(NewestModel*)model;

@end
