//
//  MainViewController.m
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import "MainViewController.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"

//test
#import "WxAndZfbTableViewController.h"
#import "QrCodeTableViewController.h"
#import "PayResultViewController.h"
#import "ConfirmSignViewController.h"
#import "TCreditCardCerTableViewController.h"
#import "POSCollectionViewController.h"
#import "BlueToothSearchToolsTableViewController.h"
#import "PayResultViewController.h"
#import "UserCertificationTableViewController.h"
#import "SignOrderViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import "UserStatementTableViewController.h"
#import "UserShopDetailTableViewController.h"


#import "LocationObject.h"



#import "Main1TableViewCell.h"
#import "MainListTableViewCell.h"



#pragma mark swift图标桥接文件
#import "YanFarmwork-Bridging-Header.h"

#import "MyWebViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property int page;

@property (retain, nonatomic) NSArray *noticesArray;
@property (retain, nonatomic) NSDictionary *receiveDict;



@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self checkLogin];

}

- (void)checkLogin{
    if ([myData TOKEN_ID].length == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        loginVC.loginSuccessBlock = ^(BOOL success) {
            [_myTableView reloadData];
        };
        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    、、15029267074      c123456
    
//    UserStatementTableViewController *cardCerVC = [[UserStatementTableViewController alloc] initWithNibName:@"UserStatementTableViewController" bundle:nil];
//    cardCerVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:cardCerVC animated:YES];
    
    
    
    
    if ([[myData USR_STATUS] intValue] == 0) {
        [self createAlertView_trueName];
    }
    
    if ([[myData USR_STATUS] intValue] != 0 && [[myData USR_TERM_STS] intValue] == 0) {
        BlueToothSearchToolsTableViewController *blueVC = [[BlueToothSearchToolsTableViewController alloc] initWithNibName:@"BlueToothSearchToolsTableViewController" bundle:nil];
        blueVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:blueVC animated:YES];
        
    }
    
    
//    LocationObject *locationOj = [[LocationObject alloc] init];
//    [locationOj locationView:self];
//    locationOj.locationMessageBlock = ^(NSArray *array) {
//        NSLog(@"%@",array);
//    };
//
    
    
    
   
    
//    POSCollectionViewController *cardCerVC = [[POSCollectionViewController alloc] initWithNibName:@"POSCollectionViewController" bundle:nil];
//    cardCerVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:cardCerVC animated:YES];
    
    
    
    
    
    
    
    [self createTableView];
    
    [self requestGetNotices];
    [self requestReceive];
    
}




- (void)createTableView {
    //table view
    
    float height = YYISiPhoneX ? 44 : 20;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EF5F48"];
    [self.view addSubview:view];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, ScreenHeight-kTabBarHeight-height) style:UITableViewStylePlain];
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
    
     _myTableView.ly_emptyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"emptycell.png"] titleStr:@"暂无消息…" detailStr:@""];
    _myTableView.ly_emptyView.contentViewY = 540;//
    _myTableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHexString:@"#AFAFAF"];
    _myTableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:12];
    [_myTableView ly_showEmptyView];
    
//    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
//    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
//
//    [self refreshTableView];
}
#pragma mark  -----  Refresh
-(void)refreshTableView
{
    [self refreshHeader];
}
- (void)refreshHeader
{
    _page = 1;
    
    [self mjRefreshStopWhenTen];
}
- (void)upDown
{
    _page ++;
    
    [self mjRefreshStopWhenTen];
}
- (void)tableEndRefresh
{
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}
- (void)mjRefreshStopWhenTen
{
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf.myTableView.mj_header endRefreshing];
        [wSelf.myTableView.mj_footer endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
//        return YYISiPhoneX ? 446+44 : 446+20;
        return 446;
    }

    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *tradView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        tradView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,0,100,40);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.text = @"最近交易";
        [tradView addSubview:label];
        
        return tradView;
    }
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *topCell = @"Main1TableViewCell";
        Main1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.receiveDict = _receiveDict;
        [cell createCell];
        
        cell.pressMoreAdvertis = ^(BOOL prsssBool) {
            NSLog(@"点击更多公告");
        };
        cell.pressCollectionTag = ^(int tag) {
            NSLog(@"点击collection");
            //[@"普通收款",@"超级收款",@"二维码收款",@"闪付优惠"]
            
            [self pushPayWay:tag];

        };
        
        
        return cell;
    }else{
        static NSString *listCell = @"MainListTableViewCell";
        MainListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:listCell owner:self options:nil] lastObject];
        }
        
        
        
        return cell;
    }
    
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        
    }
}

//UITableView顶部不可拖动
-(void)scrollViewDidScroll:(UIScrollView*)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if(offset.y<=0) {
        
        offset.y=0;
        
    }
    scrollView.contentOffset= offset;
}

- (void)pushPayWay:(int)pushTag{
    
    if ([[myData USR_STATUS] intValue] == 0) {
        [self createAlertView_trueName];
        return;
    }else{
        
    }
    
    WxAndZfbTableViewController *wxAndZfbVC = [[WxAndZfbTableViewController alloc] initWithNibName:@"WxAndZfbTableViewController" bundle:nil];
    wxAndZfbVC.hidesBottomBarWhenPushed = YES;
    wxAndZfbVC.processTag = pushTag;
    [self.navigationController pushViewController:wxAndZfbVC animated:YES];
}

- (void)createAlertView_machines {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"需要绑定机具" message:@"使用好享推APP需先绑定机具" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"暂不绑定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        NSLog(@"点击取消");

    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"前往绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSLog(@"点击确认");

    }]];
    
    
//    [cancel setValue:[UIColor redColor] forKey:@"_titleTextColor"];

    [self presentViewController:alertController animated:YES completion:nil];
    
   
}

- (void)createAlertView_trueName {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请确认是否实名认证" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"暂不认证" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"前往认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确认");
        UserCertificationTableViewController *userCerVC = [[UserCertificationTableViewController alloc] initWithNibName:@"UserCertificationTableViewController" bundle:nil];
        userCerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userCerVC animated:YES];
    }]];
    
    
    //    [cancel setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}



#pragma mark 系统公告
- (void)requestGetNotices {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] init];
    
    [YanNetworkOBJ postWithURLString:pub_getNotices parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.noticesArray = [responseObject objectForKey:@"rspData"];
            
            [wSelf.myTableView reloadData];
           
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
}

#pragma mark 3.25.    用户收款查询
- (void)requestReceive{
    
    //    PAGE_NUM    当前页数
    //    PAGE_SIZE    页面大小
    //    CARDNO    卡号
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    //将日期转换成需要的样式
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [NSDate date];
    NSString *dateString = [YMD stringFromDate:date];
    
    NSLog(@"时间：%@",dateString);
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",dateString],@"TRANS_DAY",
                                nil];
    
    [YanNetworkOBJ postWithURLString:ord_account_receive parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.receiveDict = [responseObject objectForKey:@"rspMap"];
            
            [wSelf.myTableView reloadData];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

@end
