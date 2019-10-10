//
//  TianYuView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/11.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TianYuView.h"

#import "TYCommonLib.h"


@interface TianYuView ()<TYSwiperControllerDelegate>

@property (retain, nonatomic) CBPeripheral *myDevice;
@property (retain, nonatomic) NSDictionary *ksnDict;
@property (retain, nonatomic) NSString *snString;
#if TARGET_IPHONE_SIMULATOR

#else
@property (assign, nonatomic) TYSwiperController *tySwiper;

#endif

@property (retain, nonatomic) NSMutableArray *blueArr;
@property (retain, nonatomic) UIAlertController* scanController;

@end



@implementation TianYuView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)stopBlueLink {
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    [_tySwiper disconnectDevice];
    
#endif
}

- (void)stopSearchPOS {
#if TARGET_IPHONE_SIMULATOR
    
#else
    [_tySwiper stopScanDevice];
    
#endif
    
}

- (void)clickedIndexDict:(CBPeripheral *)myDevice {
#if TARGET_IPHONE_SIMULATOR
    
#else
    //stop search
    [_tySwiper stopScanDevice];
    
    //disconnect
    [_tySwiper disconnectDevice];
    
    //connect
    _myDevice = myDevice;
    [_tySwiper connectDevice:_myDevice.name];
    
#endif
    
}

//  更新工作密钥(磁道密钥、密码密钥、mac 密钥三组密钥)
- (void)updateWorkingKey:(NSString *)TDK PIK:(NSString *)PIK MAK:(NSString *)MAK{
#if TARGET_IPHONE_SIMULATOR
    
#else
    [_tySwiper updateWorkingKey:TDK PIK:PIK MAK:MAK];
#endif
    
}

//开始交易
- (void)startTrading:(NSString *)moneyStr {
#if TARGET_IPHONE_SIMULATOR
    
#else
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    
    moneyStr = [NSString stringWithFormat:@"%.0f",[moneyStr floatValue]*100];
    
    [_tySwiper setLimitAmount:@"10000"];
    [_tySwiper readCard:moneyStr TerminalTime:dateString TradeType:0x00 timeout:20 Demote:nil inputPin:YES];
    
#endif
    
}


///.........................天谕pos。。。。。。。。。。。。。。。。。。。
- (void)startTianYu{
#if TARGET_IPHONE_SIMULATOR
    
#else
    _blueArr = [[NSMutableArray alloc]init];
    
    _tySwiper = [TYSwiperController shareInstance];
    _tySwiper.delegate = self;
    
    [_tySwiper setTYLogTag:TYLogDebug];
    
    [_tySwiper initdevice:TY_BLUETOOTH_DEVICE];
    
#endif
    
}
/**
 返回扫描到的蓝牙设备
 存储的是扫描到的蓝牙对象
 */

- (void)onDiscoverDevice:(CBPeripheral *)device {
#if TARGET_IPHONE_SIMULATOR
    
#else
    NSLog(@"device:%@",device);
    [self.blueArr addObject:device];
    
    NSLog(@"blueArr:%@",_blueArr);
    
    if (_connectedSearchBlock) {
        _connectedSearchBlock(_blueArr);
    }
    
    if (_blueArr) {
        if (iOS8) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:device.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [_tySwiper connectDevice:device.name];
            }];
            if (![_scanController.actions containsObject:action]) {
                [_scanController addAction:action];
            }
        }else {
            //            [scanAlert.table reloadData];
        }
    }
    
#endif
    
}

/**
 设备已连接
 布尔值 YES表示已连接
 */
- (void)onConnectedDevice:(BOOL)isSuccess {
#if TARGET_IPHONE_SIMULATOR
    
#else
    NSLog(@"isSuccess:%d",isSuccess);
    
    if (isSuccess == YES) {
        [ToolsObject showMessageTitle:@"连接成功" andDelay:1 andImage:nil];
        [_tySwiper getDeviceSN];
        [_tySwiper getDeviceCSN];
        [_tySwiper getPosInfo];
        
        //        [_tySwiper recei];
        
        
        
    }else{
        [ToolsObject showMessageTitle:@"连接失败" andDelay:1 andImage:nil];
    }
    
#endif
    
}
/**
 设备是否断开
 布尔值 YES表示已断开
 */
- (void)onDisConnectedDevice:(BOOL)isSuccess {
    
    if (_disConnectedDeviceBlock) {
        _disConnectedDeviceBlock(YES);
    }
    
    [ToolsObject showMessageTitle:@"已断开连接" andDelay:1 andImage:nil];
}

/**
 *  返回设备SN
 *
 *  设备sn
 */
- (void)onReceiveDeviceSN:(NSString *)sn {
    NSLog(@"sn:%@",sn);
    
    //字条串是否包含有某字符串
    if ([sn rangeOfString:@"失败"].location == NSNotFound) {
        NSLog(@"string 不存在 失败");
        
        _snString = sn;
#if TARGET_IPHONE_SIMULATOR
        
#else
        [_tySwiper getDeviceKSNInfo];
#endif
        
        
        
    } else {
        NSLog(@"string 包含 失败");
        [ToolsObject showMessageTitle:@"获取设备SN失败" andDelay:1 andImage:nil];
    }
}
// 获取pos/reader设备信息
- (void)onReceivePosInfo:(NSDictionary *)info{
    NSLog(@"info:%@",info);
}
/**
 *  是否成功更新密钥
 *
 *  @param isSuccess 成功/失败
 */
