//
//  YHQNetWorking.m
//  HuaTongAPP
//
//  Created by Jack Yan on 2017/10/16.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "YHQNetWorking.h"

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "AFNetworking.h"


@interface YHQNetWorking ()
{
    MBProgressHUD *_hud;

}
@end

@implementation YHQNetWorking


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
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    //    manager.requestSerializer.timeoutInterval = 5;
    
     [manager GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"get_url === %@",URLString);
        
        if (success) {
            NSString *aString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            aString = [aString stringByReplacingOccurrencesOfString:@":null"withString:@":\"\""];
            NSLog(@"%@", aString);
            NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
            
            id  ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
            
            
            success(ckdata);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            
            if (error.code == -1001) {
             
//                [ToolsObject showMessageTitle:[ReadConfigFile configObjectForKey:[NSString stringWithFormat:@"%ld",error.code] forResource:@"Config"] andDelay:1.0 andImage:nil];
                
            }else{
//                NSLog(@"%@",error);
            }
            
            
        }
    }];
}


#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    [GetXToken postWithURLStringForXToken:Public_GetNowTime_url parameters:[[NSDictionary alloc] init] success:^(id responseObject) {
        
        NSLog(@"responseObject === %@",responseObject);
        if ([[responseObject objectForKey:@"code"] intValue] == 200) {
            
            NSString *timeStr = [responseObject objectForKey:@"data"];
            timeStr = [timeStr substringFromIndex:11];
            NSArray *array = [timeStr componentsSeparatedByString:@":"];
           
            int time_min = [[array objectAtIndex:1] intValue]/5;
            
            NSArray *selectArray = [[NSArray alloc] initWithObjects:@"abc00", @"abc01", @"abc02", @"abc03", @"abc04", @"abc05", @"abc06", @"abc07", @"abc08", @"abc09", @"abc10", @"abc11", nil];
            
            NSString *keyStr = [NSString stringWithFormat:@"%@%@",[selectArray objectAtIndex:time_min],@".op@x[y%.op@x[y%.op@x[y%.op"];
            NSLog(@"responseObject === %@",[selectArray objectAtIndex:time_min]);
            NSLog(@"keyStr === %@",keyStr);
            
            [self checkNetworkState];
            
            NSString *_URLString = [NSString stringWithFormat:@"%@%@",URL_BASE,URLString];
            _URLString = [_URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [self AFNetworkReachabilityManager];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",@"application/x-javascript",nil];
            [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
            //图片验证码
            if ([URLString isEqualToString:CheckImageCode_url]) {
                [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"myImageCode"] forHTTPHeaderField:@"_ImageCode_"];
            }
            
            // 获取app build版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            
            [manager.requestSerializer setValue:app_build forHTTPHeaderField:@"VERSION"];
            
            [manager.requestSerializer setValue:myUserToken forHTTPHeaderField:@"_EBaiYinT_"];
            
            NSMutableDictionary *endDic = [parameters mutableCopy];
            [endDic setValue:@"1" forKey:@"agent"];

            [manager.requestSerializer setValue:[AESUtility EncryptString:[ToolsObject x_tokenJoint:endDic andPrivateKeys:keyStr]] forHTTPHeaderField:@"X-TOKEN"];
            
//            NSLog(@"X-TOKEN ==== %@",[AESUtility EncryptString:[ToolsObject x_tokenJoint:endDic  andPrivateKeys:keyStr]]);
//            NSLog(@"request_Dic ==== %@",endDic);
//
            NSLog(@"request_url ==== %@\nX-TOKEN ==== %@",URLString,[AESUtility EncryptString:[ToolsObject x_tokenJoint:endDic  andPrivateKeys:keyStr]]);
            
            NSLog(@"request_Dic1 ==== %@",endDic);
            
            endDic =  [ToolsObject encryptProcessDictionaryIsNSNull:endDic];
            
            NSLog(@"request_Dic ==== %@",endDic);
            
            
             [manager POST:_URLString parameters:endDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 
                 //登录token
                 if ([URLString isEqualToString:LoginAPP_url]) {
                      if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
                          NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                          NSLog(@"%@",[r allHeaderFields]);
                          
                          NSLog(@"%@",[[r allHeaderFields] objectForKey:@"_EBaiYinT_"]);
                          [[NSUserDefaults standardUserDefaults] setValue:[[r allHeaderFields] objectForKey:@"_EBaiYinT_"] forKey:@"myToken"];
                      }
                 }
                 //图片验证码
                 if ([URLString isEqualToString:GetImage_url]) {
                     if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
                         NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                         NSLog(@"%@",[r allHeaderFields]);
                         
                         NSLog(@"%@",[[r allHeaderFields] objectForKey:@"_ImageCode_"]);
                         [[NSUserDefaults standardUserDefaults] setValue:[[r allHeaderFields] objectForKey:@"_ImageCode_"] forKey:@"myImageCode"];
                     }
                     
                 }
                 
                
                NSLog(@"post_url === %@",URLString);
                
                if (success) {
                    NSLog(@"%@", responseObject);
                    NSString *aString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                    aString = [aString stringByReplacingOccurrencesOfString:@":null"withString:@":\"\""];
                    NSLog(@"%@", aString);
                    NSData* xmlData = [aString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    id  ckdata = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];
                    
                    //token失效 ，跳转登录
                    if ([[ckdata objectForKey:@"code"] intValue] == 201) {
                        [ToolsObject SVProgressHUDDismiss];
                        
//                        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[ckdata objectForKey:@"code"],@"failCode", nil];
//
//                        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToLogin" object:self userInfo:dic];
                        
                        if ([myUserToken length] != 0) {
                            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                                NSLog(@"%ld",(long)iResCode);
                            } seq:[myUserID integerValue]];
                            
                            //清空数据，退出
                            [ToolsObject deleteUserData:nil];
                            
                            [JPUSHService setBadge:0];
                            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                            
                            UIViewController *topmostVC = [self ttopViewController];
                            
                            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//                            loginVC.jumpType = 1;
                            loginVC.hidesBottomBarWhenPushed = YES;
                            [topmostVC.navigationController pushViewController:loginVC animated:YES];
                            
                            return;
                        }
                        
                        return ;
                    }
                    
                    if ([[ckdata objectForKey:@"code"] intValue] == 401) {
                        [ToolsObject SVProgressHUDDismiss];
                        
                        if ([myUserToken length] != 0) {
                            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                                NSLog(@"%ld",(long)iResCode);
                            } seq:[myUserID integerValue]];
                            
                            [ToolsObject showMessageTitle:[ckdata objectForKey:@"msg"] andDelay:2.0f andImage:nil];

                            //清空数据，退出
                            [ToolsObject deleteUserData:nil];

                            [JPUSHService setBadge:0];
                            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

                            UIViewController *topmostVC = [self ttopViewController];

                            LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//                            loginVC.jumpType = 1;
                            loginVC.hidesBottomBarWhenPushed = YES;
                            [topmostVC.navigationController pushViewController:loginVC animated:YES];

                            return;
                        }
                    }
                    
                    
                    
                    
                    [ToolsObject SVProgressHUDDismiss];
                    
                    [ToolsObject processDictionaryIsNSNull:ckdata];
                    
                    success(ckdata);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    
                    failure(error);
                    NSLog(@"error === %@",error);
                    
                    [ToolsObject SVProgressHUDDismiss];
                    
                }
            }];

            
        }else{
//            [ToolsObject SVProgressHUDDismiss];
        }
        
        
    } failure:^(NSError *error) {
//        [ToolsObject SVProgressHUDDismiss];
    }];
    

}




