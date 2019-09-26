//
//  PayResultViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PayResultViewController.h"

#import "LocationObject.h"

#import "ConfirmSignViewController.h"

#import "SignatureView.h"

@interface PayResultViewController ()

@property (retain, nonatomic) SignatureView *signatureView;

@property (retain, nonatomic) NSDictionary *resultDict;

//接口查询次数
@property (nonatomic) int searchCount;

@end

@implementation PayResultViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"结果" itemColor:BLACKCOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [ToolsObject disableTheSideslip:self];
    
    [self requestTrading:_scanString];
}

- (void)createView{
    _searchBtn.layer.cornerRadius = 2;
    _searchBtn.layer.masksToBounds = YES;
    
    _cancelBtn.layer.cornerRadius = 2;
    _cancelBtn.layer.masksToBounds = YES;
    
    [ToolsObject SVProgressHUDShowStatus_waring:@"订单查询中" WithMask:NO];
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)buttonCilck:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 1) {
        //立即查询
        [self showDrawView];
        
    }else{
        //取消
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)showDrawView {
    [_signatureView removeFromSuperview];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _signatureView = [[[NSBundle mainBundle] loadNibNamed:@"SignatureView" owner:self options:nil] lastObject];
    [_signatureView setFrame:app.window.bounds];
    _signatureView.processTag = _processTag;
    _signatureView.scanString = _scanString;
    _signatureView.moneyString = _moneyString;
    _signatureView.detailDict = _resultDict;
    _signatureView.rootVC = self;
    [_signatureView createView];
    [app.window addSubview:_signatureView];
}





- (void)requestTrading:(NSString *)scanSyring{
    
    LocationObject *locationOj = [[LocationObject alloc] init];
    [locationOj locationView:self];
    locationOj.locationMessageBlock = ^(NSArray *array) {
        NSLog(@"%@",array);
        
        NSString *paytypeString;
        //传值，判断微信还是支付宝,0=支付宝,1=微信
        if (_payWayTag == 0) {
            paytypeString = @"aliPay";
            
        }else{
            paytypeString = @"wxPay";
        }
        
        
        [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
        typeof(self) wSelf = self;
        
        NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%@",[SHOP_DETAIL objectForKey:@"SN_NO"]],@"snNo",
                                    [NSString stringWithFormat:@"%@",@"3303"],@"snTypNo",
                                    [NSString stringWithFormat:@"%@",[SHOP_DETAIL objectForKey:@"AGT_MERC_ID"]],@"mercId",
                                    [NSString stringWithFormat:@"%@",@"031"],@"posEntryModeCode",
                                    [NSString stringWithFormat:@"%@",wSelf.moneyString],@"amount",
                                    [NSString stringWithFormat:@"%@",scanSyring],@"scanAuthCode",
                                    [NSString stringWithFormat:@"%@",paytypeString],@"transType",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:2]],@"provNm",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:3]],@"cityNm",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:4]],@"areaNm",
                                    
                                    nil];
        
        [YanNetworkOBJ postWithURLString:apptrans_trans parameters:parametDic success:^(id  _Nonnull responseObject) {
            [ToolsObject SVProgressHUDDismiss];
            if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
                //
                /**
                 "rspMap" : {
                 "data" : {
                 "scanAuthCode" :"",
                 "retrievalReferenceNumber" : "926000004524",
                 "softVersion" :"",
                 "detailInqrng" :"",
                 "amount" : "000000000001",
                 "updateFlag" :"",
                 "sourceTranDate" :"",
                 "posConditionCode" : "00",
                 "tranDate" :"",
                 "mac" : "AF2EDA6A",
                 "additionalResponseData" : "0000       0000       ",
                 "track2" :"",
                 "tdKey" :"",
                 "authorizationCode" : "000000",
                 "msgTypeCode" : "26",
                 "noUse40" :"",
                 "switchingData" :"",
                 "cardAcceptorTerminalId" : "00000005",
                 "netMngInfoCode" :"",
                 "platFormCode" :"",
                 "ICSystemRelated" :"",
                 "conversionRateSettlement" :"",
                 "noUse46" : "042|06N20190926000004524",
                 "cardAcceptorId" : "84310008651000A",
                 "icpbocDate" :"",
                 "finaclNetData" :"",
                 "processCode" : "660000",
                 "timeLocalTransaction" : "143435",
                 "terminalReadAbility" :"",
                 "posPinCaptureCode" :"",
                 "pin" :"",
                 "billNo" :"",
                 "icsystemRelated" :"",
                 "noUse607" :"",
                 "panExtendCountryCode" :"",
                 "amountCardholderBilling" :"",
                 "additionalAmount" :"",
                 "operator" : "CUP",
                 "securityControlInfo" :"",
                 "pan" :"",
                 "cardSequenceNumber" :"",
                 "currencyCodeSettle" :"",
                 "noUse6010" :"",
                 "track3" :"",
                 "mti" : "0210",
                 "transmissionDateAndTime" :"",
                 "responseCode" : "00",
                 "dateExpiration" :"",
                 "amountSettlement" :"",
                 "systemsTraceAuditNumber" : "001504",
                 "cardholderAuthInfo" :"",
                 "settlementProcessFee" :"",
                 "noUse30" :"",
                 "dateSettlement" : "0926",
                 "batchNo" : "000001",
                 "transType" :"",
                 "posLogNo" :"",
                 "dateLocalTransaction" : "0926",
                 "aquiringInstitutionCountryCode" :"",
                 "settlementFee" :"",
                 "posEntryModeCode" :"",
                 "noUse608" :"",
                 "orgIso8583Msg" :"",
                 "amountCardholderDocument" :"",
                 "aquiringInstitutionId" : "000001",
                 "merchantType" : "上海市|上海市|徐汇区",
                 "noUse21" :"",
                 "sourceBatchNo" :"",
                 "paramVersion" :"",
                 "noUse24" :"",
                 "noUse27" :"",
                 "icConditionCode" :"",
                 "dateConversion" :"",
                 "track1" :"",
                 "noUse56" : "成功",
                 "additionalData48" :"",
                 "dateCapture" :"",
                 "cardAcceptorName" : "个体户严华强                            ",
                 "sourcePosRequestId" :"",
                 "sourceAuthorizationCode" :"",
                 "noUse47" :"",
                 "panExtend" :"",
                 "forwardInstitutionId" :"",
                 "currencyCodeCardholder" :"",
                 "makeMacContent" :"",
                 "conversionRateCardholderBilling" :"",
                 "additionalData57" :"",
                 "reserved" :"",
                 "currencyCode" : "156",
                 "noUse606" :"",
                 "noUseTemp" :"",
                 "noUse609" :"",
                 "transactionFee" :""
                 }
                 },
                 **/
                NSString *msgTypeCodeString = [NSString stringWithFormat:@"%@",[[[responseObject objectForKey:@"rspMap"] objectForKey:@"data"] objectForKey:@"responseCode"]];
                
                if ([msgTypeCodeString isEqualToString:@"00"]) { //成功
                    wSelf.resultDict = [[responseObject objectForKey:@"rspMap"] objectForKey:@"data"];
                    [self showDrawView];
                    
                    return ;
                    
                }if ([msgTypeCodeString isEqualToString:@"P0"]) {//查询5次
                    [self requestSearch:[[responseObject objectForKey:@"rspMap"] objectForKey:@"data"]];
                    return ;
                    
                }else{//错误
                    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
                    confirmSignVC.payType = PAY_FIELD;
                    confirmSignVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:confirmSignVC animated:YES];
                    return ;
                }
                
            }else{
                //filed
                [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
            }
            
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"test filed ");
            [ToolsObject SVProgressHUDDismiss];
        }];
        
    };
}

