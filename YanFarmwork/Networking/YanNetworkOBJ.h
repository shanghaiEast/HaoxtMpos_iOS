//
//  YanNetworkOBJ.h
//  YanFarmwork
//
//  Created by 国时 on 2019/5/13.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//上传图片block
typedef void(^UploadImageWait)(float waitTime);


@interface YanNetworkOBJ : NSObject

@property (nonatomic, copy) UploadImageWait uploadWait;


+ (void)checkNetworkState;


///**
// *  图片的二进制数据
// */
//@property (nonatomic, strong) NSData *data;
///**
// *  服务器对应的参数名称
// */
//@property (nonatomic, copy) NSString *name;
///**
// *  文件的名称(上传到服务器后，服务器保存的文件名)
// */
//@property (nonatomic, copy) NSString *filename;
///**
// *  文件的MIME类型(image/png,image/jpg等)
// */
//@property (nonatomic, copy) NSString *mimeType;
/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;


/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param resultBlock 请求的结果
 */
//+ (void)requestWithURLString:(NSString *)URLString
//                  parameters:(id)parameters
//                        type:(HttpRequestType)type
//                     success:(void (^)(id responseObject))success
//                     failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param UIImage 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
//+ (void)uploadWithURLString:(NSString *)URLString
//                 parameters:(id)parameters
//                uploadParam:(UploadParam *)uploadParam
//                    success:(void (^)())success
//                    failure:(void (^)(NSError *error))failure;
//单张图片
+ (void)uploadWithURLString:(NSString *)URLString
             viewController:(UIViewController *)controller
                 parameters:(id)parameters
                    UIImage:(UIImage*)image
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;



//多张图片
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                   imageArr:(NSArray*)imageArr
                    success:(void (^)())success
                    failure:(void (^)(NSError *error))failure;

//Token
+ (void)postTokenURLString:(NSString *)URLString
                parameters:(id)parameters
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

//取消所有的 operation --
+ (void)cancelAllRequest;

//取消某个URL的请求
+ (void)cancelHTTPOperationsWithMethod:(NSString *)method url:(NSString *)url;

+ (void)AFNetworkReachabilityManager;


@end

NS_ASSUME_NONNULL_END
