//
//  TytpTalkViewController.m
//  OpenCatCar
//
//  Created by qianfeng on 15-6-18.
//  Copyright (c) 2015年 黄开. All rights reserved.
//
#import "UILabel+Event.h"
#import "NewestModel.h"
#import "MyTytpViewController.h"
#import "TalkHotViewController.h"
#import "NewestModel.h"
#import "TytpTalkViewController.h"
#import "MyCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "LoveViewCell.h"
@interface TytpTalkViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UILabel *_label;
    UICollectionView *_collectionView;
    BOOL _tytp;
    
}

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation TytpTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView.frame=CGRectZero;
    
    [self creatCollectionView];
  
    [self firstDownload];

    
}

-(void)creatCollectionView{
    self.tableArr=[[NSMutableArray alloc]init];
    self.titleArr=[[NSMutableArray alloc]init];
    self.nextArr=[[NSMutableArray alloc]init];
    self.loveCarArr=[[NSMutableArray alloc]init];
    self.loveTitleArr=[[NSMutableArray alloc]init];
    self.tytpArr=[[NSMutableArray alloc]init];
    self.nextTitleArr=[[NSMutableArray alloc]init];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(kScreenSize.width/2-20, 40);
    
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
  

    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, kScreenSize.width, kScreenSize.height-100-64-49)collectionViewLayout:layout];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:self.collectionView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MyCollectionCell"];
    NSArray *arr=@[@"人.车.生活",@"爱车俱乐部"];
    
    for (NSInteger i=0; i<arr.count; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(10+i*kScreenSize.width/2, 20,kScreenSize.width/2-20, 80);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=101+i;
        button.backgroundColor=[UIColor colorWithRed:201/255.0 green:234/255.0 blue:254/255.0 alpha:1];
        [self.view addSubview:button];

    }
    

    self.tableView.rowHeight = 60;
  
    self.tableView.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
   
    

    _label=[[UILabel alloc]initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height)];
    
    _label.backgroundColor=[UIColor blackColor];
    _label.alpha=0.7;
    
    _label.userInteractionEnabled=YES;
    [self.view addSubview:_label];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(10, 5, 30, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view1=[[UIView alloc]init];
    view1.frame=CGRectMake(0, 0, kScreenSize.width, 40);
    [view1 addSubview:button];
    self.tableView.tableHeaderView=view1;

    

    
    [self.view addSubview:self.tableView];
    [self creatLoveTableView];
    
}

-(void)creatLoveTableView{

    self.loveTableView=[[UITableView alloc]initWithFrame:CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    
    
    if (kScreenSize.width>=375) {
        self.loveTableView.rowHeight=120;
    }
    
    
    
    else{
        
       self.loveTableView.rowHeight = 80;
        
    }
    
    self.loveTableView.dataSource=self;
    self.loveTableView.delegate=self;
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(10, 5, 30, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view1=[[UIView alloc]init];
    view1.frame=CGRectMake(0, 0, kScreenSize.width, 40);
    [view1 addSubview:button];
    self.loveTableView.tableHeaderView=view1;
    
    [self.view addSubview:self.loveTableView];
    
  
    
    
}


#pragma mark-collectionView视图

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   

    return self.dataArr.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    MyCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    
    NewestModel *model=_dataArr[indexPath.row];
    
   
  [cell showWith:model];
    cell.backgroundColor = [UIColor colorWithRed:201/255.0 green:234/255.0 blue:254/255.0 alpha:1];

    return cell;
    
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NewestModel *model=self.dataArr[indexPath.row];
    
    MyTytpViewController *tytp=[[MyTytpViewController alloc]init];
    
    NSString *str=[NSString stringWithFormat:@"%@",model.forumId
                   ];
    tytp.requestUrl=str;
   
    [[[[UIApplication sharedApplication]keyWindow]rootViewController] presentViewController:tytp animated:YES completion:nil];

}


-(void)btnClick:(UIButton *)btn{

    switch (btn.tag) {
        case 101:
            
        {
            
            [_label showWithBlock:^{
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    _label.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
                    
                    self.tableView.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
                }];

                
            }];
            
[UIView animateWithDuration:0.5 animations:^{
            
_label.frame=CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
    
    self.tableView.frame=CGRectMake(40, 0,kScreenSize.width, kScreenSize.height-49-55);
           
            }];
            
}
            break;
            
            
        case 102:
        {
           
       
          [_label showWithBlock:^{
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    _label.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
                    
                    self.loveTableView.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
                 
                    
                }];
                
                
            }];
            
            [UIView animateWithDuration:0.5 animations:^{
                
                _label.frame=CGRectMake(0, 0, kScreenSize.width, kScreenSize.height);
                
                self.loveTableView.frame=CGRectMake(40, 0,kScreenSize.width, kScreenSize.height-49-55);
                
                
                
            }];

            
        }
            break;
        default:
            break;
    }

}



-(void)btnClick1:(UIButton *)btn{


    [UIView animateWithDuration:0.5 animations:^{
        
        _label.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
        
        self.loveTableView.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
        self.tableView.frame=CGRectMake(kScreenSize.width, 0, kScreenSize.width, kScreenSize.height);
        
    }];



}