- (void)requestSearch:(NSDictionary *)detailDict{
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",[SHOP_DETAIL objectForKey:@"SN_NO"]],@"snNo",
                                [NSString stringWithFormat:@"%@",@"3303"],@"snTypNo",
                                [NSString stringWithFormat:@"%@",[SHOP_DETAIL objectForKey:@"AGT_MERC_ID"]],@"mercId",
                                [NSString stringWithFormat:@"%@",@"scanpayQuery"],@"transType",
                                [NSString stringWithFormat:@"%@",[detailDict objectForKey:@"sourceTranDate"]],@"sourcetransDate",
                                [NSString stringWithFormat:@"%@",[detailDict objectForKey:@"sourcePosRequestId"]],@"sourcePosRequestId",
                                [NSString stringWithFormat:@"%@",[detailDict objectForKey:@"sourceBatchNo"]],@"sourceBatchNo",
                                
                                nil];
    
    [YanNetworkOBJ postWithURLString:apptrans_trans parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            //
            
            /**
             
             **/
            NSString *msgTypeCodeString = [NSString stringWithFormat:@"%@",[[[responseObject objectForKey:@"rspMap"] objectForKey:@"data"] objectForKey:@"responseCode"]];
            
            if ([msgTypeCodeString isEqualToString:@"00"]) { //成功
                wSelf.resultDict = [[responseObject objectForKey:@"rspMap"] objectForKey:@"data"];
                [self showDrawView];
                
                return ;
                
            }if ([msgTypeCodeString isEqualToString:@"P0"]) {//查询5次
                if (wSelf.searchCount >= 4 ) {
                    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
                    confirmSignVC.payType = PAY_UNKONW;
                    confirmSignVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:confirmSignVC animated:YES];
                    
                    return ;
                }
                wSelf.searchCount ++;
                [self requestSearch:detailDict];
                
                return ;
                
            }else{//错误
                ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
                confirmSignVC.payType = PAY_FIELD;
                confirmSignVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:confirmSignVC animated:YES];
                
                return ;
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

