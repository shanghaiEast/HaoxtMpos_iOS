//
//  UserSenterTableViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "UserSenterTableViewController.h"

#import "UserCenterTableViewCell.h"
#import "UserCenterHeaderView.h"

@interface UserSenterTableViewController ()

@property (retain, nonatomic) UserCenterHeaderView *headerView;

@property (retain, nonatomic) NSArray *listKeyArray, *listValueArray;

@end

@implementation UserSenterTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listKeyArray = @[@"商户编号",
                      @"联系人",
                      @"电话号码",
                      @"开通日期",
                      @"商户状态",
                      @"借记卡费率",
                      @"贷记卡D0",
                      @"二维码/闪付"
                      ];
    NSString *beginDateString = [_detialDict objectForKey:@"PIDBEGINDATE"];
    beginDateString = [ToolsObject insertString:@"/" fromString:beginDateString withInsertIndex:4];
    beginDateString = [ToolsObject insertString:@"/" fromString:beginDateString withInsertIndex:7];
    
    NSString *userStateString = @"未开通";
    if ([[_detialDict objectForKey:@"MERC_STS"] intValue] != 0) {
        userStateString = @"开通";
    }
    
    _listValueArray = @[[_detialDict objectForKey:@"MERC_ID"],
                        [_detialDict objectForKey:@"CORP_NM"],
                        [_detialDict objectForKey:@"USR_OPR_MBL"],
                        beginDateString,
                        userStateString,
                        [NSString stringWithFormat:@"%@%@",[_detialDict objectForKey:@"DCARD_TFEE"],@"%"],
                        [NSString stringWithFormat:@"%@%@",[_detialDict objectForKey:@"CCARD_DFEE"],@"%"],
                        [NSString stringWithFormat:@"%@%@",[_detialDict objectForKey:@"UN_FEE"],@"%"]
                        ];
    
    
    
    [self createTable];
}

- (void)createTable {
    float height = YYISiPhoneX ? 44 : 20;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, -height)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EF5F48"];
    [self.view addSubview:view];
    
//    [self.tableView setFrame:CGRectMake(0, -height, ScreenWidth, ScreenHeight+height)];
    self.tableView.backgroundColor = [UIColor clearColor];
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
    
    return _listValueArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 51;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"UserCenterHeaderView" owner:self options:nil] lastObject];
    [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    _headerView.detialDict = _detialDict;
    [_headerView createHeaderView];
    _headerView.rootVC = self;
    
    return _headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"UserCenterTableViewCell";
    UserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.keyLabel.text = [_listKeyArray objectAtIndex:indexPath.row];
    cell.valueLabel.text = [_listValueArray objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}



@end
