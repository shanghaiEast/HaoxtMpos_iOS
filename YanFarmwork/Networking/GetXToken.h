//
//  GetXToken.h
//  HuaTongAPP
//
//  Created by huatong on 2018/1/4.
//  Copyright © 2018年 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^GetxTokenSuccess)(NSDictionary *dict);

@interface GetXToken : NSObject

//@property (nonatomic, copy) GetxTokenSuccess getxTokenSuccess;

+(instancetype)instance;

//- (NSString *)requestForXToken;
+ (void)postWithURLStringForXToken:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

@end
