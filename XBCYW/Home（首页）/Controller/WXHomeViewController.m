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
#import "MBProgressHUD.h"
#import "WXHomeTableViewCell.h"
#import "WXNewsTableViewCell.h"
#import "WXdynamicTableViewCell.h"
#import "WJRefresh.h"
#import "AFNetworking.h"

#import "WXNewsViewController.h"
#import "WXNewsModel.h"
#define GET_MERCHANT_URL @""
@interface WXHomeViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WXHomeTableViewCellDelegate>

@property (nonatomic,strong)WXSearchBar *searchBar;

@property (nonatomic,strong)UIButton *categoryBtn;

@property (nonatomic,strong)NSMutableArray *filteredNews;
@property (nonatomic,strong)NSMutableArray *currentNewsArray;

@property (nonatomic,strong)NSMutableArray *newsArray;
@property (nonatomic,strong)NSMutableArray *dynamicArray;

@property (nonatomic,strong)UITableView *tableView;//资讯头条
@property (nonatomic,strong)UITableView *newsTableView;//新闻资讯
@property (nonatomic,strong)UITableView *dynamicTableView;//动态

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,strong)UIView *menuView;
@property (nonatomic,strong)UIButton *headlineBtn;//头条
@property (nonatomic,strong)UIButton *newsBtn;//新闻
@property (nonatomic,strong)UIButton *dynamicBtn;//动态

@property (nonatomic,strong)UITapGestureRecognizer *dismissMenuView;

@property (nonatomic,strong)WJRefresh *refresh;
@property (nonatomic,strong)WXNewsModel *newsModel;
@end

@implementation WXHomeViewController

-(NSMutableArray *)newsListArray{
    if (!_newsListArray) {
        self.newsListArray=[NSMutableArray array];
    }
    return _newsListArray;
}
-(void)addData{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_MERCHANT_URL];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responceObject){
        self.currentNewsArray=[self.newsModel getNewsListWithArrayJSON:responceObject];
        [self.newsTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络请求失败！";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }];
}
#pragma mark UIScrollViewDelegate
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

// 实现即将开始拖拽的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止计时器
    // 调用invalidate一旦停止计时器, 那么这个计时器就不可再重用了。下次必须重新创建一个新的计时器对象。
    [self.timer invalidate];
    
    // 因为当调用完毕invalidate方法以后, 这个计时器对象就已经废了，无法重用了。所以可以直接将self.timer设置为nil
    self.timer = nil;
}

// 实现拖拽完毕的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    // 重新启动一个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 再次修改一下新创建的timer的优先级
    // 修改self.timer的优先级与控件一样
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//要改变StatusBar的显示样式需要在UIViewController中重载
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

//    self.view.backgroundColor = [UIColor redColor];

    
    self.searchBar = [WXSearchBar searchBar];
    self.searchBar.delegate = self;
    
    [self.navigationController.navigationBar addSubview:self.searchBar];
    
    [self addNavLeftCategoryButton];
    
    [self addTableView];
    
    [self setCarousel];
    
//    self.menuView.hidden =YES;
//    [self.view bringSubviewToFront:self.menuView];
    self.dismissMenuView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menuView:)];
    [self.view addGestureRecognizer:self.dismissMenuView];
    self.dismissMenuView.enabled = NO;
    
    /* 初始化控件 */
    _refresh = [[WJRefresh alloc]init];
    __weak typeof(self)weakSelf = self;
    [_refresh addHeardRefreshTo:self.tableView heardBlock:^{
        [weakSelf createHeaderData];
    } footBlok:^{
        [weakSelf createFootData];
    }];
    [_refresh beginHeardRefresh];
    
    
    [self createNewsTableView];
    [self creatDynamicTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCategoryView];
    
}

-(void)addNavLeftCategoryButton{
    self.categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.categoryBtn.frame = CGRectMake(10, 10, 60, 25);
    [self.categoryBtn setTitle:@"分类" forState:UIControlStateNormal];
    [self.categoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.categoryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.categoryBtn.layer setCornerRadius:5];
    [self.categoryBtn.layer setMasksToBounds:YES];
    [self.categoryBtn.layer setBorderWidth:1.0];
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//    
//    [self.categoryBtn.layer setBorderColor:colorref];//边框颜色
    self.categoryBtn.backgroundColor = [UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1];
    self.categoryBtn.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    [self.categoryBtn addTarget:self action:@selector(ClickCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:self.categoryBtn];
}

-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth-100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];//隐藏cell的分割线
    [self.view addSubview:self.tableView];
    
}

-(void)createNewsTableView{
    
    self.newsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth-100) style:UITableViewStylePlain];
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    self.newsTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.newsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];//隐藏cell的分割线
    [self.view addSubview:self.newsTableView];
    self.newsTableView.hidden = YES;
}

