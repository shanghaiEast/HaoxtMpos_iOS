//
//  CreditCardCerTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "CreditCardCerTableViewCell.h"

@implementation CreditCardCerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self createHeaderView];
}

- (void)createHeaderView {
    _bgImageView.layer.cornerRadius = 5.0f;
    _bgImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
