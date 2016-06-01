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


@end

@implementation WXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.searchBar = [WXSearchBar searchBar];
    self.searchBar.delegate = self;
    
    [self.navigationController.navigationBar addSubview:self.searchBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
