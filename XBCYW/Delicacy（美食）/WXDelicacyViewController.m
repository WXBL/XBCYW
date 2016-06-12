//
//  WXSuppliesViewController.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXDelicacyViewController.h"
#import "WXSearchBar.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "WXTypeModel.h"
#import "WXProductModel.h"
#import "WXImageModel.h"
#import "WXDelicacyDetailViewController.h"
#define GET_PRODUCTLIST_URL @""
#define GET_CATEGORYLIST_URL @""
@interface WXDelicacyViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)WXSearchBar *searchBar;
@property(nonatomic,strong)UIButton *timeBtn;
@property(nonatomic,strong)UIButton *priceBtn;
@property(nonatomic,strong)UIButton *categoryBtn;
@property(nonatomic,strong)NSMutableArray *productArr;
@property(nonatomic,strong)NSMutableArray *currentArr;
@property(nonatomic,strong)NSMutableArray *categoryArr;
@property(nonatomic,strong)NSMutableArray *filterArr;
@property(nonatomic,strong)UITableView *categoryTableView;
@property(nonatomic,strong)UITableView *productTableView;
@property(nonatomic,strong)WXTypeModel *typeModel;
@property(nonatomic,strong)WXProductModel *productModel;
@property(nonatomic,strong)WXImageModel *imgModel;
@end

