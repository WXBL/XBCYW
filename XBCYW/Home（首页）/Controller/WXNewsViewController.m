//
//  WXNewsViewController.m
//  XBCYW
//
//  Created by admin on 16/6/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXNewsViewController.h"
#import "WXTopView.h"
@interface WXNewsViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)WXTopView *topView;

@property (nonatomic,strong)UIWebView *detailWebView;
@property (nonatomic,strong)UIScrollView *contentView;

@end

@implementation WXNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self NavgationView];
    
}

-(void)NavgationView{
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"资讯"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView = topView;
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