#pragma mark-TableView视图

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.loveTableView) {
     
         return self.nextArr.count;
 
    }
    

    else
    {
    return self.tableArr.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView==self.loveTableView) {
        

      return [self.nextArr[section]count];
      
    }

    
    else{
        

    return [self.tableArr[section]count];
    }
    
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.loveTableView) {
      

        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        }
        

        
        
        NewestModel *model=self.nextArr[indexPath.section][indexPath.row];
        
        
        cell.textLabel.text=model.forumName;

        
      
        return cell;
    }

    
    else{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    

        NewestModel*model=self.tableArr[indexPath.section][indexPath.row];
 
    
    cell.textLabel.text=model.forumName;
    
    
        return cell;}
    
    
    
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView==self.loveTableView) {
      
        //return nil;
        return self.nextTitleArr[section];
    }else
    {
     
        return self.titleArr[section];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.loveTableView) {
  
        
        NewestModel *model=self.nextArr[indexPath.section][indexPath.row];
        MyTytpViewController *tytp=[[MyTytpViewController alloc]init];
        
        NSString *str=[NSString stringWithFormat:@"%@",model.forumId
                       ];
        tytp.requestUrl=str;
        
         CATransition *animation  = [CATransition animation];
           animation.type = @"cube";
        animation.subtype = @"fromLeft";
        animation.duration = 2;
       animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

//        [[[[UIApplication sharedApplication]keyWindow]rootViewController].view.layer addAnimation:animation forKey:nil];
        [[[[UIApplication sharedApplication]keyWindow]rootViewController] presentViewController:tytp animated:YES completion:nil];
//        [self.navigationController.view.layer addAnimation:animation forKey:nil];
//
//         [self.navigationController pushViewController:tytp animated:YES];
//        
    }
    
    
    
    else{
    
    
    NewestModel *model=self.tableArr[indexPath.section][indexPath.row];
    MyTytpViewController *tytp=[[MyTytpViewController alloc]init];
    
    NSString *str=[NSString stringWithFormat:@"%@",model.forumId
                   ];
    tytp.requestUrl=str;
    
    [[[[UIApplication sharedApplication]keyWindow]rootViewController] presentViewController:tytp animated:YES completion:nil];

    }

}



-(void)addReqestUrl:(NSString*)url requestTytp:(BOOL)tytp
{
   
    if (tytp==YES) {
      
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=dict[@"categories"];
        
        for (NSDictionary *dict in arr) {
            
            NSMutableArray *nameArr=[[NSMutableArray alloc]init];
            NSArray *forumsArr=dict[@"forums"];
            for (NSDictionary *forumsDict in forumsArr) {
                NewestModel *model=[[NewestModel alloc]init];
                [model setValuesForKeysWithDictionary:forumsDict];
                
                [nameArr addObject:model];
                
                
            }
         
            [self.titleArr addObject:dict[@"categoryName"]];
            [self.tableArr addObject:nameArr];
           
   
        }
        
        [self.tableView reloadData];
        
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}];
    
    
  }
  
  else{

  [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
   
      NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      NSArray *lettersArr=dict[@"letters"];
      for (NSDictionary *dict in lettersArr) {
       
          NSArray *brandsArr=dict[@"brands"];
           NSMutableArray *arr=[[NSMutableArray alloc]init];
          for (NSDictionary *dict in brandsArr) {
              
              NewestModel *model=[[NewestModel alloc]init];
              [model setValuesForKeysWithDictionary:dict];
              
            [arr addObject:model];
            NSArray *forumsArr=dict[@"forums"];
              NSMutableArray *talkArr=[[NSMutableArray alloc]init];
              for (NSDictionary *dict in forumsArr) {
                  NewestModel *model=[[NewestModel alloc]init];
                  [model setValuesForKeysWithDictionary:dict];
               
                  
                  [talkArr addObject:model];
                  
              }
              
              
              [self.nextArr addObject:talkArr];
                [self.nextTitleArr addObject:dict[@"name"]];
              
          }
          
          [self.loveTitleArr addObject:dict[@"letter"]];
        
          [self.loveCarArr addObject:arr];
          
          
      }
      [self.loveTableView reloadData];
      
      
      
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   
      

  }];
      
      
      
      
  }
    
    
    
    
    
    

}







- (void)firstDownload;{

    [self addTaskUrl:self.requestUrl isRefresh:YES];
    
    [self addReqestUrl:kPersonCar requestTytp:YES];

    [self addReqestUrl:kLoveCar requestTytp:NO];
   }





-(void)addTaskUrl:(NSString *)url isRefresh:(BOOL)isRefresh{
   
 __weak typeof (self)mySelf=self;
[_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSArray *arr=dict[@"forums"];
    for (NSDictionary *titleDict in arr) {
        
        NewestModel *model=[[NewestModel alloc]init];
        [model setValuesForKeysWithDictionary:titleDict];
        
        
        [mySelf.dataArr addObject:model];
        
    }
    
    [self.collectionView reloadData];
    
    
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}];




}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
