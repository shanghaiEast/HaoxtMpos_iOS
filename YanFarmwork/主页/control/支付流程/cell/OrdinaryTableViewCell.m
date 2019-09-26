//
//  OrdinaryTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "OrdinaryTableViewCell.h"

@implementation OrdinaryTableViewCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)chooseBankClick:(id)sender {
    if (_chooseBankBlock) {
        _chooseBankBlock(YES);
    }
}

- (IBAction)loginBtnClick:(id)sender {
    
    [self.moneyNumber resignFirstResponder];
    
    if (_payWayBlock) {
        _payWayBlock(2);
    }
    
    if (_saveMoneyBlock) {
        _saveMoneyBlock([NSDictionary new]);
    }
}
@end
