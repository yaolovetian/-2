//
//  HotViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 黄开. All rights reserved.
//

#import "TalkHotViewController.h"
#import "NewestModel.h"
#import "HotCell.h"
@interface TalkHotViewController ()

@end

@implementation TalkHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatRefreshView];
    [self firstDownload];
  
      if (kScreenSize.width>=375) {
        self.tableView.rowHeight=120;
      }else{
          self.tableView.rowHeight=80;

      }
  
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
