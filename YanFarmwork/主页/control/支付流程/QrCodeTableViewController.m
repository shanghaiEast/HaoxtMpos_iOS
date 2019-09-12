//
//  QrCodeTableViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "QrCodeTableViewController.h"






#import "PayResultViewController.h"

#import "WxAndZfbTableViewCell.h"
#import "QrCodeView.h"

@interface QrCodeTableViewController ()

@property (retain, nonatomic) QrCodeView *qrCodeView;


@end



@implementation QrCodeTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:MAINCOLOR andItem:@"微信/支付宝" itemColor:WHITECOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_White withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.bounces = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        PayResultViewController *resultVC = [[PayResultViewController alloc] initWithNibName:@"PayResultViewController" bundle:nil];
        resultVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:resultVC animated:YES];
    });
    
   
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((ScreenHeight-kNavBarHAbove7)<627) {
        return 627;
    }
    tableView.scrollEnabled = NO;
    return ScreenHeight-kNavBarHAbove7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellStr = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    float height = 0;
    if ((ScreenHeight-kNavBarHAbove7)<627) {
        height = 627;
    }else{
        height = ScreenHeight-kNavBarHAbove7;
    }
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
      [ToolsObject gradientColor:myView startColor:@"#FE4049" endColor:@"#EF5F48"];
    [cell addSubview:myView];
    
    _qrCodeView = [[[NSBundle mainBundle] loadNibNamed:@"QrCodeView" owner:self options:nil] lastObject];
    [_qrCodeView setFrame:myView.bounds];
    _qrCodeView.processTag = _processTag;
    _qrCodeView.rootVC = self;
    [myView addSubview:_qrCodeView];
     [_qrCodeView createView];

    
    
    return cell;
}



@end
