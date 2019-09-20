//
//  SignOrderViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "SignOrderViewController.h"

#import "SingOrderTableViewCell.h"

#import "SignOrderFooterView.h"



@interface SignOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray *keyArray, *valueArray;

@property (retain, nonatomic) SignOrderFooterView *footerView;


@end

@implementation SignOrderViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:MAINCOLOR andItem:@"" itemColor:WHITECOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_White withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:View];
    [ToolsObject gradientColor:View startColor:@"#FE4049" endColor:@"#EF5F48"];
    
    
    _keyArray = [[NSMutableArray alloc] init];
    _valueArray = [[NSMutableArray alloc] init];
    _keyArray = @[@"终端机号", @"商户名称", @"商户编号", @"金额"];
    _valueArray = @[@"SL21323234", @"大雷子", @"3223423434", @"1323"];
    
    [ToolsObject disableTheSideslip:self];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, ScreenHeight-kNavBarHAbove7-kBottomSafeHeight-30)];
    //    bgImageView.backgroundColor = [UIColor blackColor];
    bgImageView.image = [UIImage imageNamed:@"singOrderBG.png"];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgImageView];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(0, bgImageView.frame.size.height-65, bgImageView.frame.size.width, 40)];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [confirmButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:confirmButton];
    
   
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height-65) style:UITableViewStylePlain];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.sectionFooterHeight = CGFLOAT_MIN;
//    self.myTableView.tableFooterView = [UIView new];
//    self.myTableView.sectionHeaderHeight = CGFLOAT_MIN;
//    self.myTableView.tableHeaderView = [UIView new];
//    self.myTableView.bounces = NO;
    [bgImageView addSubview:self.myTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _keyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 
    return 135;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.frame = CGRectMake(29,23,22,18);
    logoImage.image = [UIImage imageNamed:@"银联.png"];
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:logoImage];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(50,21,view.frame.size.width-100,24);
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLabel.text = @"签购单";
    [view addSubview:titleLabel];
    
    UIImageView *bottomLine = [[UIImageView alloc] init];
    bottomLine.frame = CGRectMake(20,58,view.frame.size.width-40,2);
    bottomLine.image = [UIImage imageNamed:@"mainLine.png"];
    bottomLine.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:bottomLine];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    _footerView = [[[NSBundle mainBundle] loadNibNamed:@"SignOrderFooterView" owner:self options:nil] lastObject];
    [_footerView setFrame:CGRectMake(0, 0, ScreenWidth-40, 135)];

    
    
    return _footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_keyArray.count-1 == indexPath.row) {
        return 40;
    }
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStr = @"SingOrderTableViewCell";
    SingOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellStr owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    cell.processTag = _processTag;
    cell.rootVC = self;
    
    
    cell.keyLabel.text = [NSString stringWithFormat:@"%@",[_keyArray objectAtIndex:indexPath.row]];
    cell.valueLabel.text = [NSString stringWithFormat:@"%@",[_valueArray objectAtIndex:indexPath.row]];
    
    if (_keyArray.count-1 == indexPath.row) {
        cell.valueLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
        cell.valueLabel.textColor = MAINCOLOR;
    }

    
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)confirmBtnClick {
    
}

@end
