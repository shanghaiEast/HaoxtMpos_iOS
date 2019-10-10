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
#import "WxAndZfbViewController.h"
#import "QrCodeTableViewController.h"
#import "PayResultViewController.h"
#import "ConfirmSignViewController.h"
#import "TCreditCardCerTableViewController.h"
#import "POSCollectionViewController.h"
#import "BlueToothSearchToolsViewController.h"
#import "PayResultViewController.h"
#import "UserCertificationViewController.h"
#import "SignOrderViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import "UserStatementViewController.h"
#import "UserShopDetailTableViewController.h"
#import "ChangeDebitCardViewController.h"


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
    
    if ([myData TOKEN_ID].length == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
            loginVC.loginSuccessBlock = ^(BOOL success) {
                [_myTableView reloadData];
                
            };
        });
       
    }else{
        
        
        if (([[myData USR_STATUS] intValue] == 0 && [MY_USR_REAL_STS intValue] != 2)) {
            [self createAlertView_trueName];
            return;
        }else{
           [self requestMerchantsMessage];
        }
        
    }

}

- (void)checkLogin{
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    、、15029267074      c123456
//    15512345678    z123456

    
//    UserStatementViewController *resultVC = [[UserStatementViewController alloc] initWithNibName:@"UserStatementViewController" bundle:nil];
//    resultVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:resultVC animated:YES];
    
    
//    BlueToothSearchToolsViewController *cardCerVC = [[BlueToothSearchToolsViewController alloc] initWithNibName:@"BlueToothSearchToolsViewController" bundle:nil];
//    cardCerVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:cardCerVC animated:YES];
    
//    POSCollectionViewController *cardCerVC = [[POSCollectionViewController alloc] initWithNibName:@"POSCollectionViewController" bundle:nil];
//    cardCerVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:cardCerVC animated:YES];

    
    
    
//    model修改参数
//    NSLog(@"%@",[myData USR_TERM_STS]);
//    NSMutableDictionary *tempDict = [USER_DATA mutableCopy];
//    [tempDict setObject:@"0" forKey:@"USR_TERM_STS"];
//    [ToolsObject savaUserData:tempDict];
//    [LoginJsonModel infoWithDictionary:USER_DATA];
//    NSLog(@"%@",[myData USR_TERM_STS]);
    
    
    
    if ([myData TOKEN_ID].length == 0) {
      
        
    }else{
        //实名认证
        if ([myData TOKEN_ID].length != 0 && ([[myData USR_STATUS] intValue] == 0 && [MY_USR_REAL_STS intValue] != 2)) {
            [self createAlertView_trueName];
            
        }else{
            
            //信用卡认证
            if ([myData TOKEN_ID].length != 0 && ([[myData USR_STATUS] intValue] != 0 || [MY_USR_REAL_STS intValue] == 2) && [[myData CCARD_VALID_STS] intValue] == 0) {
                
                [self createAlertView_cards];
            }
            
            //n绑定机具
            if ([myData TOKEN_ID].length != 0 && ([[myData USR_STATUS] intValue] != 0 || [MY_USR_REAL_STS intValue] == 2) && [[myData USR_TERM_STS] intValue] == 0) {

                [self createAlertView_machines];
            }
        }
    }
    
    
    
    
    
//    LocationObject *locationOj = [[LocationObject alloc] init];
//    [locationOj locationView:self];
//    locationOj.locationMessageBlock = ^(NSArray *array) {
//        NSLog(@"%@",array);
//    };


    
    
    [self createTableView];
    
    if ([myData TOKEN_ID].length != 0) {
        [self requestGetNotices];
        [self requestReceive];
    }
    
    
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
        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
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
        cell.noticeArray = _noticesArray;
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
    NSLog(@"pushTag : %d",pushTag);
    
    if (([[myData USR_STATUS] intValue] == 0 && [MY_USR_REAL_STS intValue] != 2)) {
        [self createAlertView_trueName];
        return;
    }else{


        //信用卡认证
        if ([myData TOKEN_ID].length != 0 && ([[myData USR_STATUS] intValue] != 0 || [MY_USR_REAL_STS intValue] == 2) && [[myData CCARD_VALID_STS] intValue] == 0) {

            [self createAlertView_cards];
        }

       //机具申领
        if ([myData TOKEN_ID].length != 0 && ([[myData USR_STATUS] intValue] != 0 || [MY_USR_REAL_STS intValue] == 2) && [[myData USR_TERM_STS] intValue] == 0) {

            [self createAlertView_machines];

            return;
        }
    }
    
    WxAndZfbViewController *wxAndZfbVC = [[WxAndZfbViewController alloc] initWithNibName:@"WxAndZfbViewController" bundle:nil];
    wxAndZfbVC.hidesBottomBarWhenPushed = YES;
    wxAndZfbVC.processTag = pushTag;
    [self.navigationController pushViewController:wxAndZfbVC animated:YES];
}

- (void)createAlertView_cards {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"需要绑定信用卡" message:@"使用好享推APP需先绑定信用卡" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"暂不绑定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"前往绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        TCreditCardCerTableViewController *cardCerVC = [[TCreditCardCerTableViewController alloc] initWithNibName:@"TCreditCardCerTableViewController" bundle:nil];
        cardCerVC.hidesBottomBarWhenPushed = YES;
        [[ToolsObject currentViewController].navigationController pushViewController:cardCerVC animated:YES];
        
    }]];
    
    
    //    [cancel setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)createAlertView_machines {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"需要绑定机具" message:@"使用好享推APP需先绑定机具" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"暂不绑定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        NSLog(@"点击取消");

    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"前往绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSLog(@"点击确认");
        BlueToothSearchToolsViewController *blueVC = [[BlueToothSearchToolsViewController alloc] initWithNibName:@"BlueToothSearchToolsViewController" bundle:nil];
        blueVC.hidesBottomBarWhenPushed = YES;
        [[ToolsObject currentViewController].navigationController pushViewController:blueVC animated:YES];

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
        UserCertificationViewController *userCerVC = [[UserCertificationViewController alloc] initWithNibName:@"UserCertificationViewController" bundle:nil];
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

#pragma mark 获取商户信息
- (void)requestMerchantsMessage {
    
    if ([SHOP_DETAIL count] == 0) {//第一次展示
        [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    }
    
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] init];
    
    [YanNetworkOBJ postWithURLString:usr_get parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"rspMap"] forKey:@"shopDetail"];
            
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