-(void)creatDynamicTableView{
    
    self.dynamicTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth-100) style:UITableViewStylePlain];
    self.dynamicTableView.delegate = self;
    self.dynamicTableView.dataSource = self;
    self.dynamicTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.dynamicTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];//隐藏cell的分割线
    [self.view addSubview:self.dynamicTableView];
    self.dynamicTableView.hidden = YES;
}
#pragma mark -刷新
-(void)createHeaderData{
    if (self.tableView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.currentNewsArray removeAllObjects];
            self.currentNewsArray = [NSMutableArray array];
            if (self.currentNewsArray.count <11) {
              
                self.currentNewsArray.count +3;
            }
            [self.tableView reloadData];
            [_refresh endRefresh];
        });

    }else if (self.newsTableView){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.newsTableView reloadData];
            [_refresh endRefresh];
        });
    }else if(self.dynamicTableView){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.dynamicTableView reloadData];
            [_refresh endRefresh];
        });
    
    }
    
}

-(void)createFootData{
    

    if(self.tableView){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [_refresh endRefresh];
        });
        
    }else if (self.newsTableView){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.newsTableView reloadData];
            [_refresh endRefresh];
        });
        
    }else if (self.dynamicTableView){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.dynamicTableView reloadData];
            [_refresh endRefresh];
        });
       
    }
   
}

