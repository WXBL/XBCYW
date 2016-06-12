//
//  WXDiscoverViewController.m
//  XBCYW
//
//  Created by admin on 16/6/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WXDiscoverViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "WXTypeModel.h"
#import "WXDiscoverListViewController.h"
#define  DISCOVER_LIST_URL @""
#define DISCOVER_RESULT_URL @""
@interface WXDiscoverViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *discoverTableView;
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation WXDiscoverViewController
-(NSMutableArray *)array{
    if (!_array) {
        self.array=[[NSMutableArray alloc] init];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor whiteColor];
    self.discoverTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth)];
    [self.view addSubview:self.discoverTableView];
    self.discoverTableView.delegate=self;
    self.discoverTableView.dataSource=self;
    self.discoverTableView.tableFooterView=[[UIView alloc] init];
    [self addDate];
}

-(void)addDate{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,DISCOVER_LIST_URL];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responceObject){
        self.array=[[[WXTypeModel alloc] init]getTypeDataWithArrayJSON:responceObject];
        [self.discoverTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:10];
         hud.labelText = @"请求失败，请重试！";
    }];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.array.count;
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"discoverCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=@"最新、最热、最优";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WXDiscoverListViewController *discoverListVC=[[WXDiscoverListViewController alloc] init];
//    discoverListVC.typeModel=[self.array objectAtIndex:indexPath.row];
    [self presentViewController:discoverListVC animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
