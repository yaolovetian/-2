//
//  HotCell.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewestModel.h"
@interface HotCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *TalkLabel;
@property (weak, nonatomic) IBOutlet UILabel *LickLabel;

-(void)showWithModel:(NewestModel*)model;

@end
