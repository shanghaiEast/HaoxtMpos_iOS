//
//  DebitCardViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "DebitCardViewController.h"

#import "ChangeDebitCardViewController.h"

@interface DebitCardViewController ()

@end

@implementation DebitCardViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"我的结算卡" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 100, 38)];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [rightButton setTitle:@"更换结算卡" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(changeDebitCard) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//更换结算卡
- (void)changeDebitCard{
    ChangeDebitCardViewController *changeCardVC = [[ChangeDebitCardViewController alloc] initWithNibName:@"ChangeDebitCardViewController" bundle:nil];
    changeCardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeCardVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createCardView];
}

- (void)createCardView {
    
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
