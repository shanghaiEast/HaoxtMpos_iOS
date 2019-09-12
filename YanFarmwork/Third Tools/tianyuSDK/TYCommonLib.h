//
//  TYSwiperController.h
//  TYSwiperController
//
//  Created by whty on 15/7/14.
//  Copyright (c) 2015年 whty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SalesSlipModel.h"

typedef NS_ENUM(NSUInteger, DeviceStatusLib) {
    DEVICE_STATUS_NONE_LIB,
    AUDIO_DEVICE_IN_LIB,
    AUDIO_DEVICE_OUT_LIB,
    BLE_POWER_OFF_LIB,
    BLE_DEVICE_SCAN_LIB,
    BLE_DEVICE_CONNECT_LIB,
    BLE_DEVICE_DISCONNECT_LIB,
};

typedef NS_ENUM(NSInteger, ICommunication) {
    TY_AUDIO_DEVICE        =   0,     //音频设备
    TY_BLUETOOTH_DEVICE    =   1,     //蓝牙设备
};

/**
 * @brief 透传通道卡类型
 */
typedef NS_ENUM(NSInteger, TY_ChannelCardType) {
    TY_CARDTYPE_SAM = 1, /**< SAM卡 */
    TY_CARDTYPE_CONTACT = 2, /**< 接触卡 */
    TY_CARDTYPE_NON_CONTACT = 3, /**< 非接卡 */
};

typedef NS_ENUM(NSUInteger, TYLogTag){
    /**
     *  No logs; 不打印log
     */
    TYLogOff       = 0,
    
    /**
     *  Error logs only; 只打印错误类log
     */
    TYLogError     = 1,
    
    /**
     *  Error and debug logs; 打印错误类和调试类log
     */
    TYLogDebug     = 2,
    
    /**
     *  All logs; 最大值
     */
    TYLogAll       = NSUIntegerMax
};

@protocol TYSwiperControllerDelegate;

@interface TYSwiperController : NSObject

/**
 重要:默认采用异步方式,SET后变为同步。
 */
@property (weak, nonatomic) id <TYSwiperControllerDelegate> delegate;

#pragma mark - 通用方法

/**
 设置设置log打印级别
 @param logTag 打印级别
 TYLogOff       = 0,              //No logs; 不打印log
 TYLogError     = 1,              //Error logs only; 只打印错误类log
 TYLogDebug     = 2,              //Error and debug logs; 打印错误类和调试类log
 TYLogAll       = NSUIntegerMax   //All logs; 最大值
 */
- (void)setTYLogTag:(TYLogTag)logTag;


/**
 获取单例
 */
+ (TYSwiperController *)shareInstance;

/**
 音频：配置音频参数，开始监测拔插事件。
 蓝牙：配置蓝牙参数，开始扫描设备，将设备列表返回至回调onDiscoverDevice。
 @param type 类型 
 TY_AUDIO_DEVICE        =   0,     //音频设备
 TY_BLUETOOTH_DEVICE    =   1,     //蓝牙设备
 */
- (void)initdevice:(ICommunication)type;

/**
 连接设备
 @param device(蓝牙为设备名,其他为nil)
 @return BOOL 是否连接成功 回调onConnectedDevice
 */
- (BOOL)connectDevice:(NSString *)device;

/**
 连接设备
 @param peripheral(待连接的蓝牙对象)
 @return BOOL 是否连接成功 回调onConnectedDevice
 */
- (BOOL)connectPeripheral:(CBPeripheral *)peripheral;

/**
 是否已连接设备
 @return NSUInteger 参考枚举DeviceStatusLib
 */
- (NSUInteger)isConnected;

/**
 断开设备
 */
- (void)disconnectDevice;

/**
 停止扫描设备
 */
- (void)stopScanDevice;

/**
 获取 API 版本信息
 @return API 版本信息
 */
- (NSString *)getVersion;

/**
 取消当前操作(比如取消当前等待刷卡或取消等待输密，设备会放弃本次刷卡流程返回主界面)
 @return
 */
- (void)cancel;

#pragma mark - 通信方法

/**
 更新主密钥
 @param mainKey(16/8字节长度的主密钥 + 4字节长度的校验值)
 @return BOOL 回调onUpdateMainKey
 */
- (BOOL)updateMainKey:(NSString *)mainKey;

