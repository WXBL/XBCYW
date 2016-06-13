//
//  WXNewsViewController.m
//  XBCYW
//
//  Created by admin on 16/6/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXNewsViewController.h"
#import "WXTopView.h"
@interface WXNewsViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)WXTopView *topView;

@property (nonatomic,strong)UIWebView *detailWebView;


@end

@implementation WXNewsViewController{
    
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self NavgationView];
    
    [self createWebVeiw];
    
}

-(void)createWebVeiw{
    
    //1.创建UIWebView
    
    self.detailWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), screenWidth, screenHeigth-self.topView.frame.size.height)];
    //2.设置属性
    self.detailWebView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.detailWebView setOpaque:NO];//是否透明
//    [self.detailWebView setUserInteractionEnabled:YES];
    //3.显示网页视图UIWebView
    [self.view addSubview:self.detailWebView];
    //4.加载内容
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];//创建URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    //设置代理
    self.detailWebView.delegate = self;
    
    [self.detailWebView loadRequest:request];//加载
    //5.导航
//    [self.detailWebView goBack];
//    [self.detailWebView goForward];
//    [self.detailWebView reload];//重载
//    [self.detailWebView stopLoading];//取消载入内容
    
    
    
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0 , self.topView.frame.size.height, screenWidth, screenHeigth - self.topView.frame.size.height)];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((screenWidth - 30)/2 , (screenHeigth- self.topView.frame.size.height- 30)/2, 30, 30)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.hidesWhenStopped = YES;
    activityIndicatorView.color = [UIColor whiteColor];
    activityIndicatorView.alpha = 1.0;
    
    [opaqueView addSubview:activityIndicatorView];
    
}

#pragma mark UIWebViewDelegate委托代理
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view addSubview:opaqueView];
    [activityIndicatorView startAnimating];
//    opaqueView.hidden = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [opaqueView removeFromSuperview];
    [activityIndicatorView stopAnimating];
//    opaqueView.hidden = YES;
}

//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    if ((([httpResponse statusCode]/100) == 2)) {
//        // self.earthquakeData = [NSMutableData data];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//        
//        [ self.detailWebView loadRequest:[ NSURLRequest requestWithURL: url]];
//        self.detailWebView.delegate = self;
//    } else {
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
//                                  NSLocalizedString(@"HTTP Error",
//                                                    @"Error message displayed when receving a connection error.")
//                                                             forKey:NSLocalizedDescriptionKey];
//        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
//        
//        if ([error code] == 404) {
//            NSLog(@"xx");
//            self.detailWebView.hidden = YES;
//        }
//        
//    }
//}

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