#pragma mark -- POST/GET网络请求 --
//+ (void)requestWithURLString:(NSString *)URLString
//                  parameters:(id)parameters
//                        type:(HttpRequestType)type
//                     success:(void (^)(id))success
//                     failure:(void (^)(NSError *))failure {
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    switch (type) {
//        case HttpRequestTypeGet:
//        {
//            [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                if (success) {
//                    success(responseObject);
//                }
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                if (failure) {
//                    failure(error);
//                }
//            }];
//        }
//            break;
//        case HttpRequestTypePost:
//        {
//            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                if (success) {
//                    success(responseObject);
//                }
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                if (failure) {
//                    failure(error);
//                }
//            }];
//        }
//            break;
//    }
//}


#pragma mark -- 上传图片 --


+ (void)uploadWithURLString:(NSString *)URLString viewController:(UIViewController *)controller parameters:(id)parameters UIImage:(UIImage *)image success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure {
    
//    // 获取app build版本
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//
//    NSMutableDictionary *endDic = [parameters mutableCopy];
//    [endDic setValue:@"1" forKey:@"agent"];
//    [endDic setValue:app_build forKey:@"version"];
//    if (![myToken isEqualToString:@""]) {
//        [endDic setValue:myToken forKey:@"u_token"];
//    }else{
//        [endDic setValue:@"" forKey:@"u_token"];
//    }
//
//
//    NSString *tmpfile = [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
//    NSURL *fileurl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpfile]];
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:endDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *data=UIImagePNGRepresentation(image);//数据转换
//        if (data == nil) {
//            return ;
//        }
//
//        [formData appendPartWithFileData:data name:@"image" fileName:@"image.png" mimeType:@"image/jpeg"];
//
//        NSLog(@"%@", formData);
//
//    } error:nil];
//
//    [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:request writingStreamContentsToFile:fileurl completionHandler:^(NSError * _Nullable error) {
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
//
//
//
////        [manager.requestSerializer setValue:[ToolsObject x_tokenJoint:endDic] forHTTPHeaderField:@"X-TOKEN"];
//
//
//        NSURLSessionDataTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:fileurl progress:^(NSProgress * _Nonnull uploadProgress) {
//
//            NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//            // 回到主队列刷新UI,用户自定义的进度条
//
//            NSString *str = [NSString stringWithFormat:@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
//
//
////            dispatch_async(dispatch_get_main_queue(), ^{
////                self.progressView.progress = 1.0 *
////                uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
////            });
//
//        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"%@", error);
//            } else {
//
//                success(responseObject);
//                NSLog(@"上传成功");
//
//            }
//
//        }];
//        [uploadTask resume];
//    }];
//
    
}

- (void)sentTime:(float)value
{
    if (_uploadWait) {
        _uploadWait(value);
    }
}


+(void)uploadWithURLString:(NSString *)URLString parameters:(id)parameters imageArr:(NSArray *)imageArr success:(void (^)())success failure:(void (^)(NSError *))failure {
    // 向服务器提交图片
    NSString *tmpfile = [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
    NSURL *fileurl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpfile]];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(int i = 0; i < imageArr.count; i++)
        {
            NSData *data=UIImagePNGRepresentation(imageArr[i]);//数据转换
            // 上传的参数名
            NSString * Name =[NSString stringWithFormat:@"photos[0][%d]", i];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.png", Name];
            [formData appendPartWithFileData:data name:Name fileName:fileName mimeType:@"image/jpeg"];
            NSLog(@"%@", formData);
        }
    } error:nil];
    [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:request writingStreamContentsToFile:fileurl completionHandler:^(NSError * _Nullable error) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
        NSURLSessionDataTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:fileurl progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                NSLog(@"上传成功");
                
                
            }
        }];
        [uploadTask resume];
    }];
    
}

