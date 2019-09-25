//
//  UserStatementTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "UserStatementTableViewCell.h"

#import "UserShopDetailTableViewController.h"

#import "CWCommon.h"
#import "CWBankCardModel.h"
#import "CWBankCardCaptureController.h"

#import "CityChooseView.h"

#import "BankSelectViewController.h"

#import "ConfirmSignViewController.h"

#import "AreaPickerView.h"


@interface UserStatementTableViewCell ()<cwDetectCardEdgesDelegate>

@property(nonatomic,strong)CWBankCardCaptureController * cvctrl;

@property(strong, nonatomic) AreaPickerView *areaPickerView;

@property(nonatomic,retain) CityChooseView *cityChooseView;

@property(nonatomic) BOOL bankCardPicBool;

@property(nonatomic,retain) NSDictionary *proviceDict, *cityDict, *headBankDict, *footBankDict;


@end

@implementation UserStatementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bankCardPicBool = NO;
    
    [self createHeaderView];
}

- (void)createHeaderView {
    
     [self requestCommitAll];
    
    [_accountNameTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
    
     [_accountNoTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    _bankCardImageView.tag = 1;
    UITapGestureRecognizer *touch_bankCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    [_bankCardImageView addGestureRecognizer:touch_bankCard];
    
    
    [_headquartersBankBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _headquartersBankBtn.imageView.image.size.width, 0, _headquartersBankBtn.imageView.image.size.width)];
    [_headquartersBankBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _headquartersBankBtn.titleLabel.bounds.size.width, 0, -_headquartersBankBtn.titleLabel.bounds.size.width)];
    
    [_provinceAddresBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _provinceAddresBtn.imageView.image.size.width, 0, _provinceAddresBtn.imageView.image.size.width)];
    [_provinceAddresBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _provinceAddresBtn.titleLabel.bounds.size.width, 0, -_provinceAddresBtn.titleLabel.bounds.size.width)];
    
    [_branchBankBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _branchBankBtn.imageView.image.size.width, 0, _branchBankBtn.imageView.image.size.width)];
    [_branchBankBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _branchBankBtn.titleLabel.bounds.size.width, 0, -_branchBankBtn.titleLabel.bounds.size.width)];
}

- (void)viewEdgeInsetsMake {
    [ToolsObject buttonImageRight:self.headquartersBankBtn];
    [ToolsObject buttonImageRight:self.branchBankBtn];
    [ToolsObject buttonImageRight:self.provinceAddresBtn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//总行
- (IBAction)headquartersBankBtnClick:(id)sender {
    
    if (_accountNameTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入账户名称" andDelay:1 andImage:nil];
        return;
    }
    
    if (_accountNoTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入结算账户" andDelay:1 andImage:nil];
        return;
    }
    
     typeof(self) wSelf = self;
    BankSelectViewController *bankVC = [[BankSelectViewController alloc] initWithNibName:@"BankSelectViewController" bundle:nil];
    bankVC.showTag = 1;
    bankVC.headBankName = @"AGTSTL_BNK_LIST";
    bankVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:bankVC animated:YES];
    bankVC.getHeadBankBlock = ^(NSDictionary * _Nonnull dict) {
        NSLog(@"dict == %@",dict);
//        {
//            "fldVal" : "103100000026",
//            "fldExp" : "中国农业银行股份有限公司",
//            "agtSessionEntity" :"",
//            "fldTyp" : "x",
//            "fldNm" : "AGTSTL_BNK_LIST",
//            "fldExpDesc" : "中国农业银行股份有限公司",
//            "tmSmp" : "20180116121212",
//            "fldOrder" : 2
//        }
        
        wSelf.headBankDict = dict;
        [wSelf.headquartersBankBtn setTitle:[wSelf.headBankDict objectForKey:@"fldExp"] forState:UIControlStateNormal];
        
         [wSelf.branchBankBtn setTitle:@"请查询开户支行" forState:UIControlStateNormal];
        
        [self viewEdgeInsetsMake];
    };
    
}
//支行
- (IBAction)branchBankBtnClick:(id)sender {
    
    if (_headquartersBankBtn.currentTitle.length == 0 || [_provinceAddresBtn.currentTitle isEqualToString:@"请查询开户总行"]) {
        [ToolsObject showMessageTitle:@"请先选择开户总行" andDelay:1 andImage:nil];
        return;
    }
    
    if (_provinceAddresBtn.currentTitle.length == 0 || [_provinceAddresBtn.currentTitle isEqualToString:@"选择省市"]) {
        [ToolsObject showMessageTitle:@"请先选择省份" andDelay:1 andImage:nil];
        return;
    }
    
//    if (_cityAddresBtn.currentTitle.length == 0 || [_cityAddresBtn.currentTitle isEqualToString:@"选择市"]) {
//        [ToolsObject showMessageTitle:@"请先选择市" andDelay:1 andImage:nil];
//        return;
//    }
    
     typeof(self) wSelf = self;
    BankSelectViewController *bankVC = [[BankSelectViewController alloc] initWithNibName:@"BankSelectViewController" bundle:nil];
    bankVC.showTag = 2;
    bankVC.headBankDict = _headBankDict;
    bankVC.proviceDict = _proviceDict;
    bankVC.cityDict = _cityDict;
    bankVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:bankVC animated:YES];
    bankVC.getFootBankBlock = ^(NSDictionary * _Nonnull dict) {
        NSLog(@"dict == %@",dict);
        
        wSelf.footBankDict = dict;
        
        [wSelf.branchBankBtn setTitle:[wSelf.footBankDict objectForKey:@"lbnkNm"] forState:UIControlStateNormal];
        
        [self viewEdgeInsetsMake];
    };
}

