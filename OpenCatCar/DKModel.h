//
//  DKModel.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKModel : NSObject
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
-(id)valueForUndefinedKey:(NSString *)key;


@end
