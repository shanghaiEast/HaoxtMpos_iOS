//
//  SalesSlipModel.h
//  TYDeviceDriver
//
//  Created by xiao on 16/1/11.
//  Copyright © 2016年 xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesSlipModel : NSObject

typedef NS_ENUM(NSInteger, IcontentType) {
    SLIP_BARCODE    =   00,   //条形码[支持纯数字 14 位,纯字母或常用符号 7 位,数字、字母(或 常用符号)混合视情况不等]
    SLIP_QRCODE     =   01,   //二维码[支持最大 127 字符]
    SLIP_CHARACTER  =   02,   //文字[最大支持 GBK 编码 255 个字节]
    SLIP_PICTURE    =   03,   //图片[最大 10K]
    SLIP_TOPLOGE    =   04,   //签购单顶部 logo
};

typedef NS_ENUM(NSInteger, IparamType) {
    PARAM_HEATTIME       =    00,     //打印机加热时间
    PARAM_INTERVALTIME   =    01,     //两联之间的间隔时间
    PARAM_PIECECOUNT     =    02,     //打印联数
};


//商户名称(eg."天喻信息",必填)
@property (retain, nonatomic)NSString *merchantName;

//商户号(ASCII 码,eg."001210381234567", 可从 42 域获取,必填)
@property (retain, nonatomic)NSString *merchantNo;

//终端号(ASCII 码,eg."00121038",可从 41 域获取,必填)
@property (retain, nonatomic)NSString *terminalNo;

//操作员号(ASCII 码,eg."01")
@property (retain, nonatomic)NSString *operatorNo;

//卡号(eg."6222003202100054698",可刷卡获得,也可从 2 域获取,取出实际卡号,必填)
@property (retain, nonatomic)NSString *cardNo;

//信用卡公司代码(ASCII 码,eg."622",可从 63.1 域获取,外卡时必填)
@property (retain, nonatomic)NSString *creditCompanyCode;

////银联 8583 报文 44 域:AN11 发卡行标识码+AN11 商户结算行标识码 (ASCII码,eg."62284826 ",可从 44 域获取,必填)
//@property (retain, nonatomic)NSString *data44;

//AN11 发卡行标识码+AN11(ASCII码,eg."62284826   ",可从 44 域获取,必填)
@property (retain, nonatomic)NSString *bankCode;

//AN11 商户结算行标识码 (ASCII码,eg."00965840   ",可从 44 域获取,必填)
@property (retain, nonatomic)NSString *merchantCode;

//交易类型(eg."消费(SALE)",必填)
@property (retain, nonatomic)NSString *transactionType;

//卡片有效期(BCD 码,eg."2512",可从 14 域获取)
@property (retain, nonatomic)NSString *cardValidThru;

//批次号(BCD 码,eg."002018",可从 60.2 域获取,必填)
@property (retain, nonatomic)NSString *batchNo;

//凭证号(BCD 码,流水号,eg."000003",可从 11 域获取,必填)
@property (retain, nonatomic)NSString *voucherNo;

//授权码(ASCII 码,eg."008295",可从 38 域获取)
@property (retain, nonatomic)NSString *authorizeNo;

//交易时间(BCD 码,eg."194923",可从 12 域获取,必填)
@property (retain, nonatomic)NSString *tradeTime;

//交易日期(BCD 码,YYYYMMDD,eg."20151231",可从 13 域获 取,前面加上年份,必填)
@property (retain, nonatomic)NSString *tradeDate;

//参考号(ASCII 码,eg."171820187826",可从 37 域 获取,必填)
@property (retain, nonatomic)NSString *referenceNo;

//交易金额(BCD 码,分为单位,1.5 元则传入 150,可从 4 域获取,必填)
@property (retain, nonatomic)NSString *tradeAmount;

//IC卡55域(IC卡插卡获取的 55 域,IC卡时必填)
@property (retain, nonatomic)NSString *icData55;

//条形码
@property (retain, nonatomic)NSString *barCode;

//二维码
@property (retain, nonatomic)NSString *QRCode;

//币种
@property (retain, nonatomic)NSString *currencyType;

//附加信息
@property (retain, nonatomic)NSString *additionalData;

//打印模板(当前只支持 01)
@property (retain, nonatomic)NSString *template1;



@end
