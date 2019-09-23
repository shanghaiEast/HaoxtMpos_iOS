//
//  LoginJsonModel.h
//  YanFarmwork
//
//  Created by HG on 2019/9/19.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginJsonModel : NSObject

+ (instancetype) infoWithDictionary:(NSDictionary*)infoDic;
- (instancetype) initWithDictionary:(NSDictionary*)infoDic;

@property(nonatomic, copy)NSString *CCARD_VALID_STS;
@property(nonatomic, copy)NSString *USR_NM;
@property(nonatomic, copy)NSString *CER_NO;
@property(nonatomic, copy)NSString *BLUE_TOOTH;
@property(nonatomic, copy)NSString *USR_LOGIN_MBL;
@property(nonatomic, copy)NSString *USR_OPR_LOG_ID;
@property(nonatomic, copy)NSString *USR_NO;
@property(nonatomic, copy)NSString *USR_OPR_MBL;
@property(nonatomic, copy)NSString *USR_OPR_NM;
@property(nonatomic, copy)NSString *USR_STATUS;
@property(nonatomic, copy)NSString *USR_TERM_STS;
@property(nonatomic, copy)NSString *POS_MER_ID;
@property(nonatomic, copy)NSString *TOKEN_ID;
@property(nonatomic, copy)NSString *FEE_VIP;
@property(nonatomic, copy)NSString *MD5_KEY;
@property(nonatomic, copy)NSString *USR_LOG_ID;

@end

NS_ASSUME_NONNULL_END
