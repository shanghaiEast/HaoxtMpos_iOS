//
//  LoginViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/2.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginSuccessBlock)(BOOL success);


@interface LoginViewController : UIViewController

@property (copy, nonatomic) LoginSuccessBlock loginSuccessBlock;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *passwordNumber;

@property (weak, nonatomic) IBOutlet UIButton *lookPassword;
- (IBAction)lookPasswordClick:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *mindPassword;
- (IBAction)mindPasswordClick:(id)sender;

- (IBAction)forgetPasswordClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtnClick:(id)sender;

- (IBAction)registerAccountClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reginAccount;


@end

NS_ASSUME_NONNULL_END