/** 
 更新工作密钥(磁道密钥、密码密钥、mac 密钥三组密钥)
 @param TDK:磁道工作密钥密文,20 字节(16+4),null 表示不用写入,当密钥 为单倍长 8+4 时,将前八个字节复制一遍拼 成 16,然后+4.
 @param PIK:PIN 工作密钥密文,20 字节,null 表示不用写入,当密钥为单倍长 8+4 时,将前八个字节复制一遍拼成 16,然后+4.
 @param MAK:MAC 工作密钥密文,20 字节,null 表示不用写入,当密钥为单 倍长 8+4 时,将前八个字节复制一遍拼成 16,然后+4.(mac 补 8 字节 0, 然后加 4 位校验码)
 @return 按参数顺序是否成功更新的数组 1表示成功 0表示不成功 回调onUpdateWorkingKey
 */
- (NSArray *)updateWorkingKey:(NSString *)TDK PIK:(NSString *)PIK MAK:(NSString *)MAK;

/**
 获取外部读卡器设备 SN 号
 @return SN号 回调onReceiveDeviceSN
 */
- (NSString *)getDeviceSN;

/**
 获取 psam 卡号/安全芯片卡号(PSAM 卡号)
 @return CSN号 回调onReceiveDeviceCSN
 */
- (NSString *)getDeviceCSN;

#pragma mark ---------------------- 银联21号文接口 --------------------------
/**
 银联21号文报备接口
 @return 银联21号文报备信息 回调onReceiveDeviceKSNInfo
 */
- (NSDictionary *)getDeviceKSNInfo;

/**
 获取设备唯一标识认证信息
 @return 设备唯一标识认证信息字典 回调onReceiveDeviceIdentifyInfo
 */
- (NSDictionary *)getDeviceIdentifyInfo;

/**
 获取21号文117域报文信息
 @return 21号文117域报文信息 回调onReceiveIso8583Feild117
 */
- (NSString *)getIso8583Feild117;

/**
 获取21号文59域报文信息
 @return 21号文59域报文信息 回调onReceiveIso8583Feild59
 */
- (NSString *)getIso8583Feild59;

#pragma mark -----------------------------------------------------------------
/**
 获取pos/reader设备信息

 @return 设备信息字典数据
 *  @"sn":设备sn
 *  @"keyboard":0，无键盘；1，带键盘
 */
- (NSDictionary *)getPosInfo;

/**
 计算 mac
 @param MKIndex:密钥索引,保留,暂未使用
 @param message:用于计算mac的数据
 @return mac值以及随机数 回调onGetMacWithMKIndex
 */
- (NSDictionary *)getMacWithMKIndex:(int)MKIndex Message:(NSString *)message;

/**
 刷卡
 @param  amount 金额 注:传入金额的时候注意不要传小数点,如果想要传 1.50 则写入"150"
 @param  terminalTime 交易时间 例如 2014-12-03 16:20:55 则 terminalTime 传 入"141203162055"，请务必传入交易当前时间，交易时间错误可能造成交易失败
 @param  tradeType 交易类型 (例如:0x00 代表消费,0x31 代表查询余额)
 @param  swipeTimeOut 交易超时时间
 @param  demote 降级操作 0表示支持 1表示不支持 无则传入nil
 @param  isInput 是否输密码 YES表示输密码 NO表示不输
 @return 携带卡片信息的NSDictionary 回调onReadCard
 例如 磁条卡:
 *  errorCode：错误码
 *  cardType：卡类型
 *  cardNumber：卡号
 *  expiryDate：有效期
 *  serviceCode：服务代码
 *  encTrack2Ex：二磁道信息
 *  encTrack3Ex：三磁道信息
 *  pin：密码
 *  pinRandom：密码随机数
 *  demote： 降级交易标志位 @“0”表示没有降级交易，@“1”表示发生了降级交易
 *  swipeMode： 刷卡方式（@"00":刷卡，@"01":插卡，@"02":挥卡）
 *  swipeRandom： 刷卡随机数
 ic 卡:
 *  errorCode：错误码
 *  cardType：卡类型
 *  cardSeqNum：卡序号
 *  cardNumber：卡号
 *  cardValidDate：有效期
 *  swipeMode： 刷卡方式（@"00":刷卡，@"01":插卡，@"02":挥卡）
 *  isApplePay：是否为云闪付（@"01":云闪付，@"00":非云闪付）
 *  swipeRandom： 刷卡随机数
 *  icData： icData
 *  encTrack2Ex： 二磁道信息
 *  pin：密码
 *  pinRandom：密码随机数
 注：errorCode为9000时是正确返回
 */
