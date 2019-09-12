//
//  ToolsClaimsViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolsClaimsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *recipientNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *recipientPhoneTextField;


@property (weak, nonatomic) IBOutlet UIButton *recipientAddressBtn;
- (IBAction)recipientAddressBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *specificAddressTextView;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;




@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
- (IBAction)commitBtnClick:(id)sender;



@property (weak, nonatomic) IBOutlet UIView *BGView;


@end

NS_ASSUME_NONNULL_END
