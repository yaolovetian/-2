//
//  MyCollectionCell.m
//  OpenCatCar
//
//  Cr/Users/qianfeng/Desktop/OpenCatCar/OpenCatCar.xcodeprojeated by qianfeng on 15-6-18.
//  Copyright (c) 2015年 黄开. All rights reserved.
//4

#import "MyCollectionCell.h"

@implementation MyCollectionCell

- (void)awakeFromNib {
    
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=5;
   
}
-(void)showWith:(NewestModel *)model{
 
    self.titleLabel.text=model.forumName;

}


@end
