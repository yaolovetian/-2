//
//  PriceModel.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "DKModel.h"

@interface PriceModel : DKModel

@property(nonatomic,copy)NSNumber*eventId;
@property(nonatomic,copy)NSNumber*eventInterest;
@property(nonatomic,copy)NSNumber*eventType;
@property(nonatomic,copy)NSNumber*eventPostId;
@property(nonatomic,copy)NSNumber*eventStatus;
@property(nonatomic,copy)NSString*eventTitle;
@property(nonatomic,copy)NSString*eventSmallImg;
@property(nonatomic,copy)NSString*eventPlace;
@property(nonatomic,copy)NSString*eventLink;
@property(nonatomic,copy)NSString*eventTime;
@property(nonatomic,copy)NSString*eventEndTime;
@property(nonatomic,copy)NSString*eventBigImg;


//"eventId": 446,
//"eventTitle": "爱卡免费送U盘、折叠桌等奖品，还包邮。",
//"eventSmallImg": "http://pic4.xcarimg.com/img/news_photo/2015/06/11/m_0umTjQee69143400714511541434007145.jpg",
//"eventBigImg": "http://pic4.xcarimg.com/img/news_photo/2015/06/11/0umTjQee69143400714511541434007145.jpg",
//"eventOwner": "爱卡活动专员",
//"eventPlace": "全国",
//"eventInterest": 8888,
//"eventType": 1,
//"eventPostId": 0,
//"eventLink": "http://a.xcar.com.cn/huodong/201505/freegift/?",
//"statisticsUrl": "",
//"eventTime": "2015-06-12 12:00:00",
//"eventEndTime": "2015-06-18 00:00:00",
//"eventStatus": 1
@end
