//
//  ForgetPWViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ForgetPWViewController.h"

@interface ForgetPWViewController ()

@property (nonatomic) BOOL lookPasswordBool;
@property (nonatomic) BOOL agreementBool;

@property (retain, nonatomic) NSTimer *codeTimer;//动态密码时间倒计时；
@property (nonatomic) int timeNumber;//记时时间

@end

@implementation ForgetPWViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _myScrollView.userInteractionEnabled = YES;
        [_myScrollView setContentSize:CGSizeMake(0, 560)];
    });
    
    [self createBackBtn];
    [self createView];
}

- (void)createBackBtn {

    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, kStatusBarHeight, 44, 44)];
    backImageView.image = [UIImage imageNamed:@"backBtnImage"];
    backImageView.contentMode = UIViewContentModeLeft;
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    
    UITapGestureRecognizer *touchPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    [backImageView addGestureRecognizer:touchPress];
    
}

- (void)createView {
    
    _myScrollView.userInteractionEnabled = YES;
    _myScrollView.contentSize = CGSizeMake(0, 732);
    
    _agreementBool = NO;
    _lookPasswordBool = NO;
    _lookPassword.hidden = YES;
    
    _loginBtn.layer.cornerRadius = 25.0;
    _loginBtn.layer.masksToBounds = YES;
    
    
    _getYZMLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *getCodeLoginLabelClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeTouchClick:)];
    [_getYZMLabel addGestureRecognizer:getCodeLoginLabelClick];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 活动动态密码点击
- (void)getCodeTouchClick:(UITapGestureRecognizer *)tapTouch
{
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
    
    
    _getYZMLabel.enabled = NO;
    
    [self  requestYZM];
    
    
}

#pragma mark 倒计时
- (void)timeStart
{
    _timeNumber --;
    if (_timeNumber == 0) {
        //        _getCodeLabel.enabled = YES;
        //        _getCodeLabel.userInteractionEnabled = YES;
        _getYZMLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _getYZMLabel.text = @"获取验证码";
        [_codeTimer invalidate];
        _codeTimer = nil;
        
    }else{
        
        _getYZMLabel.text = [NSString stringWithFormat:@"剩余%d秒",_timeNumber];
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

- (IBAction)loginBtnClick:(id)sender {
    
    if (_phoneNumber.text.length != 11) {
        [ToolsObject showMessageTitle:@"请先输入11位手机号" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    if ([ToolsObject validateMobile:_phoneNumber.text] == NO) {
        [ToolsObject showMessageTitle:@"请先输入正确的手机号" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    if (_yzmNumber.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入验证码" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    
    [self requestChangePwd];
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)requestYZM {
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = @{
                                 @"USR_LOGIN" : _phoneNumber.text,
                                 @"BUS_TYPE" : @"1"
                                 };
    
    //18817370409
    [YanNetworkOBJ postWithURLString:vcode_get parameters:parametDic success:^(id  _Nonnull responseObject) {
        
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.timeNumber = 60;
            wSelf.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
            wSelf.getYZMLabel.userInteractionEnabled = NO;
            
        }else{
            //filed
            wSelf.getYZMLabel.enabled = YES;
            
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        wSelf.getYZMLabel.enabled = YES;
        
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

- (void)requestChangePwd {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _phoneNumber.text,@"USR_LOGIN",
                                _yzmNumber.text,@"VERIFICATION_CODE",
                                [ToolsObject md5:_passwordNumber.text],@"NEW_USR_LOGIN_PWD",
                                nil];
    
    [YanNetworkOBJ postWithURLString:password_find parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            if (wSelf.backPhoneAndPwdBlock) {
                wSelf.backPhoneAndPwdBlock(wSelf.phoneNumber.text, wSelf.passwordNumber.text);
            }
            
            [self goBack];
            
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