//获取token
+ (void)postTokenURLString:(NSString *)URLString
                parameters:(id)parameters
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure {
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"uuid"], @"sn", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"%@", URLString] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            
            NSString *aString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            NSLog(@"%@", aString);
            
            id  ckdata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            success(ckdata);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//取消所有的 operation --
+ (void)cancelAllRequest
{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.operationQueue cancelAllOperations];
}

//取消某个URL的请求
+ (void)cancelHTTPOperationsWithMethod:(NSString *)method url:(NSString *)url
{
//    NSError *error;
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    NSString *pathToBeMatched = [[[manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:url] absoluteString] parameters:nil error:&error] URL] path];
//
//    for (NSOperation *operation in [manager.operationQueue operations]) {
//        if (![operation isKindOfClass:[AFHTTPRequestSerializer class]]) {
//            continue;
//        }
//        BOOL hasMatchingMethod = !method || [method  isEqualToString:[[(AFHTTPRequestOperation *)operation request] HTTPMethod]];
//        BOOL hasMatchingPath = [[[[(AFHTTPRequestOperation *)operation request] URL] path] isEqual:pathToBeMatched];
//
//        if (hasMatchingMethod && hasMatchingPath) {
//            [operation cancel];
//        }
//    }
}


+ (void)AFNetworkReachabilityManager
{
    //创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
     AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络(未连接)
     AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
     AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
     };
     */
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
            
                [ToolsObject showMessageTitle:@"未识别的网络" andDelay:1.0 andImage:nil];
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                
//                HUD_CUSTOM_ERROR(1.0, @"网络不给力，请稍后再试");
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}

#pragma mark iOS 获取当前顶层的ViewController
+ (UIViewController *)ttopViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end

