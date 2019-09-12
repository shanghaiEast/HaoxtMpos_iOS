//
//  YanNetworkOBJ.m
//  YanFarmwork
//
//  Created by 国时 on 2019/5/13.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "YanNetworkOBJ.h"

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "AFNetworking.h"
#import <SBJson/SBJson5Parser.h>

@interface YanNetworkOBJ ()
{
    MBProgressHUD *_hud;
    
}
@end

@implementation YanNetworkOBJ

+ (void)checkNetworkState
{
    if ([[ToolsObject internetStatus] isEqualToString:@"无"]) {
        NSLog(@"没有网络进行上网");
        
        //        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        //        [alert3 show];
    }
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([conn currentReachabilityStatus] != NotReachable) {
        NSLog(@"使用手机自带网络进行上网");
        
    } else { // 没有网络
        NSLog(@"没有网络");
        
    }
}


#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure {
    NSString *_URLString = [NSString stringWithFormat:@"%@%@",URL_BASE,URLString];
    _URLString = [_URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *endDic = [parameters mutableCopy];
    [endDic setValue:[ToolsObject getNowTimeTimestamp3] forKey:@"timestamp"];
    NSString *signStr = [ToolsObject x_tokenJoint:endDic andPrivateKeys:companyKey];
    [endDic setValue:signStr forKey:@"sign"];
    
    NSLog(@"endDic :%@", endDic);
    
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    // 获取App的版本号
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
    NSLog(@"%@", appVersion);
    
    
    AFHTTPSessionManager *Manager = [AFHTTPSessionManager manager];
    /*
     App-Version 版本名称
     App-Token Token
     deviceType 设备类型
     Os-Version 手机型号
     Phone-Model 系统版本
     */
    [Manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"AppVersion"];
    [Manager.requestSerializer setValue:@"test" forHTTPHeaderField:@"AppToken"];
    [Manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"HostType"];
    [Manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"OsVersion"];
    [Manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"PhoneModel"];
    
    
    [Manager GET:_URLString parameters:endDic progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (success) {
            responseObject = [ToolsObject processDictionaryIsNSNull:responseObject];
            

            success(responseObject);
            
            if ([[responseObject objectForKey:@"status"] intValue] == 1) {
//                success(responseObject);
                
            }else{
                //错误信息
                 NSLog(@"错误原因：%@",[responseObject objectForKey:@"message"]);
            }
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ToolsObject SVProgressHUDDismiss];
    }];
    
    
}


#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    NSString *_URLString = [NSString stringWithFormat:@"%@%@",URL_BASE,URLString];
//    NSString *_URLString = @"http://192.168.1.40:8822/app/publicFunds/attention";
//    _URLString = [_URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary *endDic = [parameters mutableCopy];
    [endDic setValue:[ToolsObject getNowTimeTimestamp3] forKey:@"timestamp"];
    NSString *signStr = [ToolsObject x_tokenJoint:endDic andPrivateKeys:companyKey];
    [endDic setValue:signStr forKey:@"sign"];
    
    NSLog(@"endDic :%@", endDic);
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    // 获取App的版本号
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
    NSLog(@"%@", appVersion);
    
#pragma mark JSON传参数
    AFHTTPSessionManager* Manager = [AFHTTPSessionManager manager];
    Manager.requestSerializer  = [AFJSONRequestSerializer  serializer];
    Manager.responseSerializer = [AFJSONResponseSerializer serializer];
    Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    /*设置客户端的响应格式*/
    Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    /*
     App-Version 版本名称
     App-Token Token
     deviceType 设备类型
     Os-Version 手机型号
     Phone-Model 系统版本
     */
    [Manager.requestSerializer setValue:appVersion forHTTPHeaderField:@"AppVersion"];
    [Manager.requestSerializer setValue:@"test" forHTTPHeaderField:@"AppToken"];
    [Manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"HostType"];
    [Manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"OsVersion"];
    [Manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"PhoneModel"];
    

    [Manager POST:_URLString parameters:endDic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        /*返回值已经是字典类型了*/
        NSLog(@"%@", responseObject);
        if (success) {
            responseObject = [ToolsObject processDictionaryIsNSNull:responseObject];

            
            success(responseObject);
            
//            if ([[responseObject objectForKey:@"status"] intValue] == 1) {
//
//
//            }else{
//                //错误信息
//                 NSLog(@"错误原因：%@",[responseObject objectForKey:@"message"]);
//            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
         [ToolsObject SVProgressHUDDismiss];
    }];
   
    
#pragma mark NSDictionary传参数
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",@"application/x-javascript",nil];
//    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
////    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"VERSION"];
////    [manager.requestSerializer setValue:@"4556" forHTTPHeaderField:@"_EBaiYinT_"];
//
//    [manager POST:_URLString parameters:[endDic mutableCopy] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//
//        if (success) {
//            NSLog(@"%@", responseObject);
//            NSString *aString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//            aString = [aString stringByReplacingOccurrencesOfString:@":null"withString:@":\"\""];
//            NSLog(@"success1 : %@", aString);
//            NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
//
//            id ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
//            NSLog(@"success2 : %@", ckdata);
//
//            if ([[ckdata objectForKey:@"status"] intValue] == 1) {
//                success([ckdata objectForKey:@"data"]);
//            }
//        }
//
//    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        [ToolsObject SVProgressHUDDismiss];
//    }];
    
}

@end

