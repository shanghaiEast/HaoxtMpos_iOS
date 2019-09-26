//
//  ConfirmSignViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ConfirmSignViewController.h"

#import "CheckRealNameTableViewController.h"
#import "TCreditCardCerTableViewController.h"
#import "MyPOSViewController.h"

@interface ConfirmSignViewController ()

@end

@implementation ConfirmSignViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"结果" itemColor:BLACKCOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [ToolsObject disableTheSideslip:self];
    
    [self createView];
}

- (void)createView{
    _nextBtn.layer.cornerRadius = 2;
    _nextBtn.layer.masksToBounds = YES;
    
    _cancelBtn.layer.cornerRadius = 2;
    _cancelBtn.layer.masksToBounds = YES;
    
    //0==成功，1==失败，2==未知
    if (_payType == PAY_SUCCESS) {
        _stateImageView.image = [UIImage imageNamed:@"paySuccess.png"];
        _title_main.text = @"扫码成功";
        _title_other.text = @"已成功交易 239.00元";
        
        [_nextBtn setTitle:@"继续交易" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    }
    if (_payType == PAY_FIELD) {
        _stateImageView.image = [UIImage imageNamed:@"payFiled.png"];
        _title_main.text = @"扫码失败";
        _title_other.text = @"建议您重新刷卡支付";
        
        [_nextBtn setTitle:@"重新交易" forState:UIControlStateNormal];
        [_cancelBtn setHidden:YES];
        
    }
    if (_payType == PAY_UNKONW) {
        _stateImageView.image = [UIImage imageNamed:@"payUnkonw.png"];
        _title_main.text = @"未知结果";
        _title_other.text = @"如用户已支付\n请通过交易查询页面再次查询";
        
        [_nextBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_cancelBtn setHidden:YES];
    }
    if (_payType == TYPE_REALNAME) {
        _stateImageView.image = [UIImage imageNamed:@"paySuccess.png"];
        _title_main.text = @"实名认证成功";
        _title_other.text = @"";
        
        [_nextBtn setTitle:@"前去认证信用卡" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"查看实名信息" forState:UIControlStateNormal];
    }
    if (_payType == TYPE_CARDCER) {
        _stateImageView.image = [UIImage imageNamed:@"paySuccess.png"];
        _title_main.text = @"信用卡认证成功";
        _title_other.text = @"请使用本卡做首笔交易\n首笔交易金额需大于等于100元";
        
        [_nextBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_cancelBtn setHidden:YES];
    }
    if (_payType == TYPE_TOOLS) {
        _stateImageView.image = [UIImage imageNamed:@"paySuccess.png"];
        _title_main.text = @"绑定成功";
        _title_other.text = @"您可以使用APP了";
        
        [_nextBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"查看我的POS机" forState:UIControlStateNormal];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if ([button.currentTitle isEqualToString:@"继续交易"]) {
         [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if ([button.currentTitle isEqualToString:@"重新交易"]) {
         [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if ([button.currentTitle isEqualToString:@"返回首页"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if ([button.currentTitle isEqualToString:@"前去认证信用卡"]) {
        TCreditCardCerTableViewController *cardCerVC = [[TCreditCardCerTableViewController alloc] initWithNibName:@"TCreditCardCerTableViewController" bundle:nil];
        cardCerVC.pushTag = 1;
        cardCerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cardCerVC animated:YES];
    }
    if ([button.currentTitle isEqualToString:@"查看实名信息"]) {
        CheckRealNameTableViewController *checkRealNameVC = [[CheckRealNameTableViewController alloc] initWithNibName:@"CheckRealNameTableViewController" bundle:nil];
        checkRealNameVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:checkRealNameVC animated:YES];
    }
}
- (IBAction)cancelBtnClick:(id)sender {
    UIButton *button = (id)sender;
    
    if ([button.currentTitle isEqualToString:@"查看实名信息"]) {
        
        CheckRealNameTableViewController *checkRealNameVC = [[CheckRealNameTableViewController alloc] initWithNibName:@"CheckRealNameTableViewController" bundle:nil];
        checkRealNameVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:checkRealNameVC animated:YES];
        
        return;
    }
    if ([button.currentTitle isEqualToString:@"查看我的POS机"]) {
        
        MyPOSViewController *myPOSVC = [[MyPOSViewController alloc] initWithNibName:@"MyPOSViewController" bundle:nil];
        myPOSVC.showType = CANT_EDIT;
        myPOSVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myPOSVC animated:YES];
        
        return;
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