//省份选择
- (IBAction)provinceBtnClick:(id)sender {
    
    typeof(self) wSelf = self;
    _areaPickerView = [[[NSBundle mainBundle] loadNibNamed:@"AreaPickerView" owner:self options:nil] lastObject];
    [_areaPickerView setFrame:_rootVC.view.bounds];
    [_areaPickerView createPickerView];
    [_rootVC.view addSubview:_areaPickerView];
    _areaPickerView.selectProviceAndCityBlock = ^(NSDictionary * _Nonnull proviceDict, NSDictionary * _Nonnull cityDict) {
        NSLog(@"proviceDict: %@\ncityDict: %@",proviceDict,cityDict);
        //    proviceDict: {
        //        LABEL = "\U6cb3\U5317\U7701";
        //        VALUE = 1200;
        //    }
        //    cityDict: {
        //        LABEL = "\U8861\U6c34\U5e02";
        //        VALUE = 1480;
        //    }
        
        wSelf.proviceDict = proviceDict;
        wSelf.cityDict = cityDict;
        
        [wSelf.provinceAddresBtn setTitle:[NSString stringWithFormat:@"%@%@",[proviceDict objectForKey:@"LABEL"],[cityDict objectForKey:@"LABEL"]] forState:UIControlStateNormal];
        
        [wSelf viewEdgeInsetsMake];
    };
    
    
//    _cityChooseView = [[[NSBundle mainBundle] loadNibNamed:@"CityChooseView" owner:_rootVC options:nil] lastObject];
//    [_cityChooseView setFrame:_rootVC.view.bounds];
//    _cityChooseView.showTag = 1;
//    [_cityChooseView createView];
//    [_rootVC.view addSubview:_cityChooseView];
//    _cityChooseView.getProviceBlock = ^(NSDictionary * _Nonnull dict) {
//        _proviceDict = dict;
//
////        {
////            "LABEL" : "甘肃省",
////            "VALUE" : "8200"
////        }
//
//        [_provinceAddresBtn setTitle:[_proviceDict objectForKey:@"LABEL"] forState:UIControlStateNormal];
//        [_cityAddresBtn setTitle:@"选择市" forState:UIControlStateNormal];
//
//        _cityChooseView.hidden = YES;
//        [_cityChooseView removeFromSuperview];
//
//        [self viewEdgeInsetsMake];
//    };
    
}
////城市选择
//- (IBAction)cityBtnClick:(id)sender {
//    if (_provinceAddresBtn.currentTitle.length == 0 || [_provinceAddresBtn.currentTitle isEqualToString:@"选择省市"]) {
//        [ToolsObject showMessageTitle:@"请先选择省份" andDelay:1 andImage:nil];
//        return;
//    }
//     _cityChooseView = [[[NSBundle mainBundle] loadNibNamed:@"CityChooseView" owner:_rootVC options:nil] lastObject];
//    [_cityChooseView setFrame:_rootVC.view.bounds];
//    _cityChooseView.showTag = 2;
//    _cityChooseView.proviceDict = _proviceDict;
//    [_cityChooseView createView];
//    [_rootVC.view addSubview:_cityChooseView];
//    _cityChooseView.getCityBlock = ^(NSDictionary * _Nonnull dict) {
//         _cityDict = dict;
//
////        {
////            "LABEL" : "西城区",
////            "VALUE" : "1022"
////        }
//
//         [_cityAddresBtn setTitle:[_cityDict objectForKey:@"LABEL"] forState:UIControlStateNormal];
//
//
//        _cityChooseView.hidden = YES;
//        [_cityChooseView removeFromSuperview];
//
//        [self viewEdgeInsetsMake];
//    };
//}



