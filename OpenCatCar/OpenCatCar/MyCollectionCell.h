//
//  MyCollectionCell.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-18.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewestModel.h"
@interface MyCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)showWith:(NewestModel *)model;


@end
