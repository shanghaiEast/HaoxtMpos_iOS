//
//  BlueToothSearchToolsTableViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "BlueToothSearchToolsTableViewController.h"

#import "BlueToothSearchToolsTableViewCell.h"
#import "BlueToothSearchToolsHeaderView.h"

#import "BindToolsViewController.h"
#import "ConfirmSignViewController.h"

#import "TianYuView.h"
#import <CoreBluetooth/CBPeripheral.h>

#import "LocationObject.h"


@interface BlueToothSearchToolsTableViewController ()

@property (retain, nonatomic) BlueToothSearchToolsHeaderView *headerView;

@property (retain, nonatomic) NSMutableArray *blueArr;
@property (retain, nonatomic) TianYuView *tianYuView;
@property (retain, nonatomic) NSString *snTypNoString;


@end

@implementation BlueToothSearchToolsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
     [_tianYuView stopBlueLink];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTable];
    [self createBooth];
}

- (void)createTable {
    
    [self.tableView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kBottomSafeHeight-kNavBarHAbove7)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _blueArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 290;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 85;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"BlueToothSearchToolsHeaderView" owner:self options:nil] lastObject];
    [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 290)];
    
    [ToolsObject playGIFWithNameL:@"searchTools" playTime:3 showImageView:_headerView.imageView];
    
    return _headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"BlueToothSearchToolsTableViewCell";
    BlueToothSearchToolsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.rootVC = self;
    
    [cell createCellView];
    
    
    
    CBPeripheral *myDevice = [self.blueArr objectAtIndex:indexPath.row];
    cell.toolsNameLabel.text = myDevice.name;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    typeof(self)wSelf = self;
    
     CBPeripheral *myDevice = [self.blueArr objectAtIndex:indexPath.row];
    [_tianYuView clickedIndexDict:myDevice];
    _tianYuView.getMessageBlock = ^(CBPeripheral * _Nonnull myDevice, NSString * _Nonnull snString, NSDictionary * _Nonnull ksnDic) {
        
        NSLog(@"myDevice:%@",myDevice);
        NSLog(@"snString:%@",snString);
        NSLog(@"snString:%@",ksnDic);
        
        
        NSDictionary *tempDict = @{@"sn":snString, @"name":myDevice.name, @"typeNo":[ksnDic objectForKey:@"deviceType"]};
        [wSelf request_bindMechine:tempDict];
        

        
        
//        //天谕签到
//        NSString *switchingDataString = [NSString stringWithFormat:@"5F0ABB2A997D288997E1D334ACA634E2943DAB466C513485CEF84426782337E47A57E210E42E483219D2ABE481756B4A63EBBFECD5E94792F4F68781"];
//        NSLog(@"%ld",switchingDataString.length);
//        NSString *keyString = [switchingDataString substringWithRange:NSMakeRange(80, 40)];
//        NSString *pinString = [switchingDataString substringWithRange:NSMakeRange(0, 40)];
//        NSString *makString = [switchingDataString substringWithRange:NSMakeRange(40, 40)];
//
//        [wSelf.tianYuView updateWorkingKey:keyString PIK:pinString MAK:makString];
        
        
        
        
        
        //废弃页面
//        BindToolsViewController *bindToolsVC = [[BindToolsViewController alloc] initWithNibName:@"BindToolsViewController" bundle:nil];
//        bindToolsVC.mySNString = [NSString stringWithFormat:@"%@",snString];
//        bindToolsVC.hidesBottomBarWhenPushed = YES;
//        [wSelf.navigationController pushViewController:bindToolsVC animated:YES];

    };
    
    
    
/*
    
//    BindToolsViewController *bindToolsVC = [[BindToolsViewController alloc] initWithNibName:@"BindToolsViewController" bundle:nil];
//    bindToolsVC.hidesBottomBarWhenPushed = YES;
//    bindToolsVC.SNString = sn;
//    [self.navigationController pushViewController:bindToolsVC animated:YES];
//
//
//    
//    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
//    confirmSignVC.payType = TYPE_TOOLS;
//    confirmSignVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:confirmSignVC animated:YES];
 
 */
    
}