- (IBAction)nextBtnClick:(id)sender {
    
    if (_bankCardPicBool == NO) {
        [ToolsObject showMessageTitle:@"请先上传银行卡照片" andDelay:1 andImage:nil];
    }
    
    if (_accountNameTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入账号名称" andDelay:1 andImage:nil];
    }
    
    if (_accountNoTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入结算账户" andDelay:1 andImage:nil];
    }
    
   
    [self requestCommit];
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
    
//    @property(nonatomic,strong) NSString   * cardNum;//银行卡号//6217560800027564300
//
//    @property(nonatomic,strong) NSString   * bankName;//银行名称//中国银行
//    @property(nonatomic,strong) NSString   * cardName;//银行卡名称
//    @property(nonatomic,strong) NSString   * cardType;//银行类型（借记卡/贷记卡/...)
//
//    @property(nonatomic,strong)UIImage *  cardImage;//银行卡图片
    
    NSLog(@"%@",cardModel);
    
    _bankCardImageView.image = cardModel.cardImage;
    
    _accountNameTextField.text = [NSString stringWithFormat:@"%@",cardModel.bankName];
    
    _accountNoTextField.text = [NSString stringWithFormat:@"%@",cardModel.cardNum];
    
    
    [self requestCommitPic:@"3" withImage:cardModel.cardImage];
}

- (void)requestCommitPic:(NSString *)typeStr withImage:(UIImage *)image {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    
    //UIImage转换为NSData
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0) ;
    NSString *base64String = [ToolsObject dataWitbBase64ToStrimg:imageData];
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                base64String,@"file",
                                typeStr,@"FILE_TYPE",
                                nil];
    
    [YanNetworkOBJ postWithURLString:pub_uploadFile parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.bankCardPicBool = YES;
    
            
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

- (void)requestCommit {
    
    /*                            nil];
     STL_CARD_NO    结算卡
     STL_BANK_NAME_HO    结算卡总行名称
     STL_BANK_NUM_HO    结算卡总行联行号
     STL_BANK_NAME_SUB    结算卡支行名称
     STL_BANK_NUM_SUB    结算卡支行联行号
     STL_BANK_PROV    结算卡归属省
     STL_BANK_CITY    结算卡归属市
     */
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
   
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _accountNoTextField.text,@"STL_CARD_NO",
                                [_headBankDict objectForKey:@"fldExp"],@"STL_BANK_NAME_HO",
                                [_headBankDict objectForKey:@"fldVal"],@"STL_BANK_NUM_HO",
                                 [_footBankDict objectForKey:@"lbnkNm"],@"STL_BANK_NAME_SUB",
                                [_footBankDict objectForKey:@"lbnkNo"],@"STL_BANK_NUM_SUB",
                                [_proviceDict objectForKey:@"VALUE"],@"STL_BANK_PROV",
                                [_cityDict objectForKey:@"VALUE"],@"STL_BANK_CITY",
                                nil];
    
    [YanNetworkOBJ postWithURLString:stl_addStlBankInfo parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            [self requestCommitAll];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}


- (void)requestCommitAll {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
//    MERC_NM    商户名称        N
//    PARENT_MCC    所属行业-大类        Y    默认当日
//    MCC_CD    所属行业-明细
//    PROVINCE    省
//    CITY    市
//    STL_CYCLE    结算周期            0-D0 1-T1
//    ACO_TYP_LIST    账户类型            0-对公，1-对私
    
    
    NSDictionary *parametDic = [[NSDictionary alloc] init];
    
    [YanNetworkOBJ postWithURLString:usr_open parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
            confirmSignVC.payType = TYPE_REALNAME;
            confirmSignVC.hidesBottomBarWhenPushed = YES;
            [_rootVC.navigationController pushViewController:confirmSignVC animated:YES];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

@end
