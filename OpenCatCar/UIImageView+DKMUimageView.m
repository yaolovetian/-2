//
//  UIImageView+DKMUimageView.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import <objc/runtime.h>
#import "UIImageView+DKMUimageView.h"
@interface UIImageView()
{
    MyImageView _MyBlock;
}
@property(nonatomic,copy)MyImageView MyBlock;
@end
@implementation UIImageView (DKMUimageView)


-(void)setMyBlock:(MyImageView)MyBlock{

    objc_setAssociatedObject(self, @"MyBlock", MyBlock, OBJC_ASSOCIATION_COPY);
}
-(MyImageView)MyBlock{

    return objc_getAssociatedObject(self, @"MyBlock");
}


-(void)showAddAction:(MyImageView)Block{
    self.userInteractionEnabled=YES;
    self.MyBlock=Block;

}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.MyBlock) {
        self.MyBlock(self);
    }

}

@end
