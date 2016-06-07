//
//  WXHomeViewController.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXHomeViewController.h"

#import "WXSearchBar.h"
#import "UIView+Extension.h"


@interface WXHomeViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)WXSearchBar *searchBar;

@property (nonatomic,strong)UIButton *categoryBtn;


@end

@implementation WXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [WXSearchBar searchBar];
    self.searchBar.delegate = self;
    
    [self.navigationController.navigationBar addSubview:self.searchBar];
    
    [self addNavLeftCategoryButton];
    
}

-(void)addNavLeftCategoryButton{
    self.categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.categoryBtn.frame = CGRectMake(10, 10, 60, 25);
    [self.categoryBtn setTitle:@"分类" forState:UIControlStateNormal];
    [self.categoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.categoryBtn.layer setCornerRadius:5];
    [self.categoryBtn.layer setMasksToBounds:YES];
    [self.categoryBtn.layer setBorderWidth:1.0];
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//    
//    [self.categoryBtn.layer setBorderColor:colorref];//边框颜色
    self.categoryBtn.backgroundColor = [UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1];
    self.categoryBtn.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    
    [self.navigationController.navigationBar addSubview:self.categoryBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
