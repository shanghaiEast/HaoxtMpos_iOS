//
//  ConfirmSignViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PAY_SUCCESS    = 0,
    PAY_FIELD      = 1,
    PAY_UNKONW     = 2,
    TYPE_REALNAME  = 5,
    TYPE_CARDCER   = 6,
    TYPE_TOOLS     = 7,
    
} payType;




@interface ConfirmSignViewController : UIViewController

@property(nonatomic) int payType;//0==成功，1==失败，2==未知, 5==实名认证结果, 6==信用卡绑定成功， 7==机具绑定成功

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@property (weak, nonatomic) IBOutlet UILabel *title_main;

@property (weak, nonatomic) IBOutlet UILabel *title_other;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelBtnClick:(id)sender;




@property (nonatomic) int processTag;//支付流程


@end

NS_ASSUME_NONNULL_END
