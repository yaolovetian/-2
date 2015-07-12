//
//  UIImageView+DKMUimageView.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyImageView)(UIImageView*Myblok);
@interface UIImageView (DKMUimageView)


-(void)showAddAction:(MyImageView)Block;

@end
