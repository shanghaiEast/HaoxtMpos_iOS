//
//  BlueToothSearchToolsTableViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "BlueToothSearchToolsTableViewController.h"

#import "BlueToothSearchToolsTableViewCell.h"
#import "BlueToothSearchToolsHeaderView.h"

#import "BindToolsViewController.h"
#import "ConfirmSignViewController.h"

#import "TianYuView.h"
#import <CoreBluetooth/CBPeripheral.h>



@interface BlueToothSearchToolsTableViewController ()

@property (retain, nonatomic) BlueToothSearchToolsHeaderView *headerView;

@property (retain, nonatomic) NSMutableArray *blueArr;
@property (retain, nonatomic) TianYuView *tianYuView;


@end

@implementation BlueToothSearchToolsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTable];
    [self createBooth];
}

- (void)createTable {
    
    [self.tableView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kBottomSafeHeight-kNavBarHAbove7)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _blueArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 290;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 85;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"BlueToothSearchToolsHeaderView" owner:self options:nil] lastObject];
    [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 290)];
    
    [ToolsObject playGIFWithNameL:@"searchTools" playTime:3 showImageView:_headerView.imageView];
    
    return _headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"BlueToothSearchToolsTableViewCell";
    BlueToothSearchToolsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.rootVC = self;
    
    [cell createCellView];
    
    
    
    CBPeripheral *myDevice = [self.blueArr objectAtIndex:indexPath.row];
    cell.toolsNameLabel.text = myDevice.name;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    typeof(self)wSelf = self;
    
     CBPeripheral *myDevice = [self.blueArr objectAtIndex:indexPath.row];
    [_tianYuView clickedIndexDict:myDevice];
    _tianYuView.getMessageBlock = ^(CBPeripheral * _Nonnull myDevice, NSString * _Nonnull snString) {
        
        NSLog(@"myDevice:%@",myDevice);
        NSLog(@"snString:%@",snString);
        
        [wSelf.tianYuView stopBlueLink];
        
        ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
        confirmSignVC.payType = TYPE_TOOLS;
        confirmSignVC.hidesBottomBarWhenPushed = YES;
        [wSelf.navigationController pushViewController:confirmSignVC animated:YES];
        
//        BindToolsViewController *bindToolsVC = [[BindToolsViewController alloc] initWithNibName:@"BindToolsViewController" bundle:nil];
//        bindToolsVC.mySNString = [NSString stringWithFormat:@"%@",snString];
//        bindToolsVC.hidesBottomBarWhenPushed = YES;
//        [wSelf.navigationController pushViewController:bindToolsVC animated:YES];

    };
    
    
    

    
//    BindToolsViewController *bindToolsVC = [[BindToolsViewController alloc] initWithNibName:@"BindToolsViewController" bundle:nil];
//    bindToolsVC.hidesBottomBarWhenPushed = YES;
//    bindToolsVC.SNString = sn;
//    [self.navigationController pushViewController:bindToolsVC animated:YES];
   
    
    
//    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
//    confirmSignVC.payType = TYPE_TOOLS;
//    confirmSignVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:confirmSignVC animated:YES];
    
    
}

///.........................天谕pos。。。。。。。。。。。。。。。。。。。
- (void)createBooth{
    if (_tianYuView == nil) {
        _blueArr = [[NSMutableArray alloc] init];
        
        _tianYuView = [[TianYuView alloc] init];
        [self.view addSubview:_tianYuView];
        [_tianYuView startTianYu];
    }
    typeof(self)wSelf = self;
    
    _tianYuView.connectedSearchBlock = ^(NSArray * _Nonnull array) {
        wSelf.blueArr = [array mutableCopy];
        [wSelf.tableView reloadData];
    };
    
}


@end
