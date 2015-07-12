//
//  MyViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-7.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "DepreciateViewController.h"
#import "TalkHotViewController.h"
#import "ForumViewController.h"
#import "NewestViewController.h"
#import "NewsViewController.h"
#import "NewsCarViewController.h"
#import "ThanViewController.h"
#import "MarketViewController.h"
#import "VideoViewController.h"
#import "EvaluatingViewController.h"
#import "ContainerViewController.h"
#import "TytpTalkViewController.h"
#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creat];
}

-(void)creat{
  NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSArray *picArr=@[@"tabbar_news@2x",@"tabbar_picture@2x",@"tabbar_setting@2x"];
    NSArray *selectArr=@[@"tabbar_news_hl@2x",@"tabbar_picture_hl@2x",@"tabbar_setting_hl@2x"];
    NSArray *arr1=@[@"NewestViewController",@"NewsViewController",@"NewsCarViewController",@"ThanViewController",@"MarketViewController",@"VideoViewController",@"EvaluatingViewController"];
    NSMutableArray *arr2=[[NSMutableArray alloc]init];
    
    NSArray *title=@[@"最新",@"新闻",@"新车",@"对比",@"新车上市",@"视频",@"车辆评测"];
    NSArray *Urls=@[kZuiXin,kXinWen,kXinChe,kDuiBi,kShangShi,kShiPin,kPingCe];
    
    
    for (NSInteger i=0; i<7; i++) {
        
        Class vccClass=NSClassFromString(arr1[i]);
        BaseViewController *vc=[[vccClass alloc]init];
        vc.Tytp=kZuiXinTytP;
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
        vc.requestUrl=Urls[i];
        
        vc.title=title[i];
        [arr2 addObject:nav];
        
    }
    
    ContainerViewController *containerController = [[ContainerViewController alloc] init];
    
    UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:containerController];
    containerController.viewControllers = arr2;
    
    containerController.title=@"最新";
    
   containerController.tabBarItem.image=[UIImage imageNamed:picArr[0]];
  containerController.tabBarItem.selectedImage=[UIImage imageNamed:selectArr[0]];
    
  //  UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:containerController];
    
    //[nav setNavigationBarHidden:YES animated:YES];
    
    [arr addObject:na];

    

    NSArray *HotArr=@[kLuntan,kReTie,kFound];
    NSArray*titleHot=@[@"精选",@"热帖",@"找论坛"];
    NSMutableArray *arr3=[[NSMutableArray alloc]init];
    NSArray*controller=@[@"ForumViewController",@"TalkHotViewController",@"TytpTalkViewController"];
    NSArray *tytpArr=@[kLunTanTytp,kHotTytp,kFoundTytp];
    for (NSInteger i=0; i<HotArr.count; i++) {
        
        Class vccClass=NSClassFromString(controller[i]);
        BaseViewController *vcc=[[vccClass alloc]init];
        
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vcc];
        vcc.requestUrl=HotArr[i];
        vcc.Tytp=tytpArr[i];
        vcc.title=titleHot[i];
        [arr3 addObject:nav];
        
    }
    
    ContainerViewController *container = [[ContainerViewController alloc] init];
    
   
    container.viewControllers = arr3;
    
    
    container.title=@"论坛";
    container.tabBarItem.image=[UIImage imageNamed:picArr[2]];
   container.tabBarItem.selectedImage=[UIImage imageNamed:selectArr[2]];
    
    [arr addObject:container];

    
    DepreciateViewController *vc=[[DepreciateViewController alloc]init];
    
    vc.title=@"降价";
    vc.requestUrl=kJiangJia;
    
    vc.tabBarItem.image=[UIImage imageNamed:picArr[1]];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectArr[1]];
    
    [arr addObject:vc];
    
    


    
    
    
    
    self.viewControllers=arr;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  }

@end
