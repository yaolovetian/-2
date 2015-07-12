//
//  MyPriceViewCell.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "DepreciateViewController.h"
#import "UMSocial.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MyPriceViewCell.h"
@interface MyPriceViewCell()<UMSocialUIDelegate>

{    NSInteger count;
    AFHTTPRequestOperationManager*_maneger;
}

@end
@implementation MyPriceViewCell

- (void)awakeFromNib {
    _maneger=[AFHTTPRequestOperationManager manager];
    _maneger.responseSerializer=[AFHTTPResponseSerializer serializer];
    self.likeButton.layer.masksToBounds = YES;
    self.likeButton.layer.cornerRadius = 5;
    self.shareButton.layer.masksToBounds = YES;
    self.shareButton.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  }


-(void)showWithModel:(PriceModel *)model{
    if (kScreenSize.width) {
    
    }
    self.myModel=model;
    self.TitleLabel.text=model.eventTitle;
    self.EndeTimeLabel.text=[NSString stringWithFormat:@"活动截止时间:%@",model.eventEndTime];
    self.placeLabel.text=[NSString stringWithFormat:@"活动地点:%@",model.eventPlace];
    
    NSString*like=[NSString stringWithFormat:@"%ld人感兴趣",model.eventInterest.intValue+count];
    [self.SmallImageView sd_setImageWithURL:[NSURL URLWithString:model.eventBigImg] placeholderImage:[UIImage imageNamed:kOpenCat]];

    [self.likeButton setTitle:like forState:UIControlStateNormal];
    
    [self.shareButton setTitle:@"分享给好友" forState:UIControlStateNormal];
}




- (IBAction)likeClick:(UIButton *)sender {
    
    NSString *url=[NSString stringWithFormat:kLike,self.myModel.eventId];
    count++;
    NSString*like=[NSString stringWithFormat:@"%ld人感兴趣",self.myModel.eventInterest.intValue+count];
    [self.likeButton setTitle:like forState:UIControlStateNormal];

   // for (NSInteger i=0; i<1000; i++) {
        
    [_maneger GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//       NSDictionary *downDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//     

       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   
   }];
    
  
     //  }
    
}

-(void)showWith:(myButtonBlock)block{

    self.MyBlock=block;

}

- (IBAction)shareClick:(UIButton *)sender {

    if (self.MyBlock) {
        self.MyBlock(self);
    }
    
}

-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}











@end
