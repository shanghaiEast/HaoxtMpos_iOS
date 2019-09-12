//
//  ChangePhoneStepTwo.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePhoneStepTwo : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *yzmNumber;

@property (weak, nonatomic) IBOutlet UILabel *getYZMLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)confirmBtnClick:(id)sender;



@end

NS_ASSUME_NONNULL_END
