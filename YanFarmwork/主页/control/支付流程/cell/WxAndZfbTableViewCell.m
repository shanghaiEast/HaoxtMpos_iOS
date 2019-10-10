//
//  WxAndZfbTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "WxAndZfbTableViewCell.h"

@implementation WxAndZfbTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _loginBtn.layer.cornerRadius = 1.0f;
    _loginBtn.layer.masksToBounds = YES;
    
    NSString *numStr = [SHOP_DETAIL objectForKey:@"STL_ACO_NO"];
    numStr = [numStr substringFromIndex:numStr.length-4];
    NSString *bankStr = [NSString stringWithFormat:@"%@(%@)",[SHOP_DETAIL objectForKey:@"STL_BANK_NAME"],numStr];
    [_chooseBankBtn setTitle:bankStr forState:UIControlStateNormal];
    
    
}

- (void)createCell{
    if (_payWayTag == 0) {
        [_chooseZFBBtn setImage:[UIImage imageNamed:@"chooseRound.png"] forState:UIControlStateNormal];
        [_chooseWXBtn setImage:[UIImage imageNamed:@"unChooseRound.png"] forState:UIControlStateNormal];
    }else{
        [_chooseZFBBtn setImage:[UIImage imageNamed:@"unChooseRound.png"] forState:UIControlStateNormal];
        [_chooseWXBtn setImage:[UIImage imageNamed:@"chooseRound.png"] forState:UIControlStateNormal];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)chooseBankClick:(id)sender {
    if (_chooseBankBlock) {
        _chooseBankBlock(YES);
    }
}
- (IBAction)payWayChooseClick:(id)sender {
    UIButton *button = (id)sender;
    
    _payWayTag = (int)button.tag;
    [self createCell];
    
    if (_payWayBlock) {
        _payWayBlock((int)button.tag);
    }
}
- (IBAction)loginBtnClick:(id)sender {
    
     [self.moneyNumber resignFirstResponder];
    
    if (_saveMoneyBlock) {
        _saveMoneyBlock([NSDictionary new]);
    }
}
@end