#pragma mark -创建分类菜单
-(void)setCategoryView{
    //创建分类菜单view
    self.menuView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, screenWidth*0.3, screenHeigth*0.2)];
    self.menuView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
    [self.menuView setHidden:YES];
    [self.view addSubview:self.menuView];

    
    self.headlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headlineBtn.frame = CGRectMake(10, 10, self.menuView.frame.size.width -20, self.menuView.frame.size.height *0.3);
    [self.headlineBtn setTitle:@"资讯头条" forState:UIControlStateNormal];
    [self.headlineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.headlineBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.headlineBtn.tag =100;
    [self.headlineBtn addTarget:self action:@selector(ClickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.headlineBtn];
    
    self.newsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.newsBtn.frame = CGRectMake(10, CGRectGetMaxY(self.headlineBtn.frame), self.menuView.frame.size.width -20, self.menuView.frame.size.height *0.3);
    [self.newsBtn setTitle:@"新闻资讯" forState:UIControlStateNormal];
    [self.newsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.newsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.newsBtn.tag =101;
    [self.newsBtn addTarget:self action:@selector(ClickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.newsBtn];
    
    self.dynamicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dynamicBtn.frame = CGRectMake(10, CGRectGetMaxY(self.newsBtn.frame), self.menuView.frame.size.width -20, self.menuView.frame.size.height *0.3);
    [self.dynamicBtn setTitle:@"最新动态" forState:UIControlStateNormal];
    [self.dynamicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.dynamicBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.dynamicBtn.tag = 102;
    [self.dynamicBtn addTarget:self action:@selector(ClickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.dynamicBtn];
}

/**
 菜单显示，隐藏
 */
-(void)menuView:(id)sender{
    self.menuView.hidden = YES;
    self.dismissMenuView.enabled = NO;
}

#pragma mark -点击分类按钮触发事件
-(void)ClickCategory:(UIButton *)sender{
    
    
    if (self.menuView.hidden ==YES) {
        [self.menuView setHidden:NO];
        [UIView animateWithDuration:0.1 animations:^{}completion:^(BOOL finished){
            self.dismissMenuView.enabled = YES;
        }];
    }else{
        [self.menuView setHidden:YES];
        self.dismissMenuView.enabled = NO;
    }
    
    
//    [categoryView bringSubviewToFront:self.view];
}

-(void)ClickMenuBtn:(UIButton *)sender{
    [self.menuView setHidden:YES];
    if (sender.tag ==100) {
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        self.newsTableView.hidden = YES;
        self.dynamicTableView.hidden = YES;
    }else if(sender.tag ==101){
        self.newsTableView.hidden = NO;
        [self.newsTableView reloadData];
        self.tableView.hidden = YES;
        self.dynamicTableView.hidden = YES;
    }else if (sender.tag ==102){
        self.dynamicTableView.hidden = NO;
        [self.dynamicTableView reloadData];
        self.tableView.hidden = YES;
        self.newsTableView.hidden = YES;
    }
}

#pragma mark - UIScrollView实现轮播
-(void)setCarousel{
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = CGRectMake(0, 0, screenWidth, screenHeigth *0.2);
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.delegate = self;
    self.tableView.tableHeaderView = self.scrollView;
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(screenWidth *0.3, screenHeigth*0.15, screenWidth *0.4, 40)];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1]];
    [self.tableView addSubview:self.pageControl];
    
    //添加轮播图片
    CGFloat imageW = screenWidth;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    //循环创建UImageView添加到ScrollView中
    for (int i= 0; i<3; i++) {
        // 创建一个UIImageView
        UIImageView *imageView = [[UIImageView alloc]init];
        
        // 设置UIImageView中的图片
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        
        // 计算每个UIImageView在UIScrollView中的x坐标值
        CGFloat imgX = i * imageW;
        // 设置imgView的frame
        imageView.frame = CGRectMake(imgX, imageY, imageW, imageH);
        
        // 把imgView添加到UIScrollView中
        [self.scrollView addSubview:imageView];
    }
    
    // 设置UIScrollView的contentSize(内容的实际大小)
    CGFloat maxW = self.scrollView.frame.size.width * 3;
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    
    
    // 实现UIScrollView的分页效果
    // 当设置允许分页以后, UIScrollView会按照自身的宽度作为一页来进行分页。
    self.scrollView.pagingEnabled = YES;
    
    // 隐藏水平滚动指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 指定UIPageControl的总页数
    self.pageControl.numberOfPages = 3;
    
    // 指定默认是第0页
    self.pageControl.currentPage = 0;
    
    
    // 创建一个"计时器"控件NSTimer控件
    // 通过scheduledTimerWithInterval这个方法创建的计时器控件, 创建好以后自动启动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 修改self.timer的优先级与控件一样
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //    [self.scrollView bringSubviewToFront:self.pageControl];

}

// 自动滚动图片的方法
// 因为在创建计时器的时候, 指定了时间间隔是1.0秒,所以下面这个方法每隔一秒钟执行一次
- (void)scrollImage
{
    // 每次执行这个方法的时候, 都要让图片滚动到下一页
    // 如何让UIScrollView滚动到下一页?
    // 1. 获取当前的UIPageControl的页码
    NSInteger page = self.pageControl.currentPage;
    
    // 2. 判断页码是否到了最后一页, 如果到了最后一页, 那么设置页码为0（回到第一页）。如果没有到达最后一页, 则让页码+1
    if (page == self.pageControl.numberOfPages - 1) {
        // 表示已经到达最后一页了
        page = 0; // 回到第一页
    } else {
        page++;
    }
    // 3. 用每页的宽度 * (页码 + 1) == 计算除了下一页的contentOffset.x
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    
    // 4. 设置UIScrollView的contentOffset等于新的偏移的值
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
    // 如果图片现在已经滚动到最后一页了, 那么就滚动到第一页
    
}



#pragma mark -search实现搜索功能
-(void)search:(id)sender{
    NSString *searchString = self.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Administrivia_Name contains [c] %@",searchString];
    self.filteredNews = [NSMutableArray arrayWithArray:[self.currentNewsArray filteredArrayUsingPredicate:predicate]];
    if (self.filteredNews.count > 0) {
        self.currentNewsArray=self.filteredNews;
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没有搜索到您想要的商品";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        
    }
    [self.tableView reloadData];
    [self.newsTableView reloadData];
    [self.dynamicTableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self search:nil];
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.searchBar.text = nil;
    self.currentNewsArray = self.newsListArray;
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    [self search:nil];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.currentNewsArray = self.newsListArray;
    [self search:nil];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    [self search:nil];
    return YES;
}

#pragma mark - Tableview dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (self.currentNewsArray.count>10) {
            return 11;
        }else{
            return self.currentNewsArray.count+5;
        }
    }else if (tableView == self.newsTableView){
        return 3;
//        self.newsArray.count;
    }else if (tableView == self.dynamicTableView){
        return 4;
//        return self.dynamicArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        static NSString *cellId = @"HeadnewsCell";
        WXHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.delegate=self;
        if (!cell) {
            cell = [[WXHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }

         return cell;
    }else if (tableView == self.newsTableView){
        static NSString *cellId = @"newsCell";
        WXNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[WXNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    }else if(self.dynamicTableView){
        static NSString *cellId = @"dynamicCell";
        WXdynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[WXdynamicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    }
    
    return nil;
    
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.newsTableView || tableView == self.dynamicTableView) {
        WXNewsViewController *newsController = [[WXNewsViewController alloc]init];
        [self presentViewController:newsController animated:YES completion:nil];
    }
        
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.tableView) {
        return 180;
    }else if (tableView == self.newsTableView ||tableView == self.dynamicTableView){
        return 100;
    }

    return 100;
}


#pragma mark -点击资讯跳转事件
-(void)WXHomeTableViewCell:(UITableViewCell *)homeViewCell didSelectButton:(UIButton *)button{
    WXNewsViewController *homeViewController = [[WXNewsViewController alloc]init];
    [self presentViewController:homeViewController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