-(void)onUpdateWorkingKeyResult:(BOOL)TDK result:(BOOL)PIK result:(BOOL)MAK {
    NSLog(@"\n TDK:%d\n PIK:%d\n MAK:%d",TDK,PIK,MAK);
    
    if (TDK == 1 && PIK == 1 && MAK == 1) {
        if (_updateWorkingKeySuccessBlock) {
            _updateWorkingKeySuccessBlock(YES);
        }
    }else{
        [ToolsObject showMessageTitle:@"秘钥更新失败" andDelay:1 andImage:nil];
        return;
    }
    
}

/**
 *  返回设备ID
 *
 *  @param deviceID 设备ID
 */
- (void)onReceiveDeviceCSN:(NSString *)csn {
    NSLog(@"csn:%@",csn);
}
/**
 *  返回银联21号文报备信息
 *  @param ksnDic 银联21号文报备信息
 ksn:KSN明文(终端序列号)
 deviceType:终端类型
 deviceModel：终端产品型号
 company:终端生产企业名称
 isOldDevice: 00表示新设备，01表示老设备
 */
-(void)onReceiveDeviceKSNInfo:(NSDictionary *)ksnDic {
    NSLog(@"ksnDic:%@",ksnDic);
    _ksnDict = ksnDic;
    
    if (_getMessageBlock) {
        _getMessageBlock (_myDevice, _snString, _ksnDict);
    }
}

/**
 *  返回设备唯一标识认证等相关信息
 *  @param IdInfoDic 设备唯一标识认证信息
 ksn:KSN明文(终端序列号)
 factor:加密随机因子明文
 cipher:8字节密文数据
 sappVer:应用程序版本号
 */
- (void)onReceiveDeviceIdentifyInfo:(NSDictionary *)IdInfoDic
{
    NSLog(@"IdInfoDic:%@",IdInfoDic);
    
    /**
     {
     cipher = 3031453038464543;
     factor = 313536393833;
     ksn = 303030303234303339393931383130313030303030323036;
     sappVer = 56332E3020202020;
     }
     **/
    if (IdInfoDic.count == 0) {
        return;
    }
    
    if (_deviceIdentifyInfoBlock) {
        _deviceIdentifyInfoBlock(IdInfoDic);
    }
    
    //后面获取流水号
#if TARGET_IPHONE_SIMULATOR
    
#else
    [_tySwiper readBatchIDAndSerialID];
#endif
}

///**
// *  提示已经获取到卡片信息
// */
//- (void)onReadCardData:(NSDictionary *)cardInfo {
//    NSLog(@"cardInfo:%@",cardInfo);
//    /* 芯片交易数据
//     {
//     cardNumber = 6217560800027564300;
//     cardSeqNum = 01;
//     cardType = 1;
//     cardValidDate = 2906;
//     encTrack2Ex = 556116D07442357C85265A03D490B20A6DEAAD1F58EEF46C;
//     errorCode = 9000;
//     icData = 9F26089C1039A1C959154A9F2701809F1013070B0103A0B002010A0100000000003AC6C8959F3704E86409009F36020006950500000008009A031909119C01009F02060000010000005F2A02015682027C009F1A0201569F03060000000000009F3303E0E1C09F34033F00009F3501229F1E0831323334353637388408A0000003330101019F090200209F410400000004;
//     isApplePay = 00;
//     swipeMode = 01;
//     }
//     */
//
//}

/**
 获取刷卡后返回的数据
 @param  data 卡片数据
 磁条卡:
 cardType:卡类型
 cardNumber:卡号
 expiryDate:有效期
 serviceCode:服务代码
 encTrack2Ex:二磁道信息
 encTrack3Ex:三磁道信息
 pin:密码
 demote:降级交易标志位 @“0”表示没有降级交易，@“1”表示发生了降级交易
 ic 卡:
 cardType:卡类型
 cardSeqNum:卡序号
 cardNumber:卡号
 icData: icData
 encTrack2Ex: 二磁道信息
 pin:密码
 swipeMode: 刷卡方式（@"00":刷卡，@"01":插卡，@"02":挥卡）
 */
- (void)onReadCard:(NSDictionary *)data {
#if TARGET_IPHONE_SIMULATOR
    
#else
    NSLog(@"data:%@",data);
    //swipeMode : 刷卡方式（@"00":刷卡，@"01":插卡，@"02":挥卡）
    if ([[data allKeys] containsObject:@"errorDescription"]) {
        [_tySwiper confirmTransaction:NO andMsg:[data objectForKey:@"errorDescription"]];
        [ToolsObject showMessageTitle:[NSString stringWithFormat:@"%@",[data objectForKey:@"errorDescription"]] andDelay:1 andImage:nil];
        
        if (_tradFailureBlock) {
            _tradFailureBlock(YES);
        }
        
    }else{
        /*
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
         */
        
        if (_tradSuccessBlock) {
            _tradSuccessBlock(data);
        }
        
        // 获取认证信息
#if TARGET_IPHONE_SIMULATOR
        
#else
        [_tySwiper getDeviceIdentifyInfo];
#endif
        
    }
    
#endif
    
}
//交易成功回调
- (void)onConfirmTransaction:(BOOL)isSuccess{
    NSLog(@"isSuccess:%d",isSuccess);
    
}

/**
 读批次号、流水号结果
 @param IDdata
 *  @return batchID  批次号
 *  @return serialID 流水号
 */
- (void)onReadBatchIDSerialID:(NSDictionary *)IDdata {
    NSLog(@"读批次号、流水号结果 : %@",IDdata);
    /**
     {
     batchID = FFFFFF;//批次号
     serialID = FFFFFF;//流水号
     }
     **/
    if (_tradOrderBackBlock) {
        _tradOrderBackBlock(IDdata);
    }
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    //最后一步
    [_tySwiper confirmTransaction:NO andMsg:@"交易完成"];
#endif
    
    
}



@end