- (NSDictionary *)readCard:(NSString *)amount
              TerminalTime:(NSString *)terminalTime
                 TradeType:(Byte)tradeType
                   timeout:(int)swipeTimeOut
                    Demote:(NSString*)demote
                  inputPin:(BOOL)isInput;

/**
 增加随机数以及刷卡通道选择参数
 @param  random   随机数         传nil则代表不需要传入随机数
 @param  channel  刷卡通道选择    0x01   只开磁条卡通道
                                0x02   只开IC插卡通道
                                0x03   只开磁条卡和IC插卡通道
                                0x04   只开非接通道
                                0x05   只开磁条卡和非接通道
                                0x06   只开IC插卡和非接通道
                                0x07   磁条卡、IC插卡和非接通道全开
 注：如对这两个参数无要求，请直接使用上面的接口（默认磁条卡、IC插卡和非接通道全开，不传随机数）
 */
- (NSDictionary *)readCard:(NSString *)amount
              TerminalTime:(NSString *)terminalTime
                 TradeType:(Byte)tradeType
                   timeout:(int)swipeTimeOut
                    Demote:(NSString *)demote
                    Random:(NSString *)random
                   Channel:(Byte)channel;

/**
 区分是否打开非接刷卡(老刷卡接口，新项目请选用上面的刷卡接口)
 @param  isOpen 打开非接
 */
- (NSDictionary *)readCard:(NSString *)amount
              TerminalTime:(NSString *)terminalTime
                 TradeType:(Byte)tradeType
                   timeout:(int)swipeTimeOut
                    Demote:(NSString*)demote
                 isOpenICC:(BOOL)isOpen;

/**
 获取卡号
 @param  swipeTimeOut 交易超时时间
 * cardNumber:卡号
 */
- (NSDictionary *)getCardNumber:(int)swipeTimeOut;

/**
 输入密码
 @return 返回设备PINBlock结果，回调onPinBlock:
 */
- (NSDictionary *)getPinblock;

/**
 无键盘蓝牙刷卡头计算PinBlock，并接收设备返回数据
 @param type         PIN Block格式(P1)
                       0 :请求带主账号的PIN Block
                       1 :请求不带主账号的PIN Block
                       2 :自定义 PIN Block格式
 @param random       0~16字节随机数，固件不支持随机数则传nil
 @param pinBlockStr 传入的密码
 @return 返回设备PINBlock结果，回调onPinBlock:Random:
 */
- (NSDictionary *)getEncPinblock:(NSInteger)type
                          Random:(NSString *)random
                      SourceData:(NSString *)pinBlockStr;

/**
 交易结果确认指令
 通知设备本次交易结束，可返回主界面，等待下一次交易
 @return 交易成功返回YES 回调onConfirmTransaction
 */
- (BOOL)confirmTransaction;

/**
 交易结果确认指令
 通知设备本次交易结束，可返回主界面，等待下一次交易
 @param isdefault YES:默认显示  NO:不显示任何内容，回到主界面
 @param msg 确认交易后显示在mpos上的字符串，如传入nil则显示默认字符串
 @return 交易成功返回YES 回调onConfirmTransaction
 */
- (BOOL)confirmTransaction:(BOOL)isdefault andMsg:(NSString *)msg;


/**
 标准接触IC卡交易响应处理
 @param data 14字节长度的数组,“响应码” +“发卡行认证数据”
 @return 成功返回YES 回调onConfirmTransaction
 */
- (BOOL)confirmTradeResponse:(NSData *)data;

/**
 交易响应指令
 @param responseCode 银行的响应码
 @param TLVData      发卡行认证数据
 @return 55域数据
 */
- (NSData *)responseToTransaction:(NSString *)responseCode
                          TLVData:(NSString *)TLVData;


/**
 下载商户号终端号指令（商付通）
 回调  onDownloadBusinessIDTerminalID:
 @param  businessID:商户号  （15字节）
 @param  terminalID:终端号  （8字节）
 */
- (BOOL)downloadBusinessID:(NSString *)businessID
                TerminalID:(NSString *)terminalID;


/**
 *  批次号流水号读接口
 回调  onReadBatchIDSerialID:
 *  @return batchID  批次号
 *  @return serialID 流水号
 */
- (NSDictionary *)readBatchIDAndSerialID;

/**
 *  批次号流水号更新接口
 回调  onUpdateBatchIDSerialID:
 *  @param batchID  批次号
 *  @param serialID 流水号
 */
- (BOOL)updateBatchID:(NSString *)batchID
             SerialID:(NSString *)serialID;

