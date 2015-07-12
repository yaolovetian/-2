//
//  UILabel+Event.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-19.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import <objc/runtime.h>
#import "UILabel+Event.h"
@interface UILabel()
{

    myLabelBlock myBlock;
    
}
@property(nonatomic,copy)myLabelBlock myBlock;

@end

@implementation UILabel (Event)

-(void)setMyBlock:(myLabelBlock)myBlock{
  objc_setAssociatedObject(self, @"myBlock", myBlock, OBJC_ASSOCIATION_COPY);
    
    //objc_setAssociatedObject(self,@"myBlock",myBlock, OBJC_ASSOCIATION_COPY);
    
}

-(myLabelBlock)myBlock{

    return objc_getAssociatedObject(self, @"myBlock");

}

-(void)showWithBlock:(myLabelBlock)block{
    

    self.myBlock=block;

}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    if (self.myBlock) {
        self.myBlock();
    }

}

@end
