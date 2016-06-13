//
//  WXDiscoverViewController.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXDiscoverViewController.h"
#import "WXSearchBar.h"
#import "WJRefresh.h"
#import "WXDelicacyDetailViewController.h"
#import "WXfarmImportsTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#define DISCOVER_LIST_URL @""
@interface WXDiscoverViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)WXSearchBar *searchBar;
@property (nonatomic,strong)UICollectionView *collectionView;


@end

@implementation WXDiscoverViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.searchBar=[WXSearchBar searchBar];
//    [self.navigationController.navigationBar addSubview:self.searchBar];
//    self.searchBar.frame=CGRectMake(20, CGRectGetMinY(self.searchBar.frame), screenWidth-40, CGRectGetHeight(self.searchBar.frame));
//    self.searchBar.placeholder=@"请输入要搜索的美食";
    [self addCollectionView];
     self.view.backgroundColor = [UIColor blueColor];
    [self addDate];
    
}
-(NSMutableArray *)array{
    if (!_array) {
        self.array=[NSMutableArray array];
    }
    return _array;
}
-(void)addCollectionView{
    
    float headerHeight = 30;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(screenWidth, headerHeight);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth - self.searchBar.frame.size.height) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[WXfarmImportsTableViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hederView"];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
}

-(void)addDate{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,DISCOVER_LIST_URL];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responceObject){
        self.array=[[[WXTypeModel alloc] init]getTypeDataWithArrayJSON:responceObject];
        [self.collectionView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
         hud.labelText = @"请求失败，请重试！";
    }];

    
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

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return self.array.count;
   
//        return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hederView" forIndexPath:indexPath];
    
    //    //添加标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,screenWidth / 2-10, 30)];
//    titleLabel.text = [NSString stringWithFormat:@"农品铺子－共个产品"];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    

    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [titleView addSubview:titleLabel];

    
    [headerView addSubview:titleView];
    
    return headerView;
}

//每个cell所展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    WXfarmImportsTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来");
        
    }
    WXProductModel *model=[self.array objectAtIndex:indexPath.row];
//    WXProductModel *model=[[WXProductModel alloc] init];
    NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[model.productImgArr firstObject]]];
    [cell.farmImage setImage:[UIImage imageWithData:imgData]];
    cell.titleLabel.text = model.Goods_Name;
    cell.priceLabel.text = model.Goods_Price;
    return cell;
}

//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //边距占5*4=20 2个
    //图片为正方形，边长
    return CGSizeMake((screenWidth-20)/2, (screenWidth - 20)/2 + 50);
}

//定义每个UICollectionView的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//定义每个UICollectionView的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WXDelicacyDetailViewController *detailVC=[[WXDelicacyDetailViewController alloc] init];
    detailVC.productModel=[self.array objectAtIndex:indexPath.row];
    [self presentViewController:detailVC animated:YES completion:nil];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{

}




@end
