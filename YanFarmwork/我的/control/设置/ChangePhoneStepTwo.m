//
//  ChangePhoneStepTwo.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ChangePhoneStepTwo.h"

#import "SetAppViewController.h"

@interface ChangePhoneStepTwo ()

@property (retain, nonatomic) NSTimer *codeTimer;//动态密码时间倒计时；
@property (nonatomic) int timeNumber;//记时时间

@end

@implementation ChangePhoneStepTwo

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"修改手机号" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createView];
}

- (void)createView {
    _confirmBtn.layer.cornerRadius = 2.0f;
    _confirmBtn.layer.masksToBounds = YES;
    

    _getYZMLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *getCodeLoginLabelClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeTouchClick:)];
    [_getYZMLabel addGestureRecognizer:getCodeLoginLabelClick];
}
#pragma mark 动态验证码点击
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
    
    
    [self requestYZM];
    
//    _timeNumber = 60;
//    _codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
//    _getYZMLabel.userInteractionEnabled = NO;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmBtnClick:(id)sender {
    
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
    
    if (_yzmNumber.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入验证码" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    [self requestCommit];
    
}


- (void)requestYZM {
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = @{
                                 @"USR_LOGIN" : _phoneNumber.text,
                                 @"BUS_TYPE" : @"2"
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

- (void)requestCommit {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _phoneNumber.text,@"USR_MOBILE",
                                _yzmNumber.text,@"VCODE",
                                nil];
    
    [YanNetworkOBJ postWithURLString:upLogPhone_two parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            //方法一： 返回到制定界面  但不是根界面的某个界面
            SetAppViewController *homeVC = [[SetAppViewController alloc] init];
            UIViewController *target = nil;
            for (UIViewController * controller in wSelf.navigationController.viewControllers) {
                if ([controller isKindOfClass:[homeVC class]]) {
                    target = controller;
                }
            }
            if (target) {
                [wSelf.navigationController popToViewController:target animated:YES];
            }
            
            
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