- (void)request_bindMechine:(NSDictionary *)dict{
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    
    
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",[dict objectForKey:@"sn"]],@"USR_SN_NO",
                                [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]],@"BLUE_TOOTH",
                                nil];
    
    [YanNetworkOBJ postWithURLString:term_add parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            /**
            "rspMap" : {
                "POS" : {
                    "snNo" : "F300000005",
                    "buyType" : "400",
                    "agtSessionEntity" :"",
                    "outStockDt" :"",
                    "fristStockTyp" : "1",
                    "outStockNo" :"",
                    "tmSmp" : "20190824114535",
                    "inStockNo" : "S41100422231359",
                    "inStockDt" : "20190824114535"
                }
            },
             **/
            
////            model修改参数
//            NSLog(@"%@",[myData USR_TERM_STS]);
//            NSMutableDictionary *tempDict = [USER_DATA mutableCopy];
//            [tempDict setObject:@"1" forKey:@"USR_TERM_STS"];
//            [ToolsObject savaUserData:tempDict];
//            [LoginJsonModel infoWithDictionary:USER_DATA];
//            NSLog(@"%@",[myData USR_TERM_STS]);

            
            
            
            
            [wSelf request_bindMain_1:dict];
            
//            ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
//            confirmSignVC.payType = TYPE_TOOLS;
//            confirmSignVC.hidesBottomBarWhenPushed = YES;
//            [wSelf.navigationController pushViewController:confirmSignVC animated:YES];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

- (void)request_bindMain_1:(NSDictionary *)dict{
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    
//transType: 'downloadMasterKey',
//snNo: this.snNo,
//snTypNo: this.snTypNo,
//mercId: this.props.login.userNo,
    
    
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",@"downloadMasterKey"],@"transType",
                                [NSString stringWithFormat:@"%@",[dict objectForKey:@"sn"]],@"snNo",
                                [NSString stringWithFormat:@"%@",[dict objectForKey:@"typeNo"]],@"snTypNo",
                                [NSString stringWithFormat:@"%@",[myData USR_NO]],@"mercId",
                                nil];
    
    [YanNetworkOBJ postWithURLString:apptrans_trans parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//
            
            /**
             "rspMap" : {
             "data" : {
             "scanAuthCode" :"",
             "retrievalReferenceNumber" : "000000000001",
             "softVersion" :"",
             "detailInqrng" :"",
             "amount" :"",
             "updateFlag" :"",
             "sourceTranDate" :"",
             "posConditionCode" :"",
             "tranDate" :"",
             "mac" :"",
             "additionalResponseData" :"",
             "track2" :"",
             "tdKey" :"",
             "authorizationCode" :"",
             "msgTypeCode" : "00",
             "noUse40" :"",
             "switchingData" : "E8A99C3E01E32A88B724D192F80AEA195390E2BB",
             "cardAcceptorTerminalId" : "00000005",
             "netMngInfoCode" : "410",
             "platFormCode" :"",
             "ICSystemRelated" :"",
             "conversionRateSettlement" :"",
             "noUse46" : "040203050AF3000000050808V1.1.9  ",
             "cardAcceptorId" : "84310008651000A",
             "icpbocDate" :"",
             "finaclNetData" :"",
             "processCode" :"",
             "timeLocalTransaction" : "095323",
             "terminalReadAbility" :"",
             "posPinCaptureCode" :"",
             "pin" :"",
             "billNo" :"",
             "icsystemRelated" :"",
             "noUse607" :"",
             "panExtendCountryCode" :"",
             "amountCardholderBilling" :"",
             "additionalAmount" :"",
             "operator" :"",
             "securityControlInfo" :"",
             "pan" :"",
             "cardSequenceNumber" :"",
             "currencyCodeSettle" :"",
             "noUse6010" :"",
             "track3" :"",
             "mti" : "0810",
             "transmissionDateAndTime" :"",
             "responseCode" : "00",
             "dateExpiration" :"",
             "amountSettlement" :"",
             "systemsTraceAuditNumber" :"",
             "cardholderAuthInfo" :"",
             "settlementProcessFee" :"",
             "noUse30" :"",
             "dateSettlement" :"",
             "batchNo" : "000009",
             "transType" :"",
             "posLogNo" :"",
             "dateLocalTransaction" : "0926",
             "aquiringInstitutionCountryCode" :"",
             "settlementFee" :"",
             "posEntryModeCode" :"",
             "noUse608" :"",
             "orgIso8583Msg" :"",
             "amountCardholderDocument" :"",
             "aquiringInstitutionId" :"",
             "merchantType" :"",
             "noUse21" :"",
             "sourceBatchNo" :"",
             "paramVersion" :"",
             "noUse24" :"",
             "noUse27" :"",
             "icConditionCode" :"",
             "dateConversion" :"",
             "track1" :"",
             "noUse56" : "00",
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
             "currencyCode" :"",
             "noUse606" :"",
             "noUseTemp" :"",
             "noUse609" :"",
             "transactionFee" :""
             }
             },
             **/
            NSString *msgTypeCodeString = [NSString stringWithFormat:@"%@",[[[responseObject objectForKey:@"rspMap"] objectForKey:@"data"] objectForKey:@"msgTypeCode"]];
            
            if ([msgTypeCodeString isEqualToString:@"00"]) {
                [self request_bindMain_2:dict];
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

- (void)request_bindMain_2:(NSDictionary *)dict{
    
    typeof(self) wSelf = self;
    
    LocationObject *locationOj = [[LocationObject alloc] init];
    [locationOj locationView:self];
    locationOj.locationMessageBlock = ^(NSArray *array) {
        NSLog(@"%@",array);
        
        [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
        
        NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%@",@"signIn"],@"transType",
                                    [NSString stringWithFormat:@"%@",[dict objectForKey:@"sn"]],@"snNo",
                                    [NSString stringWithFormat:@"%@",[dict objectForKey:@"typeNo"]],@"snTypNo",
                                    [NSString stringWithFormat:@"%@",[myData USR_NO]],@"mercId",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:1]],@"longitude",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:0]],@"latitude",
                                    [NSString stringWithFormat:@"%@",@"V1.1.9 "],@"version",
                                    nil];
        
        [YanNetworkOBJ postWithURLString:apptrans_trans parameters:parametDic success:^(id  _Nonnull responseObject) {
            [ToolsObject SVProgressHUDDismiss];
            if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
                
                
            /**
             "rspMap" : {
             "data" : {
             "scanAuthCode" :"",
             "retrievalReferenceNumber" : "260000005358",
             "softVersion" :"",
             "detailInqrng" :"",
             "amount" :"",
             "updateFlag" :"",
             "sourceTranDate" :"",
             "posConditionCode" :"",
             "tranDate" :"",
             "mac" :"",
             "additionalResponseData" :"",
             "track2" :"",
             "tdKey" :"",
             "authorizationCode" :"",
             "msgTypeCode" : "00",
             "noUse40" :"",
             "switchingData" : "83DC97FD65A680ABF4EB40BCC9E4EAFABB3419A6ECD6D4F7FAF6D08A52E0750416C9D6FA033932353E2C8F67F11F1AC86B3CE03AADDA8A7CBCECD454",
             "cardAcceptorTerminalId" : "00000005",
             "netMngInfoCode" : "004",
             "platFormCode" :"",
             "ICSystemRelated" :"",
             "conversionRateSettlement" :"",
             "noUse46" : "010A121.401772020A+31.171019040203050AF3000000050807V1.1.9 ",
             "cardAcceptorId" : "84310008651000A",
             "icpbocDate" :"",
             "finaclNetData" :"",
             "processCode" :"",
             "timeLocalTransaction" : "110155",
             "terminalReadAbility" :"",
             "posPinCaptureCode" :"",
             "pin" :"",
             "billNo" :"",
             "icsystemRelated" :"",
             "noUse607" :"",
             "panExtendCountryCode" :"",
             "amountCardholderBilling" :"",
             "additionalAmount" :"",
             "operator" :"",
             "securityControlInfo" :"",
             "pan" :"",
             
             "cardSequenceNumber" :"",
             "currencyCodeSettle" :"",
             "noUse6010" :"",
             "track3" :"",
             "mti" : "0810",
             "transmissionDateAndTime" :"",
             "responseCode" : "00",
             "dateExpiration" :"",
             "amountSettlement" :"",
             "systemsTraceAuditNumber" : "004343",
             "cardholderAuthInfo" :"",
             "settlementProcessFee" :"",
             "noUse30" :"",
             "dateSettlement" :"",
             "batchNo" : "000009",
             "transType" :"",
             "posLogNo" :"",
             "dateLocalTransaction" : "0926",
             "aquiringInstitutionCountryCode" :"",
             "settlementFee" :"",
             "posEntryModeCode" :"",
             "noUse608" :"",
             "orgIso8583Msg" :"",
             "amountCardholderDocument" :"",
             "aquiringInstitutionId" : "10000001",
             "merchantType" :"",
             "noUse21" :"",
             "sourceBatchNo" :"",
             "paramVersion" :"",
             "noUse24" :"",
             "noUse27" :"",
             "icConditionCode" :"",
             "dateConversion" :"",
             "track1" :"",
             "noUse56" : "00",
             "additionalData48" :"",
             "dateCapture" :"",
             "cardAcceptorName" :"",
             "sourcePosRequestId" :"",
             "sourceAuthorizationCode" :"",
             "noUse47" :"",
             "panExtend" :"",
             "forwardInstitutionId" :"",
             "currencyCodeCardholder" :"",
             "makeMacContent" :"",
             "conversionRateCardholderBilling" :"",
             "additionalData57" : "FF010FF0200000000FF03一个月49元|49|三个月99元|99|五个月119元|119",
             "reserved" :"",
             "currencyCode" :"",
             "noUse606" :"",
             "noUseTemp" :"",
             "noUse609" :"",
             "transactionFee" :""
             }
             },
             **/
                //天谕签到
                NSString *switchingDataString = [NSString stringWithFormat:@"%@",[[[responseObject objectForKey:@"rspMap"] objectForKey:@"data"] objectForKey:@"switchingData"]];
                NSLog(@"%ld",switchingDataString.length);
                NSString *keyString = [switchingDataString substringWithRange:NSMakeRange(80, 40)];
                NSString *pinString = [switchingDataString substringWithRange:NSMakeRange(0, 40)];
                NSString *makString = [switchingDataString substringWithRange:NSMakeRange(40, 40)];
                
                [wSelf.tianYuView updateWorkingKey:keyString PIK:pinString MAK:makString];
                //更新成功回调
                wSelf.tianYuView.updateWorkingKeySuccessBlock = ^(BOOL success) {
                    
                    [self.tianYuView stopBlueLink];
                    
                    //            model修改参数
                    NSLog(@"%@",[myData USR_TERM_STS]);
                    NSMutableDictionary *tempDict = [USER_DATA mutableCopy];
                    [tempDict setObject:@"1" forKey:@"USR_TERM_STS"];
                    [ToolsObject savaUserData:tempDict];
                    [LoginJsonModel infoWithDictionary:USER_DATA];
                    NSLog(@"%@",[myData USR_TERM_STS]);
                    
                    
                    
                    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
                    confirmSignVC.payType = TYPE_TOOLS;
                    confirmSignVC.hidesBottomBarWhenPushed = YES;
                    [wSelf.navigationController pushViewController:confirmSignVC animated:YES];
                };
                
                
                
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









///.........................天谕pos。。。。。。。。。。。。。。。。。。。
- (void)createBooth{
    if (_tianYuView == nil) {
        _blueArr = [[NSMutableArray alloc] init];
        
        _tianYuView = [[TianYuView alloc] init];
        [self.view addSubview:_tianYuView];
        [_tianYuView startTianYu];
    }else{
         [_tianYuView startTianYu];
    }
    typeof(self)wSelf = self;
    
    _tianYuView.connectedSearchBlock = ^(NSArray * _Nonnull array) {
        wSelf.blueArr = [array mutableCopy];
        [wSelf.tableView reloadData];
    };
    
}


@end
