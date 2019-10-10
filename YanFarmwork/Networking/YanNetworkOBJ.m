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

#import <UIView+MJExtension.h>



#import "LoginViewController.h"


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
    
    parameters = [[ToolsObject processDictionaryIsNSNull:parameters] mutableCopy];
    
//    NSMutableDictionary *endDic = [parameters mutableCopy];
//    [endDic setValue:[ToolsObject getNowTimeTimestamp3] forKey:@"timestamp"];
//    NSString *signStr = [ToolsObject x_tokenJoint:endDic andPrivateKeys:companyKey];
//    [endDic setValue:signStr forKey:@"sign"];
//
//    NSLog(@"endDic :%@", endDic);
    
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    // 获取App的版本号
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
    NSLog(@"%@", appVersion);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if ([myData TOKEN_ID].length != 0) {
        [manager.requestSerializer setValue:[myData TOKEN_ID] forHTTPHeaderField:@"token"];
    }
    
    [manager GET:_URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![[responseObject allKeys] containsObject:@"rspCd"]) {
            NSLog(@"%@", responseObject);
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"message"] andDelay:1.0f andImage:nil];
            return ;
        }
        
        
        if (success) {
            
            //重新登录
            if ([[responseObject objectForKey:@"rspCd"] isEqualToString:@"999998"]) {
                NSLog(@"重新登录 == %@", responseObject);
                NSLog(@"重新登录view == %@", [[ToolsObject currentViewController] nibName]);
                
                [ToolsObject SVProgressHUDDismiss];
                [ToolsObject deleteUserData];
                
                LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                loginVC.hidesBottomBarWhenPushed = YES;
                [[ToolsObject currentViewController].navigationController pushViewController:loginVC animated:YES];
                
                //                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                //
                //                if ([[[ToolsObject currentViewController] nibName]  isEqual: @"MainViewController"]) {
                //                    [app.mainVC checkLogin];
                //                }else{
                //                    app.tabBarC.selectedIndex = 0;
                //                }
                return ;
            }
            
            
            
            //去除null 方法一
            //            responseObject = [ToolsObject processDictionaryIsNSNull:responseObject];
            //            success(responseObject);
            
            
            
            //去除null 方法二
            NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            //            NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSString *aString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
            aString = [aString stringByReplacingOccurrencesOfString:@": null"withString:@":\"\""];
            NSLog(@"aString : %@", aString);
            NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
            id  ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
            
            //            NSLog(@"ckdata ： %@", ckdata);
            
            success(ckdata);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        [ToolsObject SVProgressHUDDismiss];
    }];
    
    
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    NSString *_URLString = [NSString stringWithFormat:@"%@%@",URL_BASE,URLString];
    _URLString = [_URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    parameters = [[ToolsObject processDictionaryIsNSNull:parameters] mutableCopy];
    
    NSLog(@"_URLString :%@", _URLString);
//     NSLog(@"[ToolsObject checkNull:parameters] :%@", [ToolsObject checkNull:parameters]);
    NSLog(@"parameters :%@", parameters);
    
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    // 获取App的版本号
//    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
//
//    NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
//    NSLog(@"%@", appVersion);
    

    //初始化一个AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    
    manager.requestSerializer.timeoutInterval = 120;
    
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    /*设置客户端的响应格式*/
//    Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

    
     if ([myData TOKEN_ID].length != 0) {
         [manager.requestSerializer setValue:[myData TOKEN_ID] forHTTPHeaderField:@"token"];
     }
    
    
    NSString *urlString_check = [NSString stringWithFormat:@"%@%@",URL_BASE,usr_chkRealSts];
    urlString_check = [urlString_check stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *checkDict = [NSDictionary new];
    
   
    [manager POST:urlString_check parameters:checkDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data= [NSJSONSerialization dataWithJSONObject:checkDict options:NSJSONWritingPrettyPrinted error:nil];
        [formData appendPartWithFormData:data name:@"Data"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"check sts responseObject:%@", responseObject);
        
        /*
         {
         pageInfo = "<null>";
         responseTm = "<null>";
         rspCd = 000000;
         rspData = "<null>";
         rspInf = "\U8ba4\U8bc1\U6210\U529f\Uff0c\U4e0d\U53ef\U4ee5\U53d1\U8d77";
         rspMap =     {
         "CER_NO" = 33088119910315415X;
         "USR_NM" = "\U4e2a\U4f53\U6237\U4e25\U534e\U5f3a";
         "USR_OPR_NM" = "\U4e25\U534e\U5f3a";
         "USR_REAL_STS" = 2;
         };
         rspType = "<null>";
         success = 0;
         }
         */
        
        
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject objectForKey:@"rspMap"] objectForKey:@"USR_REAL_STS"] forKey:@"USR_REAL_STS"];// USR_REAL_STS  0-可发起  1-待审核  2-通过
            
            //嵌套请求
            [manager POST:_URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                NSData *data= [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
                [formData appendPartWithFormData:data name:@"Data"];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                //NSLog(@"%@",uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                /*返回值已经是字典类型了*/
                //        NSLog(@"%@", responseObject);
                
                if (![[responseObject allKeys] containsObject:@"rspCd"]) {
                    NSLog(@"%@", responseObject);
                    [ToolsObject showMessageTitle:[responseObject objectForKey:@"message"] andDelay:1.0f andImage:nil];
                    return ;
                }
                
                
                if (success) {
                    
                    //重新登录
                    if ([[responseObject objectForKey:@"rspCd"] isEqualToString:@"999998"]) {
                        NSLog(@"重新登录 == %@", responseObject);
                        NSLog(@"重新登录view == %@", [[ToolsObject currentViewController] nibName]);
                        
                        [ToolsObject SVProgressHUDDismiss];
                        [ToolsObject deleteUserData];
                        
                        [manager.operationQueue cancelAllOperations];
                        
                        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        loginVC.hidesBottomBarWhenPushed = YES;
                        [[ToolsObject currentViewController].navigationController pushViewController:loginVC animated:YES];
                        
                        //                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        //
                        //                if ([[[ToolsObject currentViewController] nibName]  isEqual: @"MainViewController"]) {
                        //                    [app.mainVC checkLogin];
                        //                }else{
                        //                    app.tabBarC.selectedIndex = 0;
                        //                }
                        return ;
                    }
                    
                    
                    
                    //去除null 方法一
                    //            responseObject = [ToolsObject processDictionaryIsNSNull:responseObject];
                    //            success(responseObject);
                    
                    
                    
                    //去除null 方法二
                    NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                    //            NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    
                    NSString *aString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                    aString = [aString stringByReplacingOccurrencesOfString:@": null"withString:@":\"\""];
                    NSLog(@"aString : %@", aString);
                    NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
                    id  ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
                    
                    //            NSLog(@"ckdata ： %@", ckdata);
                    
                    success(ckdata);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@", error);
                [ToolsObject SVProgressHUDDismiss];
            }];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"check sts error :%@", error);
        
    }];
    

   
 
}
     
