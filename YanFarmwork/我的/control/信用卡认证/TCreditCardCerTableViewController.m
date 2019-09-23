//
//  TCreditCardCerTableViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TCreditCardCerTableViewController.h"

#import "CreditCardCerTableViewCell.h"

#import "AddCreditCardViewController.h"



@interface TCreditCardCerTableViewController ()

@property (nonatomic) int page;
@property (retain, nonatomic) NSMutableArray *cardArray;

@end

@implementation TCreditCardCerTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"信用卡认证" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 80, 38)];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [rightButton setTitle:@"额度说明" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addCreditCard) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
//    [self.navigationController popViewControllerAnimated:YES];
     [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addCreditCard {
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTable];
    
    [self requestList];
}

- (void)createTable {
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
//    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"emptycell.png"] titleStr:@"暂无消息…" detailStr:@""];
    
    //    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
    
    
    [self refreshTableView];
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
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)mjRefreshStopWhenTen
{
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf.tableView.mj_header endRefreshing];
        [wSelf.tableView.mj_footer endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 142;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(20, 100, ScreenWidth-40, 50)];
    button.backgroundColor = MAINCOLOR;
    [button setTitle:@"认证提额" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 20];
    button.layer.cornerRadius = 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(pushToBankCade) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    return view;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"CreditCardCerTableViewCell";
    CreditCardCerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.bankNameLabel.text = [NSString stringWithFormat:@
                               "%@",[[_cardArray objectAtIndex:indexPath.row] objectForKey:@"ACCT_NAME"]];
    
    cell.cardIDLabel.text = [NSString stringWithFormat:@
                               "%@",[[_cardArray objectAtIndex:indexPath.row] objectForKey:@"ACCT_NO"]];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

- (void)pushToBankCade{
    AddCreditCardViewController *addCardVC = [[AddCreditCardViewController alloc] initWithNibName:@"AddCreditCardViewController" bundle:nil];
    addCardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addCardVC animated:YES];
}

- (void)requestList{

//    PAGE_NUM    当前页数
//    PAGE_SIZE    页面大小
//    CARDNO    卡号

    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;

    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%d",_page],@"PAGE_NUM",
                                @"10",@"PAGE_SIZE",
                                [NSString stringWithFormat:@"%@",[myData CER_NO]],@"",
                                nil];

    [YanNetworkOBJ postWithURLString:check_list parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {

            if (wSelf.page == 1) {
                 wSelf.cardArray = [responseObject objectForKey:@"rspData"];
            }else{
                [wSelf.cardArray addObjectsFromArray:[responseObject objectForKey:@"rspData"]];
            }
           
            [wSelf.tableView reloadData];
            
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
