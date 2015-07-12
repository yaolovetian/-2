//
//  WebViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "MMProgressHUD.h"
#import "UMSocial.h"
#import "WebViewController.h"
#import <WebKit/WebKit.h>
#define kURL @"&p=%ld&type=0&deviceType=android&themeType=white&version=6.1.3&network=wifi&cityId=260"
@interface WebViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
{

    UIWebView *_weView;
    NSInteger _count;
    NSString *_requstStr;
   
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWebView];
    [self creatButton];
    self.view.backgroundColor=[UIColor colorWithRed:255/255.0 green:248/255.0 blue:220/255.0 alpha:1];

   }


-(void)creatWebView{
    
        _weView=[[UIWebView alloc ]initWithFrame:CGRectMake(0,64, kScreenSize.width, kScreenSize.height-49-64)];

    _weView.delegate=self;
    
    _weView.scalesPageToFit = YES;
   
    
    _count=1;
    
    
    dispatch_queue_t queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        _requstStr=[self.RequestURL stringByAppendingString:kURL];
        
        [self requestURL:_requstStr];
        
    });
    [self.view addSubview:_weView];}


-(void)creatButton{
    
    
 

    UIButton *refreshButton=[UIButton buttonWithType:UIButtonTypeSystem];
    refreshButton.frame=CGRectMake(kScreenSize.width-60, 20, 40, 40);
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
  
    [refreshButton addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.tag=103;
    [self.view addSubview:refreshButton];
    
    

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(5,20,45,40);

    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor clearColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(37,26,30, 30)];
    label.textColor=[UIColor colorWithRed:2/255.0 green:122/255.0 blue:247/255.0 alpha:1];
      label.font=[UIFont systemFontOfSize:14];
    label.text=@"返回";
    [self.view addSubview:label];
    

  [button setImage:[UIImage imageNamed:@"Register_Btn_Last@2x"] forState:UIControlStateNormal];
 
    [self.view addSubview:button];
    
    if ([self.urlTytp isEqualToString:kZuiXinTytP]){
        
        return;
    }
    
//    for (NSInteger i=tytp; i<self.tytpArr.count; i++) {
//        NSString *str=[NSString stringWithFormat:@"%@" ,self.tytpArr[i]];
////          NSLog(@"%@",self.tytpArr);
////          NSLog(@"********%@",str);
//        if ([str isEqualToString:@"1"]) {
//            NSLog(@"********%@",str);
//            tytp++;
//            return;
//        }else{
//            
//           
//        }
//        
//        
//    }
//    

    
     NSArray *titles=@[@"上一页",@"下一页"];
    for (NSInteger i=0; i<2; i++) {
        UIButton *button1=[UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame=CGRectMake(kScreenSize.width/2-100+i*101,kScreenSize.height-40,100, 30);
        button1.backgroundColor=[UIColor colorWithRed:111/255.0 green:173/255.0 blue:255/255.0 alpha:1];
        [button1 addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitle:titles[i] forState:UIControlStateNormal];
        button1.tag=101+i;
        button1.layer.masksToBounds=YES;
        button1.layer.cornerRadius=5;
         [self.view addSubview:button1];
    }
    

    
   
}







-(void)requestURL:(NSString *)str{
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    
    
    [MMProgressHUD showWithTitle:@"数据加载中" status:@"请稍等片刻^o^"];
    
    
    
    
    NSString *url=[NSString stringWithFormat:str,_count];
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
    ;
    [_weView loadRequest:request];

    [MMProgressHUD dismissWithSuccess:@"^_^" title:@"加载成功"];

}




-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"aasd");
    
}



- (void)buttonClick:(UIButton *)button {
    
    [self dismissViewControllerAnimated:YES completion:nil];
 
}
- (void)buttonClick1:(UIButton*)btn {
//    if ([self.urlTytp isEqualToString:kZuiXinTytP]){
//    
//        return;
//    }
    
    switch (btn.tag) {
        case 101:
        {
            if (_count==1) {
                
        
            
                return;
            }
            NSLog(@"sadad");
            _count--;
            [self requestURL:_requstStr];

        
        }
            break;
        case 102:
        {
            _count++;
            
            [self requestURL:_requstStr];
            
        }
            break;
        case 103:
        {
          
            
           
            [self requestURL:_requstStr];
            
        }
            break;

        default:
            break;
    }
    


}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
//
    
   // if ([self.urlTytp isEqualToString:kZuiXinTytP])
        
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
     
        
        NSString *str = url.absoluteString;
        
        if ([str containsString:@"type=rate_api"]|[str containsString:@"type=reply_api"]|[str containsString:@"type=report_api"]) {

            return NO;
       }
//        else if([str containsString:@"type=report_api"]){
//            request=nil;
//            
//            NSString *str=@"http://www.baidu.com";
////            NSURLRequest *quest=[NSURLRequest requestWithURL:[NSURL URLWithString:str ]];
////            request =quest;
////            return YES;
//            
//            [self requestURL:str];
//            
//            return NO;
//        
//        }
//        
        
        else
       {
           return YES;
       }
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
