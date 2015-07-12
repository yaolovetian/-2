//
//  NewestModel.h
//  OpenCatCar
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "DKModel.h"

@interface NewestModel : DKModel
@property(nonatomic,copy)NSNumber *newsId;
@property(nonatomic,copy)NSNumber *isSpread;
@property(nonatomic,copy)NSNumber *newsType;
@property(nonatomic,copy)NSNumber *commentCount;
@property(nonatomic,copy)NSNumber *newsCreateTime;
@property(nonatomic,copy)NSString *newsTitle;
@property(nonatomic,copy)NSString *newsLink;
@property(nonatomic,copy)NSString *webLink;
@property(nonatomic,copy)NSString *newsCategory;
@property(nonatomic,copy)NSString *newsImage;
@property(nonatomic,copy)NSString *imgURL;
@property (nonatomic, copy) NSString *postTitle;
@property (nonatomic, copy) NSString *forumName;
@property (nonatomic, copy) NSNumber *replyCount;
@property (nonatomic, copy) NSString *postImage;
@property (nonatomic, copy) NSString *postLink;
@property(nonatomic,copy)NSString *focusLink;
@property (nonatomic, copy) NSNumber *replyDate;
@property (nonatomic, copy) NSNumber *forumId;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *letter;
@property (nonatomic, copy) NSNumber *type;
//"newsId": 1814912,
//"newsTitle": "新埃尔法总工程师吉岡憲一：强调存在感",
//"newsLink": "http://a.xcar.com.cn/interface/6.0/getNewsDetails.php?newsid=1814912&put_time=201506",
//"webLink": "http://info.xcar.com.cn/201506/news_1814912_1.html",
//"isSpread": 0,
//"newsType": 2,
//"newsCategory": "爱卡访谈室",
//"newsCreateTime": 1433865600,
//"newsImage": "http://pic.xcarimg.com/img/07news/201506/LmZ4tRCz3M143392874538381433928745.jpg-200x150.jpg",
//"commentCount": 155
@end
