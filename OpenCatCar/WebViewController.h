//
//  WebViewController.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property(nonatomic,copy)NSString *RequestURL;
@property(nonatomic,copy)NSString*urlTytp;
@property(nonatomic,strong)NSArray *tytpArr;
@end
