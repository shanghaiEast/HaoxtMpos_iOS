//
//  ConfirmView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BtnClickBlock)(int btnTag);


NS_ASSUME_NONNULL_BEGIN

@interface ConfirmView : UIView

@property (copy, nonatomic)BtnClickBlock btnClickBlock;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *payBtn;
- (IBAction)payBtnClick:(id)sender;

- (IBAction)cancelBtnClick:(id)sender;

- (void)createView;


@property (nonatomic) int payType;//1-微信，0-支付宝，2-POS机
@property (retain, nonatomic) NSString *moneyString;

@end

NS_ASSUME_NONNULL_END
