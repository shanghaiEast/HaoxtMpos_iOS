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
    
    
    [_oldPassword setValue:WEAKER_TEXT_LEVEL_1 forKeyPath:@"_placeholderLabel.textColor"];
    [_myNewPassword setValue:WEAKER_TEXT_LEVEL_1 forKeyPath:@"_placeholderLabel.textColor"];
    [_againPassword setValue:WEAKER_TEXT_LEVEL_1 forKeyPath:@"_placeholderLabel.textColor"];
    
        [_myNewPassword addTarget:self action:@selector(textFieldDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        [_againPassword addTarget:self action:@selector(textFieldDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
}

//UITextFieldDelegate
- (void)textFieldDidEnd:(UITextField *)textField {
    NSLog(@"textField.text :%@",textField.text);
    
//    if (textField == _myNewPassword) {
        if ([ToolsObject judgePassWordLegal:textField.text] == NO) {
            [ToolsObject showMessageTitle:@"请输入8-16字母数字组合密码" andDelay:1 andImage:nil];
        }
        
//    }else if (textField == _againPassword) {
//        if ([ToolsObject judgePassWordLegal:textField.text] == NO) {
//            [ToolsObject showMessageTitle:@"请输入8-16字母数字组合密码" andDelay:1 andImage:nil];
//        }
//    }
    
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
    
    
    if (_oldPassword.text.length == 0 && _myNewPassword.text.length == 0 && _againPassword.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入密码" andDelay:1.0 andImage:nil];

        return;
    }

//    if ([ToolsObject validateMobile:_oldPassword.text] == NO && [ToolsObject validateMobile:_myNewPassword.text] == NO  && [ToolsObject validateMobile:_againPassword.text] == NO ) {
//        [ToolsObject showMessageTitle:@"请先输入正确的手机号" andDelay:1.0 andImage:nil];
//
//        return;
//    }
    
    if ([ToolsObject judgePassWordLegal:_againPassword.text] == NO) {
        [ToolsObject showMessageTitle:@"请输入8-16字母数字组合密码" andDelay:1 andImage:nil];
    }
    
    if (![_myNewPassword.text isEqualToString:_againPassword.text]) {
        [ToolsObject showMessageTitle:@"2次输入的密码不一致" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    
    
    [self requestChangePwd];
}


- (void)requestChangePwd {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [ToolsObject md5:_oldPassword.text],@"OLD_USR_LOGIN_PWD",
                                [ToolsObject md5:_againPassword.text],@"NEW_USR_LOGIN_PWD",
                                nil];
    
    [YanNetworkOBJ postWithURLString:password_update parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
          
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
            
            [self popViewClick];
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