#pragma mark -- POST请求 --
+ (void)postWithURLString_normal:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    NSString *_URLString = [NSString stringWithFormat:@"%@%@",URL_BASE,URLString];
    _URLString = [_URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    parameters = [[ToolsObject processDictionaryIsNSNull:parameters] mutableCopy];
    
    NSLog(@"_URLString :%@", _URLString);
    //     NSLog(@"[ToolsObject checkNull:parameters] :%@", [ToolsObject checkNull:parameters]);
    NSLog(@"parameters :%@", parameters);
    
    //    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //    // 获取App的版本号
    //    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //
    //    NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
    //    NSLog(@"%@", appVersion);
    
    
    //初始化一个AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    
    manager.requestSerializer.timeoutInterval = 120;
    
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    /*设置客户端的响应格式*/
    //    Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    if ([myData TOKEN_ID].length != 0) {
        [manager.requestSerializer setValue:[myData TOKEN_ID] forHTTPHeaderField:@"token"];
    }
    
    
    [manager POST:_URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data= [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        [formData appendPartWithFormData:data name:@"Data"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*返回值已经是字典类型了*/
        //        NSLog(@"%@", responseObject);
        
        if (![[responseObject allKeys] containsObject:@"rspCd"]) {
            NSLog(@"%@", responseObject);
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"message"] andDelay:1.0f andImage:nil];
            return ;
        }
        
        
        if (success) {
            
            //重新登录
            if ([[responseObject objectForKey:@"rspCd"] isEqualToString:@"999998"]) {
                NSLog(@"重新登录 == %@", responseObject);
                NSLog(@"重新登录view == %@", [[ToolsObject currentViewController] nibName]);
                
                [ToolsObject SVProgressHUDDismiss];
                [ToolsObject deleteUserData];
                
                [manager.operationQueue cancelAllOperations];
                
                LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                loginVC.hidesBottomBarWhenPushed = YES;
                [[ToolsObject currentViewController].navigationController pushViewController:loginVC animated:YES];
                
                //                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                //
                //                if ([[[ToolsObject currentViewController] nibName]  isEqual: @"MainViewController"]) {
                //                    [app.mainVC checkLogin];
                //                }else{
                //                    app.tabBarC.selectedIndex = 0;
                //                }
                return ;
            }
            
            
            
            //去除null 方法一
            //            responseObject = [ToolsObject processDictionaryIsNSNull:responseObject];
            //            success(responseObject);
            
            
            
            //去除null 方法二
            NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            //            NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSString *aString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
            aString = [aString stringByReplacingOccurrencesOfString:@": null"withString:@":\"\""];
            NSLog(@"aString : %@", aString);
            NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
            id  ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
            
            //            NSLog(@"ckdata ： %@", ckdata);
            
            success(ckdata);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        [ToolsObject SVProgressHUDDismiss];
    }];
    
    
    
    
    
    //    [manager POST:_URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    //        NSLog(@"%@",uploadProgress);
    //    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
    //        /*返回值已经是字典类型了*/
    //        NSLog(@"%@", responseObject);
    //        if (success) {
    //             //去除null 方法一
    ////            responseObject = [ToolsObject processDictionaryIsNSNull:responseObject];
    ////            success(responseObject);
    //
    //
    //
    //            //去除null 方法二
    //            NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    ////            NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //
    //            NSString *aString = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    //            aString = [aString stringByReplacingOccurrencesOfString:@": null"withString:@":\"\""];
    ////            NSLog(@"%@", aString);
    //            NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
    //
    //            id  ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
    //
    //            NSLog(@"ckdata ： %@", ckdata);
    //
    //            success(ckdata);
    //
    //        }
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        NSLog(@"Error: %@", error);
    //         [ToolsObject SVProgressHUDDismiss];
    //    }];
    
    
}
@end

