//
//  MyPriceViewCell.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
typedef void (^myButtonBlock)(UITableViewCell*block);
#import <UIKit/UIKit.h>
#import "PriceModel.h"
@interface MyPriceViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *SmallImageView;

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

-(void)showWithModel:(PriceModel*)model;
@property (weak, nonatomic) IBOutlet UILabel *EndeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
- (IBAction)likeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction)shareClick:(UIButton *)sender;

@property(nonatomic,strong)PriceModel *myModel;
@property(nonatomic,copy)myButtonBlock MyBlock;

-(void)showWith:(myButtonBlock)block;

@end
