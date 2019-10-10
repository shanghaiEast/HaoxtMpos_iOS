//
//  WxAndZfbViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/8.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "WxAndZfbViewController.h"

#import "POSCollectionViewController.h"

#import "WxAndZfbTableViewCell.h"
#import "OrdinaryTableViewCell.h"
#import "ConfirmView.h"
#import "QrCodeTableViewController.h"

@interface WxAndZfbViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int payWayTag;

@end

@implementation WxAndZfbViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    app.keyboardManager.enableAutoToolbar = NO;
//    app.keyboardManager.enable = NO;
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"" itemColor:WHITECOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kNavBarHAbove7) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
    
    if (@available(iOS 11.0, *)) {
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_processTag == 0) {
        if ((ScreenHeight-kNavBarHAbove7)<417) {
            
            return 417;
        }
    }
    if ((ScreenHeight-kNavBarHAbove7)<450) {
        
        return 450;
    }
    
    tableView.scrollEnabled = NO;
    return ScreenHeight-kNavBarHAbove7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //确定
    if (_processTag == 2) {
        static NSString *cellStr = @"WxAndZfbTableViewCell";
        WxAndZfbTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellStr owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell createCell];
        
        
        __weak typeof(self) wSelf = self;
        cell.chooseBankBlock = ^(BOOL chooseBankBool) {
            NSLog(@"选择银行");
        };
        cell.payWayBlock = ^(int payWaytag) {
            NSLog(@"选择支付方式");
            wSelf.payWayTag = payWaytag;
        };
        cell.saveMoneyBlock = ^(NSDictionary *dict) {
            NSLog(@"确定收款");
            if ([cell.moneyNumber.text floatValue] == 0) {
                [ToolsObject showMessageTitle:@"请输入付款金额" andDelay:1 andImage:nil];
                
                return ;
            }
            
            QrCodeTableViewController *qrCodeVC = [[QrCodeTableViewController alloc] initWithNibName:@"QrCodeTableViewController" bundle:nil];
            qrCodeVC.hidesBottomBarWhenPushed = YES;
            qrCodeVC.payWayTag = wSelf.payWayTag;
            qrCodeVC.processTag = wSelf.processTag;
            qrCodeVC.moneyString = cell.moneyNumber.text;
            [self.navigationController pushViewController:qrCodeVC animated:YES];
            
          
            
            
        };
        
        return cell;
        
    }else{
        static NSString *cellStr = @"OrdinaryTableViewCell";
        OrdinaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellStr owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.processTag = _processTag;
        
        [cell createView];
        
        
        __weak typeof(self) wSelf = self;
        cell.chooseBankBlock = ^(BOOL chooseBankBool) {
            NSLog(@"选择银行");
        };
        cell.payWayBlock = ^(int payWaytag) {
            NSLog(@"选择支付方式");
            wSelf.payWayTag = payWaytag;
        };
        cell.saveMoneyBlock = ^(NSDictionary *dict) {
            NSLog(@"确定收款");
            if ([cell.moneyNumber.text floatValue] == 0) {
                [ToolsObject showMessageTitle:@"请输入付款金额" andDelay:1 andImage:nil];
                
                return ;
            }
            
            POSCollectionViewController *posVC = [[POSCollectionViewController alloc] initWithNibName:@"POSCollectionViewController" bundle:nil];
            posVC.hidesBottomBarWhenPushed = YES;
            posVC.processTag = _processTag;
            posVC.moneyString = cell.moneyNumber.text;
            [self.navigationController pushViewController:posVC animated:YES];
            
           
        };
        
        return cell;
    }
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
