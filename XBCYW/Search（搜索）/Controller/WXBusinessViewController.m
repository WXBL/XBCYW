//
//  WXSearchViewController.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXBusinessViewController.h"
#import "WXMerchantModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "WXBusinessDetailViewController.h"
#define GET_MERCHANT_URL @""
@interface WXBusinessViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *merchantTableView;
@property(nonatomic,strong)NSMutableArray *merchantArr;
@property(nonatomic,strong)WXMerchantModel *merchant;
@end

@implementation WXBusinessViewController
-(NSMutableArray *)merchantArr{
    if (!_merchantArr) {
        self.merchantArr=[[NSMutableArray alloc] init];
    }
    return _merchantArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.merchant=[[WXMerchantModel alloc] init];
     self.view.backgroundColor = [UIColor grayColor];
    self.merchantTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth)];
    self.merchantTableView.delegate=self;
    self.merchantTableView.dataSource=self;
    self.merchantTableView.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:self.merchantTableView];
}
-(void)addData{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_MERCHANT_URL];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responceObject){
        self.merchantArr=[self.merchant getMerchantListWithArrayJSON:responceObject];
        [self.merchantTableView reloadData];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WXBusinessDetailViewController *detailVC=[[WXBusinessDetailViewController alloc] init];
//    detailVC.merchant=[self.merchantArr objectAtIndex:indexPath.row];
    [self presentViewController:detailVC animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
//    return self.merchantArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"MERCHANTCELL";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
//    self.merchant=[self.merchantArr objectAtIndex:indexPath.row];
//    cell.textLabel.text=self.merchant.Merchant_Name;
//    cell.detailTextLabel.text=self.merchant.Merchants_Tell;
    
    cell.textLabel.text=@"天津万象";
    cell.detailTextLabel.text=@"联系方式：01234567890";
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
