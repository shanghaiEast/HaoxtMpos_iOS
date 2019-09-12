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
typedef void(^GetMessageBlock)(CBPeripheral *myDevice , NSString *snString);//message connected
typedef void(^TradSuccessBlock)(BOOL success);//trad success



@interface TianYuView : UIView

@property (copy, nonatomic)  ConnectedSearchBlock connectedSearchBlock;
@property (copy, nonatomic)  ConnectedOnBlock connectedOnBlock;
@property (copy, nonatomic)  ConnectedOffBlock connectedOffBlock;
@property (copy, nonatomic)  GetMessageBlock getMessageBlock;
@property (copy, nonatomic)  TradSuccessBlock tradSuccessBlock;





- (void)startTianYu;
- (void)clickedIndexDict:(CBPeripheral *)dict;
- (void)stopSearchPOS;
- (void)startTrading;//开始交易

@end

NS_ASSUME_NONNULL_END
