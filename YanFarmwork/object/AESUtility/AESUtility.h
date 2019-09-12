//
//  AESUtility.h
//  HuaTongAPP
//
//  Created by huatong on 2017/11/28.
//  Copyright © 2017年 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESUtility : NSObject

+ (NSString *)EncryptString:(NSString *)sourceStr;

+ (NSString *)DecryptString:(NSString *)secretStr;

@end
