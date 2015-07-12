//
//  ADView.m
//  UITableView_Cell定制
//
//  Created by LZXuan on 14-12-18.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//
#import "MyControl.h"
#import "ADView.h"
#import "UIImageView+WebCache.h"
#import "LZXHttpRequest.h"
#define kUrl1 @"http://mapi.damai.cn/hot201303/nindex.aspx?cityid=0&source=10099&version=30602"
#define kScreenSize [UIScreen mainScreen].bounds.size
@implementation ADView
{
    NSMutableArray *_dataArr1;//数据源数组
    LZXHttpRequest*_httpRequest1;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *imageView;
}
//非arc
- (void)dealloc {
  
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self crat1];
      
              }
    return self;
}

-(void)showDataWithModel1:(DaMaiModel *)model{
    self.Pic=model.imgURL;
    
 
   [self creatView];
    
}


- (void)creatView {
   
    static NSInteger i=0;
   


       imageView= [[UIImageView alloc] initWithFrame:CGRectMake(i, 0, kScreenSize.width, 160)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.Pic] placeholderImage:nil];

[_scrollView addSubview:imageView];
   i= i+kScreenSize.width;
    
  
}
    -(void)crat1{
       _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 160)];
       //下面设置滚动视图
    _scrollView.contentSize = CGSizeMake(6*kScreenSize.width, 160);
    _scrollView.showsVerticalScrollIndicator = NO;
    //按页
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
        
    [self addSubview:_scrollView];
    //页码器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 160-30, kScreenSize.width, 30)];
    _pageControl.numberOfPages = 4;
    
    [_pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
        imageView.userInteractionEnabled=YES;
        
        UIImageView*imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0,120, 320, 40)];
        imageView1.userInteractionEnabled=YES;
        //lable.text=[NSString stringWithFormat:@"图片1的标题"];
        //lable.tag=201;
        imageView1.image=[UIImage imageNamed: @"标签背景"];

        NSArray *arr=@[@"推荐",@"话剧榜",@"摇滚榜",@"热门榜"];
        for (NSInteger i=0; i<4; i++) {
            UIButton *button=[MyControl creatButtonWithFrame:CGRectMake(0+i*80, 0,80, 40) target:self sel:@selector(btnClick:) tag:101 image:nil title:arr[i]];
            
            button.titleLabel.font=[UIFont systemFontOfSize:14];
          [button setBackgroundImage:[UIImage imageNamed:@"首页选中"] forState:UIControlStateSelected];
            
      // [button setBackgroundImage:[UIImage imageNamed:@"首页选中"] forState:UIControlStateNormal];
            
        [imageView1 addSubview:button];

        }
        
//        UIButton *button=[MyControl creatButtonWithFrame:CGRectMake(0, 0, 80, 40) target:self sel:@selector(btnClick:) tag:101 image:@"首页选中" title:nil];
// [button setTitle:@"点我" forState:UIControlStateNormal];
//        //button.uicontrol
//
//        [imageView addSubview:button];
        [self addSubview:imageView1];

      
        
    
    }


-(void)btnClick:(UIButton *)button{
    NSLog(@"asdasd");


}


- (void)pageClick:(UIPageControl *)page {
    //修改滚动视图的偏移量
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*page.currentPage, 0) animated:YES];
}
//减速停止的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //修改页码
    CGPoint offset = _scrollView.contentOffset;
    _pageControl.currentPage = offset.x/_scrollView.bounds.size.width;
}



//- (void)downloadDataWithPage1 {
//    _dataArr1 = [[NSMutableArray alloc] init];
//    _httpRequest1 = [[LZXHttpRequest alloc] init];
//    NSString *url = [NSString stringWithFormat:kUrl1];
//  
//    __block ADView*myself=self;
//    [_httpRequest1 downloadDataWithUrl:url succes:^(LZXHttpRequest *httpRequest) {
//        [myself downloadDataSuccessWithRequest1:httpRequest];
//    } failed:^(NSError *error) {
//
//    }];
//
//
//
//}
//
//
//- (void)downloadDataSuccessWithRequest1:(LZXHttpRequest *)httpRequest {
//
//    if (httpRequest.downloadData) {
//        //有数据
//        //二进制数据 json 格式 要json解析
//        //最外层是字典
//        NSArray *userArr= [NSJSONSerialization JSONObjectWithData:httpRequest.downloadData options:NSJSONReadingMutableContainers error:nil];
//
//        for (NSDictionary*userDict in userArr) {
//            //数组中是字典
//            //把每个字典数据放在model中
//           // DaMaiModel *model = [[DaMaiModel alloc] init];
//
//          //  model.Name = userDict[@"Name"];
//          //  model.Url = userDict[@"Url"];
//
//           // model.ProjType=userDict[@"ProjType"];
//          [_dataArr1 addObject: userDict[@"Pic"]];
//           // model.ProjectID=userDict[@"ProjectID"];
//
//            //[_dataArr1 addObject:model];
//                       //[model release];
//        }
//        
//            [self creatView];
//    
//        //[self. reloadData];
//    }
//}
//


@end
