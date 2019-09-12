//
//  CheckRealNameTableViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "CheckRealNameTableViewController.h"

#import "CheckRealNameTableViewCell.h"
#import "TCreditCardCerTableViewController.h"

@interface CheckRealNameTableViewController ()

@property (retain, nonatomic) NSMutableArray *dataArray;

@end

@implementation CheckRealNameTableViewController

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
}

- (void)createTable {
    
    NSArray *sectionOne = @[@"姓名", @"身份证号"];
    NSArray *sectionTwo = @[@"银行卡号", @"所属银行"];
    
    _dataArray = @[sectionOne, sectionTwo];
    
    
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F7FB"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
//    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[_dataArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16,15,200,20);
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:1.0];
    [view addSubview:label];
    
    if (section == 0) {
        label.text = @"身份认证信息";
    }else if (section == 1) {
        label.text = @"银行卡认证信息";
    }
    
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return [UIView new];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(20, 150, ScreenWidth-40, 50)];
    button.backgroundColor = MAINCOLOR;
    [button setTitle:@"前去认证信用卡" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 20];
    button.layer.cornerRadius = 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(pushToBankCade) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    return view;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"CheckRealNameTableViewCell";
    CheckRealNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    cell.keyLabel.text = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}



- (void)pushToBankCade{
    TCreditCardCerTableViewController *cardCerVC = [[TCreditCardCerTableViewController alloc] initWithNibName:@"TCreditCardCerTableViewController" bundle:nil];
    cardCerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cardCerVC animated:YES];
}


@end
