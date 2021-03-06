//
//  SCNavigationController.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "WXNavigationController.h"
#import "UIView+Extension.h"

#define WXNavigationBarTitleFont [UIFont systemFontOfSize:18]
#define WXNavigationBarButtonFont [UIFont systemFontOfSize:14]

@interface WXNavigationController () <UINavigationControllerDelegate>

@end

@implementation WXNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Custom initialization
//        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.translucent=NO;
        self.navigationBar.barTintColor=[UIColor redColor];
//        NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
//        [barAttrs setObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
//        [barAttrs setObject:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
//        [self.navigationBar setTitleTextAttributes:barAttrs];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        shadow.shadowOffset = CGSizeMake(0, 1);
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                               shadow, NSShadowAttributeName,
                                                               [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];

        
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        //自动显示和隐藏
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置导航栏上的内容
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //设置图片
        [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        //设置尺寸
        backButton.size = backButton.currentBackgroundImage.size;
        
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        // 设置图片
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        // 设置尺寸
        moreBtn.size = moreBtn.currentBackgroundImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}


-(void)back{
    
    [self popViewControllerAnimated:YES];
}

-(void)more{
    [self popViewControllerAnimated:YES];
}

@end