/**
 获取mac地址
 */
- (NSString*)getMac;

/**
 更新AID参数
 @param AID AID数据内容
 @return 更新结果
 */
- (BOOL)updateAID:(NSString *)AID;

/**
 更新公钥
 @param keyData 需添加的Key
 @return 更新结果
 */
- (BOOL)updatePubKey:(NSString *)keyData;

/**
 *  清除AID参数
 */
- (BOOL)clearAID;

/**
 *  清除公钥列表
 */
- (BOOL)clearPubKey;

/**
 获取设备电量
 */
- (NSString *)getDevicePower;

/**
 打印固定模板签购单(消费成功后调用,打印固定模板的签购单)
 @param  saleSlip           SalesSlipModel
 @param  parameter          自定义参数
 @return 成功/失败
 */
- (BOOL)printSalesSlip:(SalesSlipModel *)saleSlip andCustomParameter:(NSDictionary *)parameter;

/**
 重打设备保存的上一笔交易的签购单
 @return 成功/失败
 */
- (BOOL)reprintSalesSlip;

/**
 设置打印机参数
 @param  type               IparamType 参数类型
 @param  content            内容数据(1.打印加热时间:单位微秒,0500~2500 之间取值,字符串长度 4,只允许出现数字
 2.两联之间的间隔时间:单位毫秒,2000~9999 之间取值,字符串长度 4, 只允许出现数字
 3.打印联数:只允许在 00,01,02 之间取值,00 表示打印两联,01 表示只 打印商户存根联,02 表示只打印持卡人存根联)
 @return 成功/失败
 */
- (BOOL)setPrinterParams:(IparamType)type ContentData:(NSString *)content;

/**
 获取打印机打印参数
 @return    返回打印机参数,长度为 10 的字符串,前四表示打印机加热时间,单 位微秒;中间四表示两联之间的间隔时间,单位毫秒;最后两表示打印 联数,00 表示打印两联,01 表示只打印商户存根联,02 表示只打印持 卡人存根联)
 */
- (NSString *)getPrinterParams;

/**
 打开透传通道
 @return  成功/失败 回调onOpenChannel：
 */
- (BOOL)openChannelWithCardType:(TY_ChannelCardType)cardType;

/**
 关闭透传通道
 @return  成功/失败 回调onCloseChannel：
 */
- (BOOL)closeChannelWithCardType:(TY_ChannelCardType)cardType;

/**
 卡片复位
 @return  成功/失败 回调onResetCard：
 */
- (BOOL)resetCard:(TY_ChannelCardType)cardType;

/**
 * 发送APDU命令
 *
 *  @param cmd    命令数据
 *  @param cmdLen 数据长度
 *  @param resBuf 接收响应数据
 *
 *  @return > 0 表示接收的数据长度   < 0 代表相应类型的错误
 */
- (int)TransCommand:(Byte [])cmd cmdDataLen:(int)cmdLen resBuf:(Byte [])resBuf;


/**
 *  设备LCD显示
 *
 *  @param type 显示类型：0
 *  @param timeOut 显示超时，单位秒
 *  @param content 显示内容
 *
 *  @return   成功/失败
 */
- (BOOL)showLCD:(int)type withTimeOut:(int)timeOut withContent:(NSString *)content;

/**
 升级固件
 升级结果回调 onUpGrade
 升级进度回调 onUpgradeProgress
 @param file 升级文件数据
 */
- (BOOL)updateFireWare:(NSData *)file;

#pragma mark ----------------新增机具显示支付二维码接口---------------------
/**
 刷卡二维码显示接口 在readCard基础上添加2个参数
 @param qrCodeUrlStr 二维码链接 (最大长度300)，不显示二维码时传nil
 @param qrCodeType   二维码类型（00-无类型，01-支付宝，02-微信，03-银联，04-聚合)，不显示二维码时传nil
 */
-(NSDictionary *)readCardWithQRCode:(NSString *)amount
                       TerminalTime:(NSString *)terminalTime
                          TradeType:(Byte)tradeType
                            timeout:(int)swipeTimeOut
                             Demote:(NSString *)demote
                             Random:(NSString *)random
                            Channel:(Byte)channel
                       QRCodeUrlStr:(NSString *)qrCodeUrlStr
                         QRCodeType:(NSString *)qrCodeType;

