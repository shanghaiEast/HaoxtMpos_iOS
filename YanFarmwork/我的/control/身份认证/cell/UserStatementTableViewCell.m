//
//  UserStatementTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "UserStatementTableViewCell.h"

#import "CWCommon.h"
#import "UserShopDetailTableViewController.h"

#import "CWBankCardModel.h"
#import "CWBankCardCaptureController.h"


@interface UserStatementTableViewCell ()<cwDetectCardEdgesDelegate>

@property(nonatomic,strong)CWBankCardCaptureController * cvctrl;

@end

@implementation UserStatementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [self createHeaderView];
}

- (void)createHeaderView {
    
    [_accountNameTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
    
     [_accountNoTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    _bankCardImageView.tag = 1;
    UITapGestureRecognizer *touch_bankCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    [_bankCardImageView addGestureRecognizer:touch_bankCard];
    
    
    [_headquartersBankBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _headquartersBankBtn.imageView.image.size.width, 0, _headquartersBankBtn.imageView.image.size.width)];
    [_headquartersBankBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _headquartersBankBtn.titleLabel.bounds.size.width, 0, -_headquartersBankBtn.titleLabel.bounds.size.width)];
    
    [_provinceAddresBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _provinceAddresBtn.imageView.image.size.width, 0, _provinceAddresBtn.imageView.image.size.width)];
    [_provinceAddresBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _provinceAddresBtn.titleLabel.bounds.size.width, 0, -_provinceAddresBtn.titleLabel.bounds.size.width)];
    
    [_cityAddresBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _cityAddresBtn.imageView.image.size.width, 0, _cityAddresBtn.imageView.image.size.width)];
    [_cityAddresBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _cityAddresBtn.titleLabel.bounds.size.width, 0, -_cityAddresBtn.titleLabel.bounds.size.width)];
    
    [_branchBankBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _branchBankBtn.imageView.image.size.width, 0, _branchBankBtn.imageView.image.size.width)];
    [_branchBankBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _branchBankBtn.titleLabel.bounds.size.width, 0, -_branchBankBtn.titleLabel.bounds.size.width)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//总行
- (IBAction)headquartersBankBtnClick:(id)sender {
    
}
//省份选择
- (IBAction)provinceBtnClick:(id)sender {
    
}
//城市选择
- (IBAction)cityBtnClick:(id)sender {
    
}
//支行
- (IBAction)branchBankBtnClick:(id)sender {
    
}



- (IBAction)nextBtnClick:(id)sender {
    UserShopDetailTableViewController *usershopDetailVC = [[UserShopDetailTableViewController alloc] initWithNibName:@"UserShopDetailTableViewController" bundle:nil];
    usershopDetailVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:usershopDetailVC animated:YES];
    
}



//-----------------------以下为银行卡识别ocr
-(void)selectPhoto:(UITapGestureRecognizer *)tapGesture{
    _cvctrl = [[CWBankCardCaptureController alloc]init];
    
    _cvctrl.delegate = self;
    
    _cvctrl.isRotate =    [[CWCommon getValueForKey:@"PortritBankCard"] boolValue];//是否支持竖版银行卡识别
    _cvctrl.cardType = CWBankCardTypeFront;
    //图片清晰度分数阈值 推荐为0.65
    _cvctrl.cardQuality = 0.65f;
    
    //授权码
    _cvctrl.authCodeStr = AuthCodeString;
    
    [_rootVC presentViewController:_cvctrl animated:YES completion:NULL];
    
}

-(void)cwBankCardDetectDeleagte:(CWBankCardModel *)cardModel {
    
//    @property(nonatomic,strong) NSString   * cardNum;//银行卡号
//
//    @property(nonatomic,strong) NSString   * bankName;//银行名称
//    @property(nonatomic,strong) NSString   * cardName;//银行卡名称
//    @property(nonatomic,strong) NSString   * cardType;//银行类型（借记卡/贷记卡/...)
//
//    @property(nonatomic,strong)UIImage *  cardImage;//银行卡图片
    
    NSLog(@"%@",cardModel);
    
    _bankCardImageView.image = cardModel.cardImage;
    
    _accountNameTextField.text = [NSString stringWithFormat:@"%@",cardModel.bankName];
    
    _accountNoTextField.text = [NSString stringWithFormat:@"%@",cardModel.cardNum];
}
@end