@implementation WXDelicacyViewController
-(NSMutableArray *)productArr{
    if (!_productArr) {
        self.productArr=[[NSMutableArray alloc] init];
    }
    return _productArr;
}
-(NSMutableArray *)currentArr{
    if (!_currentArr) {
        self.currentArr=[[NSMutableArray alloc] init];
    }
    return _currentArr;
}
-(NSMutableArray *)categoryArr{
    if (!_categoryArr) {
        self.categoryArr=[[NSMutableArray alloc] init];
    }
    return _categoryArr;
}
-(void)addDate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_CATEGORYLIST_URL];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responceObject){
        self.categoryArr=[self.typeModel getTypeDataWithArrayJSON:responceObject];
        [self.categoryTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        hud.labelText = @"请求失败，请重试！";
    }];
    path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_PRODUCTLIST_URL];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responceObject){
        self.productArr=[self.productModel getProductListWithArrayJSON:responceObject];
        [self.productTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        hud.labelText = @"请求失败，请重试！";
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar=[WXSearchBar searchBar];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.searchBar.frame=CGRectMake(20, CGRectGetMinY(self.searchBar.frame), screenWidth-40, CGRectGetHeight(self.searchBar.frame));
    self.searchBar.placeholder=@"请输入要搜索的美食";
    self.searchBar.delegate=self;
    UIView *searchBtnView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth*0.04)];
    [self.view addSubview:searchBtnView];
    searchBtnView.backgroundColor=[UIColor lightGrayColor];
    self.timeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(searchBtnView.frame)/3, CGRectGetHeight(searchBtnView.frame))];
    self.timeBtn.backgroundColor=[UIColor whiteColor];
    [self.timeBtn setTitle:@"时间" forState:UIControlStateNormal];
    self.timeBtn.tag=1;
    self.timeBtn.selected=YES;
    self.timeBtn.layer.borderWidth=1;
    [self.timeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.timeBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    CGColorSpaceRef  colorSpace=CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef=CGColorCreate(colorSpace, (CGFloat[]){0.8,0.8,0.8,1});
    [self.timeBtn.layer setBorderColor:colorRef];
    [searchBtnView addSubview:self.timeBtn];
    [self.timeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.priceBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.timeBtn.frame),0, CGRectGetWidth(self.timeBtn.frame), CGRectGetHeight(self.timeBtn.frame))];
    self.priceBtn.backgroundColor=[UIColor whiteColor];
    [self.priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    self.priceBtn.tag=2;
    self.priceBtn.layer.borderWidth=1;
    [self.priceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.priceBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.priceBtn.layer setBorderColor:colorRef];
    [searchBtnView addSubview:self.priceBtn];
    [self.priceBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.categoryBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.priceBtn.frame),0, CGRectGetWidth(self.timeBtn.frame), CGRectGetHeight(self.timeBtn.frame))];
    self.categoryBtn.backgroundColor=[UIColor whiteColor];
    [self.categoryBtn setTitle:@"分类" forState:UIControlStateNormal];
    self.categoryBtn.tag=3;
    self.categoryBtn.layer.borderWidth=1;
    [self.categoryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.categoryBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.categoryBtn.layer setBorderColor:colorRef];
    [searchBtnView addSubview:self.categoryBtn];
    [self.categoryBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.productTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBtnView.frame)+1, screenWidth, screenHeigth-CGRectGetMaxY(searchBtnView.frame))];
    self.productTableView.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:self.productTableView];
    self.productTableView.delegate=self;
    self.productTableView.dataSource=self;
    
    
    self.categoryTableView=[[UITableView alloc] initWithFrame:CGRectMake(screenWidth-200, CGRectGetMaxY(searchBtnView.frame)+1, 200, 200)];
    self.categoryTableView.tableFooterView=[[UIView alloc] init];
    self.categoryTableView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:self.categoryTableView];
    self.categoryTableView.hidden=YES;
    [self.categoryTableView bringSubviewToFront:self.view];
    self.categoryTableView.delegate=self;
    self.categoryTableView.dataSource=self;
   
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.categoryTableView) {
        return 44;
    }else if(tableView==self.productTableView){
        return 60;
    }
    return 44;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.productTableView) {
//        return self.currentArr.count;
        return 6;
    }else if (tableView==self.categoryTableView){
//        return self.categoryArr.count;
        return 10;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"productCELL";
    static NSString *cellID1=@"categoryCEll";
    UITableViewCell *cell;
    if (tableView==self.categoryTableView) {
         cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
//        self.typeModel=[self.categoryArr objectAtIndex:indexPath.row];
//        cell.textLabel.text=self.typeModel.Type_Name;
        cell.textLabel.text=@"拉面";
        cell.backgroundView.alpha=0.5;
    }else if(tableView==self.productTableView){
        cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        }
//        self.productModel=[self.currentArr objectAtIndex:indexPath.row];
//        self.imgModel=[self.productModel.productImgArr firstObject];
//        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgModel.Image_ur]];
//        cell.imageView.image=[UIImage imageWithData:data];
//        cell.textLabel.text=self.productModel.Goods_Name;
//        cell.detailTextLabel.text=self.productModel.Goods_Price;
        /*
        cell.imageView.image=[UIImage imageNamed:@"2.jpg"];
        cell.textLabel.text=[NSString stringWithFormat:@"%@%ld",@"西北餐饮网商品",(long)indexPath.row];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"¥%ld",indexPath.row];

        */
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.productTableView.frame.size.width, 60)];
        [cell addSubview:view1];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 0, self.productTableView.frame.size.width/3, 50);
        imageView.image=[UIImage imageNamed:@"2.jpg"];
        [cell addSubview:imageView];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 0, self.productTableView.frame.size.width/2, 20)];
        textLabel.text=[NSString stringWithFormat:@"%@%ld",@"西北餐饮网商品",(long)indexPath.row];
        [cell addSubview:textLabel];
        UILabel *detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 20, self.productTableView.frame.size.width/2, 20)];
        detailTextLabel.text=[NSString stringWithFormat:@"¥%ld",indexPath.row];
        [cell addSubview:detailTextLabel];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)clickBtn:(UIButton *)btn{
    
    for (UIButton *button in btn.superview.subviews) {
        [button setSelected:NO];
    }
    [btn setSelected:YES];
    if (btn.tag==1) {
        self.categoryTableView.hidden=YES;
        [self searchOrderBySearchKey:@"Goods_Time"];
    }else if(btn.tag==2)
    {
        self.categoryTableView.hidden=YES;
        [self searchOrderBySearchKey:@"Goods_Price"];
    }else if(btn.tag==3)
    {
        if (self.categoryTableView.hidden) {
            self.categoryTableView.hidden=NO;
        }else{
            self.categoryTableView.hidden=YES;
        }
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.categoryTableView.hidden=YES;
    if (tableView==self.categoryTableView) {
//        self.typeModel=[self.categoryArr objectAtIndex:indexPath.row];
        [self searchWithSearchKey:@"Goods_TypeName" SearchValue:self.typeModel.Type_Name];
    }else if(tableView==self.productTableView){
        WXDelicacyDetailViewController *detailVC=[[WXDelicacyDetailViewController alloc] init];
//        detailVC.productModel=[self.currentArr objectAtIndex:indexPath.row];
        [self presentViewController:detailVC animated:YES completion:nil];
        
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder=@"";
    textField.text=@"";
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self searchWithSearchKey:@"Goods_Name" SearchValue:textField.text];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder=@"请输入要搜索的美食";
    [textField resignFirstResponder];
    [self searchWithSearchKey:@"Goods_Name" SearchValue:textField.text];
}
-(void)searchOrderBySearchKey:(NSString *)key{
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
    self.currentArr=self.productArr;
    [self.currentArr sortUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
    [self.productTableView reloadData];
}
-(void)searchWithSearchKey:(NSString *)key SearchValue:(NSString *)value{
//    NSString *searchString = self.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ contains [c] %@",key,value];
    self.filterArr = [NSMutableArray arrayWithArray:[self.productArr filteredArrayUsingPredicate:predicate]];
    if (self.filterArr.count > 0) {
        self.currentArr=self.filterArr;
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没有搜索到您想要的商品";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        
    }
    [self.productTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