/**
 二维码显示
 @param qrCodeType  二维码类型（00-无类型，01-支付宝，02-微信，03-银联，04-聚合)
 @param content  二维码链接(最大长度300)
 @param timeOut  显示时长(最大255)，传入0代表一直显示
 回调onShowQRcode
 */
- (BOOL)showQRcode:(NSString *)qrCodeType showContent:(NSString *)content timeOut:(int)timeout;

/**
 二维码交易结果显示
 @param content  显示内容(最大10个汉字或者21个英文字符)
 @param timeOut  显示时长(最大255)，传入0默认显示60秒
 回调onShowQRcodePayResult
 */
- (BOOL)showQRcodePayResult:(NSString *)content timeOut:(int)timeout;

- (void)setParam:(NSString *)key data:(NSString *)value;

- (NSString *)getParam:(NSString *)key;

/**
 设置免签免密限额
 @param amount 限额，单位为分
 */
- (void)setLimitAmount:(NSString *)amount;
@end

#pragma mark - 回调方法

@protocol TYSwiperControllerDelegate <NSObject>
@optional
/**
 设备已连接
 @param isSuccess 布尔值 YES表示已连接
 */
- (void)onConnectedDevice:(BOOL)isSuccess;

/**
 设备是否断开
 @param isSuccess 布尔值 YES表示已断开
 */
- (void)onDisConnectedDevice:(BOOL)isSuccess;

/**
 返回扫描到的蓝牙设备
 @param device 存储的是扫描到的蓝牙对象
 */
- (void)onDiscoverDevice:(CBPeripheral*)device;

/**
 *  返回设备ID
 *
 *  @param deviceID 设备ID
 */
- (void)onReceiveDeviceCSN:(NSString *)csn;

/**
 *  返回银联21号文报备信息
 *  @param ksnDic 银联21号文报备信息
 ksn:KSN明文(终端序列号)
 deviceType:终端类型
 deviceModel：终端产品型号
 company:终端生产企业名称
 isOldDevice: 00表示新设备，01表示老设备
 */
-(void)onReceiveDeviceKSNInfo:(NSDictionary *)ksnDic;

/**
 *  返回设备唯一标识认证等相关信息
 *  @param IdInfoDic 设备唯一标识认证信息
 ksn:KSN明文(终端序列号)
 factor:加密随机因子明文
 cipher:8字节密文数据
 sappVer:应用程序版本号
 */
- (void)onReceiveDeviceIdentifyInfo:(NSDictionary *)IdInfoDic;

/**
 *  返回21号文117域报文信息
 *  @param feild117Data 21号文117域报文信息
 */
- (void)onReceiveIso8583Feild117:(NSString *)feild117Data;

/**
 *  返回21号文59域报文信息
 *  @param feild59Data 21号文59域报文信息
 */
- (void)onReceiveIso8583Feild59:(NSString *)feild59Data;

/**
 *  返回设备SN
 *
 *  @param deviceID 设备sn
 */
- (void)onReceiveDeviceSN:(NSString *)sn;

/**
 获取pos/reader设备信息

 @param info 设备信息字典数据
 *  @"sn":设备sn
 *  @"keyboard":0，带键盘；1，无键盘
 */
- (void)onReceivePosInfo:(NSDictionary *)info;

/**
 是否成功更新主密钥
 @param isSuccess 更新状态
 */
- (void)onUpdateMainKey:(BOOL)isSuccess;


/**
 *  是否成功更新密钥
 *
 *  @param isSuccess 成功/失败
 */
-(void)onUpdateWorkingKeyResult:(BOOL)TDK result:(BOOL)PIK result:(BOOL)MAK;

/**
 获取用 MACkey 加密后的数据
 @param mac 8字节的加密数据
 */
- (void)onGetMacWithMKIndex:(NSString *)mac;

/**
 获取mac地址
 */
- (void)onGetMac:(NSString *)mac;

/**
 *  提示已经获取到卡片信息
 */
- (void)onReadCardData:(NSDictionary *)cardInfo;

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
- (void)onReadCard:(NSDictionary *)data;

/**
 二维码显示回调
 @param isSuccess  YES代表成功  NO代表失败
 */
- (void)onShowQRcode:(BOOL)isSuccess;

/**
 二维码交易结果显示回调
 @param isSuccess  YES代表成功  NO代表失败
 */
- (void)onShowQRcodePayResult:(BOOL)isSuccess;

/**
 卡号
 cardNumber:卡号
 errorCode:错误码
 */
- (void)onReceiveCardNumber:(NSDictionary *)data;

