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

//开始交易
- (void)startTrading {
#if TARGET_IPHONE_SIMULATOR
    
#else
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
//    [_tySwiper setLimitAmount:@"10000"];
    [_tySwiper readCard:@"1000000" TerminalTime:dateString TradeType:0x00 timeout:10 Demote:nil inputPin:YES];
    
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
    
    NSLog(@"_myDevice:%@",_myDevice);
    
    //字条串是否包含有某字符串
    if ([sn rangeOfString:@"失败"].location == NSNotFound) {
        NSLog(@"string 不存在 失败");
        if (_getMessageBlock) {
            _getMessageBlock (_myDevice, sn);
        }
        
    } else {
        NSLog(@"string 包含 失败");
        [ToolsObject showMessageTitle:@"获取设备SN失败" andDelay:1 andImage:nil];
    }
    
    
}

/**
 *  提示已经获取到卡片信息
 */
- (void)onReadCardData:(NSDictionary *)cardInfo {
    NSLog(@"cardInfo:%@",cardInfo);
    /* 芯片交易数据
     {
     cardNumber = 6217560800027564300;
     cardSeqNum = 01;
     cardType = 1;
     cardValidDate = 2906;
     encTrack2Ex = 556116D07442357C85265A03D490B20A6DEAAD1F58EEF46C;
     errorCode = 9000;
     icData = 9F26089C1039A1C959154A9F2701809F1013070B0103A0B002010A0100000000003AC6C8959F3704E86409009F36020006950500000008009A031909119C01009F02060000010000005F2A02015682027C009F1A0201569F03060000000000009F3303E0E1C09F34033F00009F3501229F1E0831323334353637388408A0000003330101019F090200209F410400000004;
     isApplePay = 00;
     swipeMode = 01;
     }
     */
    
}

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
        [ToolsObject showMessageTitle:[NSString stringWithFormat:@"%@",[data objectForKey:@"errorDescription"]] andDelay:1 andImage:nil];
        
        //        [_tySwiper confirmTransaction:NO andMsg:nil];
        
    }else{
        /*
         {
         cardNumber = 6217560800027564300;
         cardSeqNum = 01;
         cardType = 1;
         cardValidDate = 2906;
         encTrack2Ex = 556116D07442357C85265A03D490B20A6DEAAD1F58EEF46C;
         errorCode = 9000;
         icData = 9F2608572E973BC54B5A0E9F2701809F1013070B0103A0B002010A01000000000077C741A09F370469D70A009F36020007950500000008009A031909119C01009F02060000010000005F2A02015682027C009F1A0201569F03060000000000009F3303E0E1C09F34033F00009F3501229F1E0831323334353637388408A0000003330101019F090200209F410400000005;
         isApplePay = 00;
         isNoPinAndNoSign = 00;
         pin = 874DAABC757C37CA;
         swipeMode = 01;
         }
         */
        
    }
    
    if ([_tySwiper confirmTransaction] == YES) {
        [_tySwiper confirmTransaction:NO andMsg:@"success"];
        [ToolsObject showMessageTitle:[data objectForKey:@"交易完成"] andDelay:1 andImage:nil];
        
        if (_tradSuccessBlock) {
            _tradSuccessBlock(YES);
        }
    }
    
#endif
    
    
}



@end
