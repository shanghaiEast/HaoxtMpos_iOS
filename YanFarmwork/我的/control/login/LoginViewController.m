//
//  LoginViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/2.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"
#import "ForgetPWViewController.h"

@interface LoginViewController ()

@property (nonatomic) BOOL mindPasswordBool;
@property (nonatomic) BOOL lookPasswordBool;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.view.superview setFrame:CGRectMake(0, 0, ScreenWidth, 700)];
    });
    
    
    [self createView];
}

- (void)createView{
    _mindPasswordBool = NO;
    _lookPasswordBool = NO;
    
    _loginBtn.layer.cornerRadius = 25.0;
    _loginBtn.layer.masksToBounds = YES;
    
    
    if ([ISMINDPW isEqualToString:@"Y"]) {
        _phoneNumber.text = PHONE;
        _passwordNumber.text = PW;
        _mindPasswordBool = YES;
        [_mindPassword setImage:[UIImage imageNamed:@"agreed.png"] forState:UIControlStateNormal];
        
    }else{
        _phoneNumber.text = PHONE;
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

- (IBAction)mindPasswordClick:(id)sender {
    
    _mindPasswordBool = !_mindPasswordBool;
    
    if (_mindPasswordBool == NO) {
        [_mindPassword setImage:[UIImage imageNamed:@"unAgreed.png"] forState:UIControlStateNormal];
        
    }else{
        [_mindPassword setImage:[UIImage imageNamed:@"agreed.png"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)lookPasswordClick:(id)sender {
    _lookPasswordBool = !_lookPasswordBool;
    
    if (_lookPasswordBool == NO) {
        _passwordNumber.secureTextEntry = YES;
        [_lookPassword setImage:[UIImage imageNamed:@"passwordUnShow.png"] forState:UIControlStateNormal];
    }else{
        _passwordNumber.secureTextEntry = NO;
        [_lookPassword setImage:[UIImage imageNamed:@"passwordShow.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)registerAccountClick:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    registerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)forgetPasswordClick:(id)sender {
    //忘记密码
    ForgetPWViewController *forgetPWVC = [[ForgetPWViewController alloc] initWithNibName:@"ForgetPWViewController" bundle:nil];
    forgetPWVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetPWVC animated:YES];
    
}
- (IBAction)loginBtnClick:(id)sender {
    //登录
    if (_phoneNumber.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入手机号" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    if (_phoneNumber.text.length != 11) {
        [ToolsObject showMessageTitle:@"请先输入11位手机号" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    if ([ToolsObject validateMobile:_phoneNumber.text] == NO) {
        [ToolsObject showMessageTitle:@"请先输入正确的手机号" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    if (_passwordNumber.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入密码" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    
    
    
    
    
    if (_mindPasswordBool == YES) {
        NSDictionary *dict = @{@"isMindPW":@"Y", @"password":_passwordNumber.text,@"phone":_phoneNumber.text};
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"mindPW"];
        
    }else{
        NSDictionary *dict = @{@"isMindPW":@"N", @"password":@"",@"phone":_phoneNumber.text};
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"mindPW"];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
