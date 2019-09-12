//
//  UserShopDetailTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "UserShopDetailTableViewCell.h"

#import "ConfirmSignViewController.h"

@implementation UserShopDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self createHeaderView];
}

- (void)createHeaderView {
    
    [_accountNameTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_accountNoTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_chooseIndustryBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _chooseIndustryBtn.imageView.image.size.width, 0, _chooseIndustryBtn.imageView.image.size.width)];
    [_chooseIndustryBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _chooseIndustryBtn.titleLabel.bounds.size.width, 0, -_chooseIndustryBtn.titleLabel.bounds.size.width)];
    
    [_chooseAreaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _chooseAreaBtn.imageView.image.size.width, 0, _chooseAreaBtn.imageView.image.size.width)];
    [_chooseAreaBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _chooseAreaBtn.titleLabel.bounds.size.width, 0, -_chooseAreaBtn.titleLabel.bounds.size.width)];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//选择行业
- (IBAction)chooseIndustryBtnClick:(id)sender {
    
}
//选择q地区
- (IBAction)chooseAreaBtnClick:(id)sender {
    
}

- (IBAction)nextBtnClick:(id)sender {
    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
    confirmSignVC.payType = TYPE_REALNAME;
    confirmSignVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:confirmSignVC animated:YES];
    
}
@end
