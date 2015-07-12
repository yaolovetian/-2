//
//  ADView.m
//  UITableView_Cell定制
//
//  Created by LZXuan on 14-12-18.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//
#import "WebViewController.h"
#import "UIImageView+DKMUimageView.h"
#import "MyControl.h"
#import "ADView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#define kUrl1 @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=1&ver=6.1.3&"
#define kUrl2 @"http://mi.xcar.com.cn/interface/xcarapp/getSelectedPostList.php?limit=20&offset=0&ver=6.1.3&"
@implementation ADView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager=[AFHTTPRequestOperationManager manager];
        _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
       
      
    }
    return self;
}


- (void)creatView :(BOOL)heihei{
    
    NSInteger h;
    
    if (kScreenSize.width>=375) {
        h=220;
    }else{
    
        h=160;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width,h)];
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, h)];
        [imageView showAddAction:^(UIImageView *Myblok) {
         
            WebViewController *web=[[WebViewController alloc]init];
            web.RequestURL=self.requesetArr[i];
           
//            if (heihei==YES) {
//                
//                
//                
//             self.Tytp=kZuiXinTytP;
//                 
//                web.tytpArr=[NSMutableArray arrayWithArray:self.TytpArr];
//                
//            }else{
//                self.Tytp=kHotTytp;
//            
//            }
//            
//            web.urlTytp=self.Tytp;
            
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:web animated:YES completion:nil];
            
            
        }];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataArr[i]] placeholderImage:nil];
        
        [_scrollView addSubview:imageView];
        // [imageView release];
    }
    //下面设置滚动视图
    _scrollView.contentSize = CGSizeMake(5*kScreenSize.width, h);
    _scrollView.showsVerticalScrollIndicator = NO;
    //按页
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
    //页码器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, h-30, kScreenSize.width, 30)];
    _pageControl.numberOfPages = 5;
    
    [_pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
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



- (void)downloadDataWithPage1 :(BOOL)Title{
    _dataArr = [[NSMutableArray alloc] init];
    _requesetArr=[[NSMutableArray alloc]init];
    _TytpArr=[[NSMutableArray alloc]init];
   __block ADView*myself=self;
    if (Title==YES) {
        
    
    [_manager GET:kUrl1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
           NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *dict1 =dict[@"focusList"];
                
                NSArray *arr=dict1[@"focusImgs"];
          
                for (NSDictionary *dictImage in arr) {
                    
                    [myself.dataArr addObject:dictImage[@"imgURL"]];
                    [myself.requesetArr addObject:dictImage[@"newsLink"]];
                    
                    [myself.TytpArr addObject:dictImage[@"type"]];
                }
            
            [self creatView:YES];
       
            
          
        
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    }];
    
   
    }else{
    
        
        [_manager GET:kUrl2 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject) {
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
                
                NSArray *arr=dict[@"focusPost"];
                
                for (NSDictionary *dictImage in arr) {
                    
                    [myself.dataArr addObject:dictImage[@"focusImage"]];
                       [myself.requesetArr addObject:dictImage[@"focusLink"]];
                    
                }
                
                
                
                [self creatView:NO];
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];

    
    
    }
    
    
    
    

}




@end
