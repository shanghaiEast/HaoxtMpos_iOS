//
//  POSCollectionViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "POSCollectionViewController.h"

#import "SignOrderViewController.h"


#import "TianYuView.h"
#import <CoreBluetooth/CBPeripheral.h>


#import "LocationObject.h"



@interface POSCollectionViewController ()


@property (retain, nonatomic) NSString *deviceName;


@property (retain, nonatomic) NSMutableArray *blueArr;
@property (retain, nonatomic) NSDictionary *tradDict, *ksnDict, *orderBackDict, *deviceIdentifyInfoDict;
@property (retain, nonatomic) TianYuView *tianYuView;

@end

@implementation POSCollectionViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"机具申领" itemColor:BLACKCOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [_stateBGImageView stopAnimating];
    
    [_tianYuView stopBlueLink];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _moneyString = @"0.01";
    
    [ToolsObject disableTheSideslip:self];
    
    _deviceName = [SHOP_DETAIL objectForKey:@"BLUE_TOOTH"];
    
    [self createView];
    [self createBooth];
    
    
}

- (void)createView {
    //    [_stateBGImageView setImage:[UIImage imageNamed:@"searchTools.png"]];
    _stateLabel.text = @"请连接刷卡器";
    
    [ToolsObject playGIFWithNameL:@"searchTools" playTime:3 showImageView:_stateBGImageView];
    
#pragma mark 临时交易
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTrading)];
    _toolsNameLabel.userInteractionEnabled = YES;
    [_toolsNameLabel addGestureRecognizer:TapGesture];
    
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        SignOrderViewController *signVC = [[SignOrderViewController alloc] initWithNibName:@"SignOrderViewController" bundle:nil];
    //        signVC.hidesBottomBarWhenPushed = YES;
    //        signVC.processTag = _processTag;
    //        [self.navigationController pushViewController:signVC animated:YES];
    //    });
    
}

