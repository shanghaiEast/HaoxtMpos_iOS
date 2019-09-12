//
//  GetXToken.m
//  HuaTongAPP
//
//  Created by huatong on 2018/1/4.
//  Copyright © 2018年 yan. All rights reserved.
//

#import "GetXToken.h"

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "AFNetworking.h"


@implementation GetXToken

+(instancetype)instance{
    static GetXToken *xTokenOj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xTokenOj = [[GetXToken alloc] init];
    });
    
    return xTokenOj;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}


+ (void)postWithURLStringForXToken:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
{
    
    URLString = [NSString stringWithFormat:@"%@%@",URL_BASE,URLString];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    [self AFNetworkReachabilityManager];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
    
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"VERSION"];
    [manager.requestSerializer setValue:@"4556" forHTTPHeaderField:@"_EBaiYinT_"];
    
    // 获取app build版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSMutableDictionary *endDic = [parameters mutableCopy];
    
    
//    NSLog(@"myUserID === %@",myUserID);
//    if (![checkNull(myUserID) isEqualToString:@""]) {
//        [endDic setValue:myUserID forKey:@"u_token"];
//    }else{
//        [endDic setValue:@"" forKey:@"u_token"];
//    }
    
    [manager.requestSerializer setValue:[AESUtility EncryptString:[ToolsObject x_tokenJoint:endDic andPrivateKeys:@""]] forHTTPHeaderField:@"X-TOKEN"];
    
    NSLog(@"X-TOKEN ==== %@",[AESUtility EncryptString:[ToolsObject x_tokenJoint:endDic  andPrivateKeys:@""]]);
    NSLog(@"request_Dic ==== %@",endDic);
    
    NSLog(@"request_url ==== %@\nX-TOKEN ==== %@",URLString,[AESUtility EncryptString:[ToolsObject x_tokenJoint:endDic  andPrivateKeys:@""]]);
    
    endDic =  [ToolsObject encryptProcessDictionaryIsNSNull:endDic];
    
    NSLog(@"request_Dic ==== %@",endDic);

    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"post_url === %@",URLString);
        
        //            NSLog(@"%@", responseObject);
        if (success) {
            //            NSLog(@"%@", responseObject);
            NSString *aString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            aString = [aString stringByReplacingOccurrencesOfString:@":null"withString:@":\"\""];
            NSLog(@"%@", aString);
            NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
            
            
            id  ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
            
            //token失效 ，跳转登录
            if ([[ckdata objectForKey:@"code"] intValue] == 201) {
                [ToolsObject SVProgressHUDDismiss];
                
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[ckdata objectForKey:@"code"],@"failCode", nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToLogin" object:self userInfo:dic];
                
                return ;
            }
            
            
//            [ToolsObject SVProgressHUDDismiss];
            
            [ToolsObject processDictionaryIsNSNull:ckdata];
            
            [[NSUserDefaults standardUserDefaults] setValue:[ckdata objectForKey:@"data"] forKey:@"timeValue"];
            
            success(ckdata);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [ToolsObject SVProgressHUDDismiss];
    }];
    
    
}


@end

