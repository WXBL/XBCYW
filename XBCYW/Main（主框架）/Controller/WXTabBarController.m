//
//  WXTabBarController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXTabBarController.h"
#import "WXHomeViewController.h"
#import "WXDelicacyViewController.h"
#import "WXDiscoverViewController.h"
#import "WXBusinessViewController.h"
#import "WXMoreViewController.h"
#import "WXNavigationController.h"
#import "MDDataBaseUtil.h"
//#import "AFNetworking.h"
//#import "AFHTTPRequestOperationManager.h"

#define GET_NEWSLIST_URL @""
@interface WXTabBarController ()

@end

@implementation WXTabBarController

-(NSMutableArray *)newsMutableArray{
    if (!_newsMutableArray) {
        self.newsMutableArray=[NSMutableArray array];
    }
    return _newsMutableArray;
}
-(NSMutableArray *)productMutableArray{
    if(!_productMutableArray){
        self.productMutableArray=[NSMutableArray array];
    }
    return _productMutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNewsData];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}  forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -10)];
    
//    self.tabBar.alpha = 1;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, CGRectGetHeight(self.view.frame))];
    backView.backgroundColor = [UIColor blackColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    //1.初始化字控制器
    WXHomeViewController *home = [[WXHomeViewController alloc]init];
//    home.newsListArray=self.newsMutableArray;
    [self addChildVc:home title:@"资讯" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    WXDelicacyViewController *delicacy = [[WXDelicacyViewController alloc]init];

    [self addChildVc:delicacy title:@"美食"  image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    WXDiscoverViewController *discover = [[WXDiscoverViewController alloc]init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    

    WXBusinessViewController *business = [[WXBusinessViewController alloc]init];
    [self addChildVc:business title:@"商家" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

    WXMoreViewController *more = [[WXMoreViewController alloc]init];
    [self addChildVc:more title:@"更多" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
}
//-(void)setNewsData{
//    AFHTTPRequestOperationManager *AFMgr=[AFHTTPRequestOperationManager manager];
//    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_NEWSLIST_URL];
//    
//    [AFMgr GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responseObject){
//        WXNewsModel *model=[[WXNewsModel alloc] init];
//        self.newsMutableArray=[model getNewsListWithArrayJSON:responseObject];
//    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        
//    }];
//}

-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectImage{
    
    //设置字控制器的文字
    childVc.title = title;
    
        childVc.tabBarItem.title = title;
//        childVc.navigationItem.title = title;
    
    //设置字控制器的图片
//    childVc.tabBarItem.image = [UIImage imageNamed:image];
//    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字的样式
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:1];
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    
    
    //    //先给外面传进来的小控制器包装一个导航控制器
    WXNavigationController *nav = [[WXNavigationController alloc]initWithRootViewController:childVc];
    //添加字控制器
    [self addChildViewController:nav];
    
    //    [self addChildViewController:childVc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
