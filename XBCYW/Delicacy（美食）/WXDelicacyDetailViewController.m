//
//  WXDelicacyDetailViewController.m
//  XBCYW
//
//  Created by 龙莲莲 on 16/6/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXDelicacyDetailViewController.h"
#import "WXNavigationController.h"
#import "WXTopView.h"
#import "WXImageModel.h"
#import "WXBigPic.h"
#import "WXMerchantModel.h"
#import "UILabel+WXStringFrame.h"
@interface WXDelicacyDetailViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollerView;
@property (nonatomic,strong)UIScrollView *imageScrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIButton *productButton;
@property(nonatomic,strong)NSMutableArray *productImageArr;
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UILabel *priceLbl;
@property(nonatomic,strong)UILabel *introductLbl;
@property(nonatomic,strong)UILabel *merchantLbl;
@property(nonatomic,strong)UILabel *addressLbl;
@property(nonatomic,strong)UILabel *teleLbl;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UIView *cellBgView;
@end

@implementation WXDelicacyDetailViewController
-(NSMutableArray *)productImageArr{
    if (!_productImageArr) {
        self.productImageArr=[[NSMutableArray alloc] init];
    }
    return _productImageArr;
}
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
    [self addproductPic];
    [self addProductIntroduct];
    
    
}
-(void)addProductIntroduct{
    self.titleLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imageScrollView.frame)+5, CGRectGetMaxY(self.imageScrollView.frame)+10, CGRectGetWidth(self.imageScrollView.frame)-10, 40)];
    self.titleLbl.text=self.productModel.Goods_Name;
    self.titleLbl.textColor=[UIColor blackColor];
//    self.titleLbl.backgroundColor=[UIColor lightGrayColor];
    [self.scrollerView addSubview:self.titleLbl];
    
    self.priceLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(self.titleLbl.frame), CGRectGetWidth(self.titleLbl.frame), CGRectGetHeight(self.titleLbl.frame))];
    self.priceLbl.text=[NSString stringWithFormat:@"单价：¥%@",self.productModel.Goods_Price];
    self.priceLbl.textColor=[UIColor blackColor];
    [self.scrollerView addSubview:self.priceLbl];
    
    self.merchantLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(self.priceLbl.frame), CGRectGetWidth(self.priceLbl.frame), CGRectGetHeight(self.priceLbl.frame))];
    self.merchantLbl.textColor=[UIColor blackColor];
    WXMerchantModel *merchant=self.productModel.Merchant;
    self.merchantLbl.text=[NSString stringWithFormat:@"商家：%@",merchant.Merchant_Name];
    [self.scrollerView addSubview:self.merchantLbl];
    
    self.teleLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(self.merchantLbl.frame), CGRectGetWidth(self.titleLbl.frame), CGRectGetHeight(self.titleLbl.frame))];
    self.teleLbl.textColor=[UIColor blackColor];
    self.teleLbl.text=[NSString stringWithFormat:@"联系电话：%@",merchant.Merchants_Tell];
    [self.scrollerView addSubview:self.teleLbl];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.teleLbl.frame), screenWidth, 1)];
    v.backgroundColor=[UIColor lightGrayColor];
    [self.scrollerView addSubview:v];
    
    self.introductLbl=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(v.frame), CGRectGetWidth(self.titleLbl.frame), CGRectGetHeight(self.titleLbl.frame))];
    self.introductLbl.textColor=[UIColor blackColor];
    self.introductLbl.text=self.productModel.Goods_Introduce;
    self.introductLbl.numberOfLines=0;
    self.introductLbl.font=[UIFont systemFontOfSize:16];
    CGSize size=[self.introductLbl boundingRectWithSize:CGSizeMake(screenWidth-40, 0)];
    self.introductLbl.frame=CGRectMake(CGRectGetMinX(self.titleLbl.frame), CGRectGetMaxY(self.teleLbl.frame), size.width, size.height);
    [self.scrollerView addSubview:self.introductLbl];
    self.scrollerView.contentSize=CGSizeMake(screenWidth, CGRectGetMaxY(self.introductLbl.frame));
    
}
#pragma mark - 添加tableviewHeader（商品图片）
-(void)addproductPic
{
    self.imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 2, screenWidth-20, screenWidth/2)];
    self.imageScrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.imageScrollView.delegate = self;
    [self.scrollerView addSubview:self.imageScrollView];
    self.productImageArr=self.productModel.productImgArr;
    
    //    self.productButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.productButton.frame = CGRectMake(0, 0, screenWidth, screenHeigth);
    //    [self.scrollView addSubview:self.productButton];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(screenWidth *0.3, screenWidth/2-20, screenWidth * 0.4, 20)];
    //    pageControl.backgroundColor = [UIColor redColor];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1]];
    [self.scrollerView addSubview:self.pageControl];
    
    CGFloat imgW = screenWidth;
    CGFloat imgH = screenWidth /2;
    ;
    CGFloat imgY = 0;
    WXImageModel *imageModel=[[WXImageModel alloc] init];
    
    // 1. 循环创建5个UIImageView添加到ScrollView中
    for (int i = 0; i < self.productImageArr.count; i++) {
        // 创建一个UIImageView
        self.imageView = [[UIImageView alloc] init];
        
        // 设置UIImageView中的图片
        imageModel=[self.productImageArr objectAtIndex:i];
        NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageModel.Image_ur]];
        [self.imageView setImage:[UIImage imageWithData:imgData]];
        
        // 计算每个UIImageView在UIScrollView中的x坐标值
        CGFloat imgX = i * imgW;
        // 设置imgView的frame
        self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        self.imageView.tag = i+1;
        // 把imgView添加到UIScrollView中
        [self.imageScrollView addSubview:self.imageView];
        
        
        
    }
    //为需要放大的图片添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(magnifyImage)];
    
    [self.imageView addGestureRecognizer:tap];
    
    //    [self.productButton addTarget:self action:@selector(ClickProductPic:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 设置UIScrollView的contentSize(内容的实际大小)`
    CGFloat maxW = self.imageScrollView.frame.size.width * 4;
    self.imageScrollView.contentSize = CGSizeMake(maxW, 0);
    
    
    // 实现UIScrollView的分页效果
    // 当设置允许分页以后, UIScrollView会按照自身的宽度作为一页来进行分页。
    self.imageScrollView.pagingEnabled = YES;
    
    // 隐藏水平滚动指示器
    self.imageScrollView.showsHorizontalScrollIndicator = NO;
    
    // 指定UIPageControl的总页数
    self.pageControl.numberOfPages = 4;
    
    // 指定默认是第0页
    self.pageControl.currentPage = 0;
    
    
}

// 实现UIScrollView的滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 如何计算当前滚动到了第几页？
    // 1. 获取滚动的x方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    // 用已经偏移了得值, 加上半页的宽度
    offsetX = offsetX + (scrollView.frame.size.width * 0.5);
    
    // 2. 用x方向的偏移的值除以一张图片的宽度(每一页的宽度)，取商就是当前滚动到了第几页（索引）
    int page = offsetX / scrollView.frame.size.width;
    
    // 3. 将页码设置给UIPageControl
    self.pageControl.currentPage = page;
    
    //NSLog(@"滚了，要在这里根据当前的滚动来计算当前是第几页。");
}

-(void)magnifyImage{
    NSLog(@"局部放大");
    
    [WXBigPic showImage:self.imageView];//调用方法
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
