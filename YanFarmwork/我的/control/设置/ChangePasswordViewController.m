//
//  ChangePasswordViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"修改密码" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _confirmBtn.layer.cornerRadius = 2.0f;
    _confirmBtn.layer.masksToBounds = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmBtnClick:(id)sender {
    
//    if (_phoneNumber.text.length == 0) {
//        [ToolsObject showMessageTitle:@"请先输入手机号" andDelay:1.0 andImage:nil];
//
//        return;
//    }
//
//    if (_phoneNumber.text.length != 11) {
//        [ToolsObject showMessageTitle:@"请先输入11位手机号" andDelay:1.0 andImage:nil];
//
//        return;
//    }
//
//    if ([ToolsObject validateMobile:_phoneNumber.text] == NO) {
//        [ToolsObject showMessageTitle:@"请先输入正确的手机号" andDelay:1.0 andImage:nil];
//
//        return;
//    }
}
@end
