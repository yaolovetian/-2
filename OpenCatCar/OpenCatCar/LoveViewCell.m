//
//  LoveViewCell.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-20.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "LoveViewCell.h"

@implementation LoveViewCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)showWithModel:(NewestModel *)model{

   // [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    
    self.titleLabel.text=model.forumName;
    

}



@end