- (void)startTrading{
    [_tianYuView startTrading:_moneyString];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


///.........................天谕pos。。。。。。。。。。。。。。。。。。。
- (void)createBooth{
    if (_tianYuView == nil) {
        _blueArr = [[NSMutableArray alloc] init];
        
        _tianYuView = [[TianYuView alloc] init];
        [self.view addSubview:_tianYuView];
        [_tianYuView startTianYu];
    }
    typeof(self)wSelf = self;
    
    _tianYuView.connectedSearchBlock = ^(NSArray * _Nonnull array) {
        wSelf.blueArr = [array mutableCopy];
        for (int i = 0; i < wSelf.blueArr.count; i++) {
            CBPeripheral *device = [wSelf.blueArr objectAtIndex:i];
            if ([device.name isEqualToString:wSelf.deviceName]) {
                //有绑定的pos机
                [wSelf.tianYuView stopSearchPOS];
                [wSelf.tianYuView clickedIndexDict:device];
                
                break ;
            }
        }
    };
    _tianYuView.getMessageBlock = ^(CBPeripheral * _Nonnull myDevice, NSString * _Nonnull snString, NSDictionary * _Nonnull ksnDic) {
        
        NSLog(@"myDevice:%@",myDevice);
        NSLog(@"snString:%@",snString);
        NSLog(@"ksnDic:%@",ksnDic);
        
        wSelf.ksnDict = ksnDic;
        /**
         {
         company = 577568616E205469616E797520496E666F726D6174696F6E20496E64757374727920436F2E2C204C7464;
         deviceModel = 54594865737469613731312056332E30;
         deviceType = 3033;
         isOldDevice = 00;
         ksn = 303030303234303339393931383130313030303030323036;
         }
         **/
        
        
        [wSelf.stateBGImageView stopAnimating];
        [wSelf.stateBGImageView setImage:[UIImage imageNamed:@"toolsCollection.png"]];
        wSelf.stateLabel.text = @"连接成功，请刷卡";
        
        
        [wSelf startTrading];
        
        //        NSDictionary *tempDict = @{@"sn":snString, @"name":myDevice.name, @"typeNo":[ksnDic objectForKey:@"deviceType"]};
        //        [wSelf request_bindMechine:tempDict];
        
    };
    _tianYuView.deviceIdentifyInfoBlock = ^(NSDictionary * _Nonnull infoDict) {
        //返回设备唯一标识认证等相关信息
        
        wSelf.deviceIdentifyInfoDict = infoDict;
        
        NSLog(@"返回设备唯一认证 : %@",wSelf.deviceIdentifyInfoDict);
    
        /**
         {
         cipher = 3031453038464543;
         factor = 313536393833;
         ksn = 303030303234303339393931383130313030303030323036;
         sappVer = 56332E3020202020;
         }
         **/
        
        
        
        /**
         
         **/
    };
    _tianYuView.tradSuccessBlock = ^(NSDictionary * _Nonnull successDict) {
        //交易成功
        wSelf.tradDict = successDict;
        
        NSLog(@"交易成功:%@",wSelf.tradDict);
        
        /**
         {
         cardNumber = 6200850608156983;
         cardType = 0;
         demote = 0;
         encTrack2Ex = A416DADD492658BB184D4D5367D97D8637A305A152A896C7;
         errorCode = 9000;
         expiryDate = 4912;
         isNoPinAndNoSign = 00;
         pin = "";
         serviceCode = 120F;
         swipeMode = 00;
         }
         **/
        
    };
    _tianYuView.tradOrderBackBlock = ^(NSDictionary * _Nonnull orderDict) {
        //读批次号、流水号结果
        wSelf.orderBackDict = orderDict;
        
        NSLog(@"读批次号、流水号结果:%@",wSelf.orderBackDict);
        /**
         {
         batchID = FFFFFF;//批次号
         serialID = FFFFFF;//流水号
         }
         **/
        [wSelf requestCommit];
        
    };
    _tianYuView.disConnectedDeviceBlock = ^(BOOL success) {
        //已断开连接
        [wSelf.tianYuView startTianYu];
        
        wSelf.stateLabel.text = @"请连接刷卡器";
        [ToolsObject playGIFWithNameL:@"searchTools" playTime:3 showImageView:wSelf.stateBGImageView];
    };
    
}

- (void)requestCommit {
    
    typeof(self) wSelf = self;
    
    LocationObject *locationOj = [[LocationObject alloc] init];
    [locationOj locationView:self];
    locationOj.locationMessageBlock = ^(NSArray *array) {
        NSLog(@"%@",array);
        
        NSString *transTypeString = @"purchase";
        NSString *actPayTypeString = @"1";
        if (wSelf.processTag == 0 || wSelf.processTag == 1) {
//            transTypeString = @"deposit";
            actPayTypeString = @"0";
        }
        
        NSString *isFreePwString = @"0";
        if ([[wSelf.tradDict objectForKey:@"pin"] length] == 0) {
            isFreePwString = @"1";
        }
        
        NSString *swipeModeString =  [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"swipeMode"]];
        if ([swipeModeString isEqualToString:@"00"]) {
            swipeModeString = @"1";
        }else if ([swipeModeString isEqualToString:@"01"]) {
            swipeModeString = @"2";
        }else if ([swipeModeString isEqualToString:@"02"]) {
            swipeModeString = @"3";
        }
        
        [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
        
        NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%@",transTypeString],@"transType", // 交易类型purchase   快提 deposit
                                    [NSString stringWithFormat:@"%@",[SHOP_DETAIL objectForKey:@"SN_NO"]],@"snNo", // SN号码
                                    [NSString stringWithFormat:@"%@",[wSelf.ksnDict objectForKey:@"deviceType"]],@"snTypNo",// 终端类型
                                    [NSString stringWithFormat:@"%@",[SHOP_DETAIL objectForKey:@"AGT_MERC_ID"]],@"mercId",
                                    [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"cardNumber"]],@"pan",// 卡号
                                    [NSString stringWithFormat:@"%@",wSelf.moneyString],@"amount",// 金额
                                    [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"expiryDate"]],@"dateExpiration",// 信用卡有效期YYMM
                                    [NSString stringWithFormat:@"%@",swipeModeString],@"posEntryModeCode",// 服务点输入方式码
                                    [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"cardSeqNum"]],@"cardSequenceNumber",// 卡片序列号，当POS能够获得该值时存在
                                    [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"encTrack2Ex"]],@"track2",// 二磁道
                                    [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"encTrack3Ex"]],@"track3",// 三磁道
                                    [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"pin"]],@"pin",// FLD 52 个人标识码数据
                                    [NSString stringWithFormat:@"%@",[wSelf.tradDict objectForKey:@"icData"]],@"ICSystemRelated",// IC卡数据域
                                    [NSString stringWithFormat:@"%@",[wSelf.orderBackDict objectForKey:@"serialID"]],@"systemsTraceAuditNumber",// 流水号
                                    [NSString stringWithFormat:@"%@",@"03"],@"deviceType",// 设备类型 01：ATM 02：传统 POS 03：mPOS  04：智能 POS
                                    [NSString stringWithFormat:@"%@",[wSelf.ksnDict objectForKey:@"ksn"]],@"snSeq",// 终端序列号
                                    [NSString stringWithFormat:@"%@",[wSelf.deviceIdentifyInfoDict objectForKey:@"factor"]],@"randomKey",// 加密随机因子
                                    [NSString stringWithFormat:@"%@",[wSelf.deviceIdentifyInfoDict objectForKey:@"cipher"]],@"hdSeqData",// 硬件序列号密文编码
                                    [NSString stringWithFormat:@"%@",@"V1.1.9 "],@"version",// 应用程序版本号
                                    [NSString stringWithFormat:@"%@",@""],@"snNetWorkNo",// 终端入网认证编号
                                    [NSString stringWithFormat:@"%@",isFreePwString],@"secretFree",//// 是否小额免密  1 是 0 不是 默认0
                                    [NSString stringWithFormat:@"%@",actPayTypeString],@"actPayType",//// 缴费类型 0 押金激活 1 购买流量优惠包 （交易0 快提1）
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:1]],@"longitude",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:0]],@"latitude",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:2]],@"provNm",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:3]],@"cityNm",
                                    [NSString stringWithFormat:@"%@",[array objectAtIndex:4]],@"areaNm",
                                    
                                    nil];
        
        [YanNetworkOBJ postWithURLString:apptrans_trans parameters:parametDic success:^(id  _Nonnull responseObject) {
            [ToolsObject SVProgressHUDDismiss];
            if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
                //
                
                /**
                 PayResultViewController *resultVC = [[PayResultViewController alloc] initWithNibName:@"PayResultViewController" bundle:nil];
                 resultVC.hidesBottomBarWhenPushed = YES;
                 resultVC.processTag = wSelf.processTag;
                 resultVC.payWayTag = 2;
                 resultVC.scanString = scanString;
                 resultVC.moneyString = wSelf.moneyString;
                 [wSelf.rootVC.navigationController pushViewController:resultVC animated:YES];
                 **/
                
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

@end

