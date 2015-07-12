//
//  MyCell.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "MyCell.h"
#import "UIImageView+WebCache.h"
@implementation MyCell

- (void)awakeFromNib {
    self.IconImageView.layer.masksToBounds=YES;
    self.IconImageView.layer.cornerRadius=3;
    
}


-(void)showWithModel:(NewestModel *)model{
   
    self.TitleLable.font = [UIFont fontWithName:@"Yuppy SC" size:14];
    self.TimeLable.font = [UIFont fontWithName:@"Yuppy SC" size:12];
    self.TypeLabel.font = [UIFont fontWithName:@"Yuppy SC" size:14];
     self.LikeLabel.font = [UIFont fontWithName:@"Yuppy SC" size:12];
    
    
    if ([self.Tytp isEqualToString:kZuiXinTytP]) {
        
     [self.IconImageView sd_setImageWithURL:[NSURL URLWithString:model.newsImage] placeholderImage:[UIImage imageNamed:kOpenCat]];
        
    
        
    self.TitleLable.text=model.newsTitle;
    NSDate *nate=[[NSDate alloc]initWithTimeIntervalSince1970:model.newsCreateTime.intValue];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    
    df.dateFormat=@"yyyy-MM-dd";
    NSString *dateStr=[df stringFromDate:nate];
    
    self.TimeLable.text=[NSString stringWithFormat:@"%@",dateStr];

    self.TypeLabel.text=model.newsCategory;
    NSString *Comment=[NSString stringWithFormat:@"%@",model.commentCount];
        
    if (Comment.length==0) {
        self.LikeLabel.text=nil;
      
      }else{
            self.LikeLabel.text=Comment;
           UIImage *image=[UIImage imageNamed:@"feed_cell_commentIcon@2x"];
        self.firstTotalImageView.image=image;

   
    }
    }else{
        
          UIImage *image=[UIImage imageNamed:@"feed_cell_commentIcon@2x"];
        
     self.secondTotalImageView.image=image;
        [self.IconImageView sd_setImageWithURL:[NSURL URLWithString:model.postImage] placeholderImage:[UIImage imageNamed:kOpenCat]];
        
        self.TitleLable.text=model.postTitle;
        self.TimeLable.text=model.forumName;
        self.TypeLabel.text=[NSString stringWithFormat:@"%@",model.replyCount];

        
    
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
