//
//  ForgetPWViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForgetPWViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *yzmNumber;

@property (weak, nonatomic) IBOutlet UILabel *getYZMLabel;

@property (weak, nonatomic) IBOutlet UITextField *passwordNumber;



@property (weak, nonatomic) IBOutlet UIButton *lookPassword;
- (IBAction)lookPasswordClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtnClick:(id)sender;


@end

NS_ASSUME_NONNULL_END
