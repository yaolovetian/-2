//
//  HotCell.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "HotCell.h"

@implementation HotCell

- (void)awakeFromNib {
  
//    self.layer.masksToBounds=YES;
//    self.layer.cornerRadius=8;
    self.backgroundColor=[UIColor colorWithRed:201/255.0 green:234/255.0 blue:254/255.0 alpha:1];
    
}

-(void)showWithModel:(NewestModel *)model{

    

   self.TitleLabel.font = [UIFont fontWithName:@"Yuppy SC" size:14];
    self.LickLabel.font = [UIFont fontWithName:@"Yuppy SC" size:12];
    self.TitleLabel.text=model.postTitle;
    self.LickLabel.text=[model.replyCount stringValue];
    self.DateLabel.font=[UIFont fontWithName:@"Yuppy SC" size:12];
    self.TalkLabel.font=[UIFont fontWithName:@"Yuppy SC" size:12];
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:model.replyDate.integerValue];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    df.dateFormat=@"yyyy-MM-dd";
    NSString *dateStr=[df stringFromDate:date];
    
    self.DateLabel.text=dateStr;
    self.TalkLabel.text=model.forumName;

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
