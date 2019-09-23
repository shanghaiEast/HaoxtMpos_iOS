//
//  ChangeDebitCardViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ChangeDebitCardViewController.h"
#import "BankSelectViewController.h"

#import "CWCommon.h"
#import "CWBankCardModel.h"
#import "CWBankCardCaptureController.h"

@interface ChangeDebitCardViewController ()<cwDetectCardEdgesDelegate>

@property(nonatomic,strong)CWBankCardCaptureController * cvctrl;

@property(nonatomic,retain) NSDictionary *proviceDict, *cityDict, *headBankDict, *footBankDict;

@end

@implementation ChangeDebitCardViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    if (ScreenHeight <= 568) {//解决OCR小屏版本bug
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"更改结算卡" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _oldUserCardNameLabel.text = [_detailDict objectForKey:@"STL_ACO_NM"];
    _oldUserCardIDLabel.text = [_detailDict objectForKey:@"STL_ACO_NO"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-----------------------以下为银行卡识别ocr
-(void)selectPhoto{
    _cvctrl = [[CWBankCardCaptureController alloc]init];
    
    _cvctrl.delegate = self;
    
    _cvctrl.isRotate =    [[CWCommon getValueForKey:@"PortritBankCard"] boolValue];//是否支持竖版银行卡识别
    _cvctrl.cardType = CWBankCardTypeFront;
    //图片清晰度分数阈值 推荐为0.65
    _cvctrl.cardQuality = 0.65f;
    
    //授权码
    _cvctrl.authCodeStr = AuthCodeString;
    
    [self presentViewController:_cvctrl animated:YES completion:NULL];
    
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
    
    [_cardIdBtn setTitle:[NSString stringWithFormat:@"%@",cardModel.cardNum] forState:UIControlStateNormal];
    
//    [_openCardBankBtn setTitle:[NSString stringWithFormat:@"%@",cardModel.bankName] forState:UIControlStateNormal];
   
}


- (IBAction)cardIdBtnClick:(id)sender {
    //填写储蓄卡
}

- (IBAction)scanBtnClick:(id)sender {
    //扫描
    
    [self selectPhoto];
}

- (IBAction)openCardBankBtnClick:(id)sender {
    //开户行
    typeof(self) wSelf = self;
    BankSelectViewController *bankVC = [[BankSelectViewController alloc] initWithNibName:@"BankSelectViewController" bundle:nil];
    bankVC.showTag = 1;
    bankVC.headBankName = @"AGTSTL_BNK_LIST";
    bankVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bankVC animated:YES];
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
        
        [wSelf.openCardBankBtn setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"fldExp"]] forState:UIControlStateNormal];
        
        [wSelf.branchBankBtn setTitle:@"请选择开户行分行" forState:UIControlStateNormal];
    };
    
}

- (IBAction)openCardAddressBtnClick:(id)sender {
    //开户行省市
}
- (IBAction)branckBankBtnClick:(id)sender {
    //开户行分行
    
//    if (_openCardBankBtn.currentTitle.length == 0 || [_openCardAddressBtn.currentTitle isEqualToString:@"点击此处识别开户行"]) {
//        [ToolsObject showMessageTitle:@"点击此处识别开户行" andDelay:1 andImage:nil];
//        return;
//    }
//
//    if (_openCardAddressBtn.currentTitle.length == 0 || [_openCardAddressBtn.currentTitle isEqualToString:@"请选择开户行省市"]) {
//        [ToolsObject showMessageTitle:@"请选择开户行省市" andDelay:1 andImage:nil];
//        return;
//    }
    
    typeof(self) wSelf = self;
    BankSelectViewController *bankVC = [[BankSelectViewController alloc] initWithNibName:@"BankSelectViewController" bundle:nil];
    bankVC.showTag = 2;
    bankVC.headBankDict = _headBankDict;
    bankVC.proviceDict = _proviceDict;
    bankVC.cityDict = _cityDict;
    bankVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bankVC animated:YES];
    bankVC.getFootBankBlock = ^(NSDictionary * _Nonnull dict) {
        NSLog(@"dict == %@",dict);
        
//        {
//            "corpOrg" :"",
//            "cityCd" :"",
//            "lbnkNo" : "102100099996",
//            "admCity" :"",
//            "admProv" :"",
//            "provCd" :"",
//            "bnkMbl" :"",
//            "updTm" :"",
//            "creUid" :"",
//            "lbnkNm" : "测试银行",
//            "admRgn" :"",
//            "lbnkCd" :"",
//            "blbnkNo" :"",
//            "tmSmp" :"",
//            "updUid" :""
//        }
        
        wSelf.footBankDict = dict;
        
        [wSelf.branchBankBtn setTitle:[wSelf.footBankDict objectForKey:@"lbnkNm"] forState:UIControlStateNormal];
    };
}

- (IBAction)commitBtnClick:(id)sender {
    //提交
#pragma warning 临时数据
    [_openCardAddressBtn setTitle:@"北京朝阳区" forState:UIControlStateNormal];
    
    if (_cardIdBtn.currentTitle.length == 0) {
        [ToolsObject showMessageTitle:@"请填写储蓄卡号" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_headBankDict.count == 0) {
        [ToolsObject showMessageTitle:@"请选择开户行" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_openCardAddressBtn.currentTitle.length == 0) {
        [ToolsObject showMessageTitle:@"请选择开户行省市" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_footBankDict.count == 0) {
        [ToolsObject showMessageTitle:@"请选择开户行分行" andDelay:1 andImage:nil];
        
        return;
    }
    
   
    [self requestChange];
}




- (void)requestChange {
    
//    STL_BANK_PROV    省
//    STL_BANK_CITY    市
//    STL_BNK_NO    支行号
//    STL_BNK_NM    支行名称
//    STL_ACO_NO    卡号
//    STL_BNK_LIST    总行行号
//    BANK_NM    总行名称
    
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",@"2900"],@"STL_BANK_PROV",
                                [NSString stringWithFormat:@"%@",@"2916"],@"STL_BANK_CITY",
                                [NSString stringWithFormat:@"%@",[_footBankDict objectForKey:@"lbnkNo"]],@"STL_BNK_NO",
                                [NSString stringWithFormat:@"%@",_branchBankBtn.currentTitle],@"STL_BNK_NM",
                                [NSString stringWithFormat:@"%@",_cardIdBtn.currentTitle],@"STL_ACO_NO",
                                [NSString stringWithFormat:@"%@",[_headBankDict objectForKey:@"fldVal"]],@"STL_BNK_LIST",
                                [NSString stringWithFormat:@"%@",_openCardBankBtn.currentTitle],@"BANK_NM",
                                nil];
    
    [YanNetworkOBJ postWithURLString:stl_updStlBankInfo parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            if (_bankChangeSuccessBlock) {
                _bankChangeSuccessBlock([NSDictionary new]);
            }
            
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
