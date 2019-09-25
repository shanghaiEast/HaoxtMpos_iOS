//
//  AddCreditCardViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "AddCreditCardViewController.h"

#import "ConfirmSignViewController.h"

#import "CWCommon.h"
#import "CWBankCardModel.h"
#import "CWBankCardCaptureController.h"

@interface AddCreditCardViewController ()<cwDetectCardEdgesDelegate>

@property(nonatomic,strong)CWBankCardCaptureController * cvctrl;

@property(nonatomic,strong) NSString *bankString;

@end

@implementation AddCreditCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    if (ScreenHeight <= 568) {//解决OCR小屏版本bug
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"信用卡认证" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [ToolsObject buttonImageRight:_headBankBtn];
}


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
    
   
    _bankString = [NSString stringWithFormat:@"%@",cardModel.bankName];
    
    [_headBankBtn setTitle:cardModel.cardNum forState:UIControlStateNormal];
    
    [ToolsObject buttonImageRight:_headBankBtn];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)headBankBtnClick:(id)sender {
    [_headBankBtn setTitle:@"请输入银行卡号" forState:UIControlStateNormal];
    
    [self selectPhoto];
}

- (IBAction)commitBtnClick:(id)sender {
   
    if (_headBankBtn.currentTitle.length == 0 || [_headBankBtn.currentTitle isEqualToString:@"请输入银行卡号"]) {
        [ToolsObject showMessageTitle:@"请输入银行卡号" andDelay:1 andImage:nil];
        return;
    }
    
    if (_nameTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请输入姓名" andDelay:1 andImage:nil];
        return;
    }
    
    if (_idCardTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请输入身份证号" andDelay:1 andImage:nil];
        return;
    }
    
    if (_idCardTextField.text.length != 18) {
        [ToolsObject showMessageTitle:@"身份证号输入有误" andDelay:1 andImage:nil];
        return;
    }
    
    if (_phoneTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请输入预留手机号" andDelay:1 andImage:nil];
        return;
    }
    
    if ([ToolsObject validateMobile:_phoneTextField.text] == NO) {
        [ToolsObject showMessageTitle:@"手机号格式不正确" andDelay:1 andImage:nil];
        return;
    }
    
    
    
    [self requestCommit];
}


- (void)requestCommit{
    
//    CARD_NO    银行卡号
//    BANK_NM    银行名称
//    NAME    姓名
//    CER_NO    身份证号
//    BANK_PHONE    银行预留手机号
    
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;

    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",_headBankBtn.currentTitle],@"CARD_NO",
                                [NSString stringWithFormat:@"%@",_bankString],@"BANK_NM",
                                [NSString stringWithFormat:@"%@",_nameTextField.text],@"NAME",
                                [NSString stringWithFormat:@"%@",_idCardTextField.text],@"CER_NO",
                                [NSString stringWithFormat:@"%@",_phoneTextField.text],@"BANK_PHONE",
                                nil];

    [YanNetworkOBJ postWithURLString:usr_authPromoteLimit parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
            confirmSignVC.payType = TYPE_CARDCER;
            confirmSignVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:confirmSignVC animated:YES];
           

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
