//
//  AddCreditCardViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddCreditCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *headBankBtn;
- (IBAction)headBankBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
- (IBAction)commitBtnClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
