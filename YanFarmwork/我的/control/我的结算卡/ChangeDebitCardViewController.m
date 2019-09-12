//
//  ChangeDebitCardViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ChangeDebitCardViewController.h"

@interface ChangeDebitCardViewController ()

@end

@implementation ChangeDebitCardViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"更改结算卡" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)cardIdBtnClick:(id)sender {
    //填写储蓄卡
}

- (IBAction)scanBtnClick:(id)sender {
    //扫描
}

- (IBAction)openCardBankBtnClick:(id)sender {
    //开户行
}

- (IBAction)openCardAddressBtnClick:(id)sender {
    //开户行省市
}
- (IBAction)branckBankBtnClick:(id)sender {
    //开户行分行
}

- (IBAction)commitBtnClick:(id)sender {
    //提交
    [self.navigationController popViewControllerAnimated:YES];
}
@end
