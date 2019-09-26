//
//  TianYuView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/11.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreBluetooth/CBPeripheral.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConnectedSearchBlock)(NSArray *array);//search pos
typedef void(^ConnectedOnBlock)(BOOL connectedBool);//on connected
typedef void(^ConnectedOffBlock)(BOOL connectedBool);//off connected
typedef void(^GetMessageBlock)(CBPeripheral *myDevice , NSString *snString, NSDictionary *ksnDic);//message connected
typedef void(^TradSuccessBlock)(BOOL success);//trad success
typedef void(^DisConnectedDeviceBlock)(BOOL success);//DisConnectedDevice
typedef void(^UpdateWorkingKeySuccessBlock)(BOOL success);//Update Working Key


@interface TianYuView : UIView

@property (copy, nonatomic)  ConnectedSearchBlock connectedSearchBlock;
@property (copy, nonatomic)  ConnectedOnBlock connectedOnBlock;
@property (copy, nonatomic)  ConnectedOffBlock connectedOffBlock;
@property (copy, nonatomic)  GetMessageBlock getMessageBlock;
@property (copy, nonatomic)  TradSuccessBlock tradSuccessBlock;
@property (copy, nonatomic)  DisConnectedDeviceBlock disConnectedDeviceBlock;
@property (copy, nonatomic)  UpdateWorkingKeySuccessBlock updateWorkingKeySuccessBlock;




- (void)startTianYu;
- (void)clickedIndexDict:(CBPeripheral *)dict;
- (void)stopSearchPOS;

//  更新工作密钥(磁道密钥、密码密钥、mac 密钥三组密钥)
- (void)updateWorkingKey:(NSString *)TDK PIK:(NSString *)PIK MAK:(NSString *)MAK;
//开始交易
- (void)startTrading;
//断开蓝牙连接
- (void)stopBlueLink;

@end

NS_ASSUME_NONNULL_END
