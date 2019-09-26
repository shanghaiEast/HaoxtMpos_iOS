//
//  ConfirmView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ConfirmView.h"

@implementation ConfirmView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (void)createView{
    _bottomView.layer.cornerRadius = 7.0f;
    _bottomView.layer.masksToBounds = YES;
    
    _payBtn.layer.cornerRadius = 7.0f;
    _payBtn.layer.masksToBounds = YES;
    
    _priceLabel.text = _moneyString;
    
    if (_payType == 0) {
        _goodsNameLabel.text = @"支付宝";
        [_payBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    }
    if (_payType == 1) {
        _goodsNameLabel.text = @"微信";
        [_payBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    }
    if (_payType == 2) {
        _goodsNameLabel.text = @"POS机";
        [_payBtn setTitle:@"POS机支付" forState:UIControlStateNormal];
    }
}


- (IBAction)payBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if (_btnClickBlock) {
        _btnClickBlock(1);
    }
}

- (IBAction)cancelBtnClick:(id)sender {
    if (_btnClickBlock) {
        _btnClickBlock(0);
    }
}
@end
