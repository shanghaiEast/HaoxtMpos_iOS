//
//  QrCodeView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QrCodeView : UIView

@property (weak, nonatomic) IBOutlet UIView *payView;


@property (weak, nonatomic) IBOutlet UIImageView *payLogoImageView;

@property (weak, nonatomic) IBOutlet UILabel *payTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *payAreaImageView;
@property (weak, nonatomic) IBOutlet UIView *qrCodeView;





@property (retain, nonatomic) UIViewController *rootVC;
@property (nonatomic) int processTag;//支付流程
@property (retain, nonatomic) NSDictionary *detailDict;
- (void)createView;
- (void)createScan:(CGRect)rect;//二维码

@end

NS_ASSUME_NONNULL_END
