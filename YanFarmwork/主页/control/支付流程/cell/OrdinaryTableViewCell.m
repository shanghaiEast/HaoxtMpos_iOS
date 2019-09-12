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
    
    if (_payWayBlock) {
        _payWayBlock(3);
    }
    
    if (_saveMoneyBlock) {
        _saveMoneyBlock([NSDictionary new]);
    }
}
@end
