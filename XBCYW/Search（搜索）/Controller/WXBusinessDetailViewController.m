//
//  WXBusinessDetailViewController.m
//  XBCYW
//
//  Created by 龙莲莲 on 16/6/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXBusinessDetailViewController.h"
#import "WXTopView.h"
#import "UILabel+WXStringFrame.h"
@interface WXBusinessDetailViewController ()
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UILabel *priceLbl;
@property(nonatomic,strong)UILabel *introductLbl;
@property(nonatomic,strong)UILabel *merchantLbl;
@property(nonatomic,strong)UILabel *addressLbl;
@property(nonatomic,strong)UILabel *teleLbl;
@end

@implementation WXBusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"详情"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-50)];
    self.scrollerView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.scrollerView];
    self.scrollerView.contentSize=CGSizeMake(screenWidth, screenHeigth-50);
    [self addMerchantData];
}
-(void)addMerchantData{
    self.titleLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.scrollerView.frame)-20, 40)];
    self.titleLbl.text=self.merchant.Merchant_Name;
    self.titleLbl.text=@"天津万象";
    self.titleLbl.textColor=[UIColor blackColor];
    //    self.titleLbl.backgroundColor=[UIColor lightGrayColor];
    [self.scrollerView addSubview:self.titleLbl];
    
    self.merchantLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(self.titleLbl.frame), CGRectGetWidth(self.titleLbl.frame), CGRectGetHeight(self.titleLbl.frame))];
    self.merchantLbl.textColor=[UIColor blackColor];
    self.merchantLbl.text=[NSString stringWithFormat:@"地址：%@",self.merchant.Merchants_Adress];
    self.merchantLbl.text=@"地址：天津市武清区";
    [self.scrollerView addSubview:self.merchantLbl];
    
    self.teleLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(self.merchantLbl.frame), CGRectGetWidth(self.titleLbl.frame), CGRectGetHeight(self.titleLbl.frame))];
    self.teleLbl.textColor=[UIColor blackColor];
    self.teleLbl.text=[NSString stringWithFormat:@"联系电话：%@",self.merchant.Merchants_Tell];
    self.teleLbl.text=@"联系电话：01234567890";
    [self.scrollerView addSubview:self.teleLbl];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.teleLbl.frame), screenWidth, 1)];
    v.backgroundColor=[UIColor lightGrayColor];
    [self.scrollerView addSubview:v];
    
    self.introductLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(v.frame), CGRectGetWidth(self.titleLbl.frame), CGRectGetHeight(self.titleLbl.frame))];
    self.introductLbl.textColor=[UIColor blackColor];
    self.introductLbl.text=self.merchant.Merchants_Introduce;
    self.introductLbl.text=@"主营产品：餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮、餐饮 ；营业时间： 上午8:00－晚上9:00";
    self.introductLbl.numberOfLines=0;
    self.introductLbl.font=[UIFont systemFontOfSize:16];
    CGSize size=[self.introductLbl boundingRectWithSize:CGSizeMake(screenWidth-20, 0)];
    self.introductLbl.frame=CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(self.teleLbl.frame), size.width, size.height);
    [self.scrollerView addSubview:self.introductLbl];
    self.scrollerView.contentSize=CGSizeMake(screenWidth, CGRectGetMaxY(self.introductLbl.frame));
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