/**
 获取返回的错误码
 @param errorCode    错误码
 @param tradeType    交易类型
 @param message      交易信息，如无可以为nil
 */
- (void)onReceiveError:(NSString *)errorCode TradeType:(int)tradeType ErrorMessage:(NSString *)message;

/**
 PINBlock返回
 @param PINBlock 返回的密码,随机数,错误码
 */
- (void)onPinBlock:(NSDictionary *)PINBlock;

/**
 确认交易回调
 @param isSuccess  成功/失败
 */
- (void)onConfirmTransaction:(BOOL)isSuccess;

/**
 交易响应返回
 @param data 55域数据
 */
- (void)onResponseToTransaction:(NSData *)data;

/**
 下载商户号终端号结果
 @param result 是否下载成功
 */
- (void)onDownloadBusinessIDTerminalID:(BOOL)result;

/**
 读批次号、流水号结果
 @param IDdata
 *  @return batchID  批次号
 *  @return serialID 流水号
 */
- (void)onReadBatchIDSerialID:(NSDictionary *)IDdata;

/**
 更新批次号、流水号结果
 @param result 是否下载成功
 */
- (void)onUpdateBatchIDSerialID:(BOOL)result;

/**
 更新AID结果
 @param isSuccess  成功/失败
 */
- (void)onUpdateAID:(BOOL)isSuccess;

/**
 更新RID结果
 @param isSuccess  成功/失败
 */
- (void)onUpdateRID:(BOOL)isSuccess;

/**
 清除AID结果
 @param isSuccess  成功/失败
 */
- (void)onClearAID:(BOOL)isSuccess;

/**
 清除RID结果
 @param isSuccess  成功/失败
 */
- (void)onClearRID:(BOOL)isSuccess;

/**
 *  返回设备电量
 *
 *  @param devicePower 设备电量
 */
- (void)onReceiveDevicePower:(NSString *)devicePower;

/**
 打印固定模板签购单
 @param result 是否打印成功
 */
- (void)onPrintSalesSlip:(BOOL)isSuccess;

/**
 重打设备保存的上一笔交易的签购单结果
 @param result 是否打印成功
 */
- (void)onReprintSalesSlip:(BOOL)isSuccess;

/**
 打印自定义数据结果
 @param result 是否打印成功
 */
- (void)onPrintCustomSalesSlip:(BOOL)isSuccess;

/**
 设置打印机配置结果
 @param result 是否设置成功
 */
- (void)onSetPrinterParams:(BOOL)isSuccess;

/**
 获取打印机配置结果
 @param str 返回打印机参数,长度为 10 的字符串,前四表示打印机加热时间,单 位微秒;中间四表示两联之间的间隔时间,单位毫秒;最后两表示打印 联数,00 表示打印两联,01 表示只打印商户存根联,02 表示只打印持 卡人存根联
 */
- (void)onGetPrinterParams:(NSString *)str;

/**
 关闭透传通道结果
 @param isSuccess 是否成功
 */
- (void)onCloseChannel:(BOOL)isSuccess;

/**
 打开透传通道结果
 @param isSuccess 是否成功
 */
- (void)onOpenChannel:(BOOL)isSuccess;

/**
 卡片复位结果
 @param isSuccess 是否成功
 */
- (void)onResetCard:(BOOL)isSuccess;

/**
 自定义内容显示结果
 @param result 是否成功
 */
- (void)onShowLCD:(BOOL)isSuccess;

/**
 错误码
 @param code
 */
- (void)onErrorCode:(NSInteger)code AndInfo:(NSString *)str;

/**
 固件升级结果回调
 @param message  固件升级结果
 message:  “00”    固件升级成功
           “41”    升级失败：升级文件错误
           “42”    升级失败：PN号（设备型号）不匹配
           “43”    升级失败：固件版本号不匹配
           “44”    升级失败：升级认证失败
           “45”    升级失败：擦除备份区失败
           “46”    升级失败：下载固件密文失败
           “47”    升级失败：下载备份区参数失败
           “48”    升级失败：升级条件不满足
           “49”    升级失败：终端存储空间不足
           “50”    升级失败：sdk异常错误
           “51”    升级失败：终端未写入防切机公钥
           “52”    升级失败：验签失败
           “53”    升级失败：数据备份失败
 */
- (void)onUpGrade:(NSString*)message;

/**
 固件升级进度回调
 @param  progress  固件升级进度值(百分比数值，例如progress等于50，即代表升级进度为50%)
 */
- (void)onUpgradeProgress:(int)progress;

@end

