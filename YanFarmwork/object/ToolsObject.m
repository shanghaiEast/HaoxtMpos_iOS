//
//  ToolsObject.m
//  HuaTongAPP
//
//  Created by huatong on 2017/10/20.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "ToolsObject.h"

#import "Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import "CommonCrypto/CommonDigest.h"

#import "sys/utsname.h"

//iOS判断手机上是否安装微信或qq等应用
//#import "WXApi.h"
//#import <TencentOpenAPI/QQApiInterface.h>

#import "SVProgressHUD.h"



//@interface ToolsObject ()
//{
////    RemindView *_remindView;
//}
//
//@property (nonatomic, retain) RemindView *_remindView;
//
//@end

static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
    return ceil(cgfloat);
#else
    return ceilf(cgfloat);
#endif
}

@interface ToolsObject() /*<WXApiDelegate>*/

@end

@implementation ToolsObject

+(instancetype)instance{
    static ToolsObject *toolOj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toolOj = [[ToolsObject alloc] init];
    });

    return toolOj;
}

+ (void)shareSDK_alertWithImageUrl:(NSString *)imageUrl shareTitle:(NSString *)title  shareContent:(NSString *)Content shareUrl:(NSString *)url withType:(int)shareType
{
//    if (shareType == 22 || shareType == 23) {
//
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
//
//        }else{
//            //判断是否有微信
//            NSLog(@"没有微信");
//            [ToolsObject showMessageTitle:@"您未安装微信客户端" andDelay:1.0 andImage:nil];
//
//            return;
//        }
//
////        if (![WXApi isWXAppInstalled]) {
////            //判断是否有微信
////            NSLog(@"没有微信");
////            [ToolsObject showMessageTitle:@"您未安装微信客户端" andDelay:1.0 andImage:nil];
////
////            return;
////        }
//    }
//
//     if (shareType == 24  || shareType == 6) {
//         if (![QQApiInterface isQQInstalled]) {
//             //判断是否有qq
//             NSLog(@"有qq");
//             [ToolsObject showMessageTitle:@"您未安装QQ客户端" andDelay:1.0 andImage:nil];
//             return;
//         }
//
//     }
//
//    NSArray* imageArray = @[SHARE_IMAGE_ICON];
//    if (imageUrl.length != 0) {
//        imageArray = @[imageUrl];
//    }
//
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:Content
//                                     images:imageArray //传入要分享的图片
//                                        url:[NSURL URLWithString:url]
//                                      title:title
//                                       type:SSDKContentTypeAuto];
//    SSDKPlatformType platformType;
//    if (shareType == 22) {
////         微信平台-好友
//        platformType = SSDKPlatformSubTypeWechatSession;
//
//    }else if (shareType == 23) {
//         platformType = SSDKPlatformSubTypeWechatTimeline;
//
//    }else if (shareType == 24) {
//        platformType = SSDKPlatformSubTypeQQFriend;
//    }else if (shareType == 6) {
//        platformType = SSDKPlatformSubTypeQZone;
//    }
//
//
//
//
//    //进行分享
//    [ShareSDK share:platformType //传入分享的平台类型
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
//
//         switch (state) {
//             case SSDKResponseStateSuccess:
//             {
//
//                 break;
//             }
//             case SSDKResponseStateFail:
//             {
//
//                 [self showMessageTitle:@"分享失败" andDelay:1.0 andImage:nil];
//                 break;
//             }
//             case SSDKResponseStateCancel:
//             {
//
//                 break;
//             }
//             default:
//                 break;
//         }
//     }];
//
}
+ (void)shareToProgram_alertWithImageUrl:(NSString *)imageUrl shareTitle:(NSString *)title  shareContent:(NSString *)Content shareUrl:(NSString *)url withType:(int)shareType {
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    // 平台参数定制
//    // webpageUrl: 6.5.6以下版本微信会自动转化为分享链接(必填)
//    // path: 点击分享卡片时打开微信小程序的页面路径,关于该字段的详细说明见下文
//    // thumbImage: 分享卡片展示的缩略图
//    // withShareTicket: 是否携带shareTicket
//    // miniProgramType: 分享的小程序版本（0-正式，1-开发，2-体验）
//    // forPlatformSubType: 分享自平台 微信小程序暂只支持 SSDKPlatformSubTypeWechatSession（微信好友分享)
//
////    [parameters SSDKSetupWeChatMiniProgramShareParamsByTitle:title
////                                                 description:Content
////                                                  webpageUrl:[NSURL URLWithString:url]
////                                                        path:@"pages/index/index"
////                                                  thumbImage:SHARE_IMAGE_ICON
////                                                    userName:@"微信小程序的原始ID"
////                                             withShareTicket:YES
////                                             miniProgramType:2
////                                          forPlatformSubType:SSDKPlatformSubTypeWechatSession];
////    [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:parameters onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
////        switch (state)
////        {
////            case SSDKResponseStateSuccess:
//////                [self showAlertWithMessage:@"分享成功！"];
////                break;
////            case SSDKResponseStateFail:
//////                [self showAlertWithMessage:@"分享失败！"];
////                break;
////
////            default:
////                break;
////        }
////    }];
}

#pragma mark 保存用户数据
+ (void)savaUserData:(NSDictionary *)dataDic
{
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    NSArray *keyArr = dataDic.allKeys;
    for (int i = 0; i < keyArr.count; i ++) {
        NSString *keyStr = [keyArr objectAtIndex:i];
        NSString *valueStr = checkNull([dataDic objectForKey:keyStr]);
        [tempDict setValue:valueStr forKey:keyStr];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:tempDict forKey:@"userData"];
}

#pragma mark 删除用户数据
+ (void)deleteUserData:(NSDictionary *)dataDic
{
   [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"myToken"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userData"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userDataDetail"];
}

//保存用户定位数据
+ (void)savaUserLocationWithProvince:(NSString *)provinceStr withCity:(NSString *)cityStr withDistrict:(NSString *)districtStr withCityID:(NSString *)cityID withType:(NSString *)typeStr withAresID:(NSString *)areaIDStr
{
    NSDictionary *tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             provinceStr,@"province",
                             cityStr,@"city",
                             districtStr,@"district",
                             cityID,@"cityId",
                             typeStr,@"type",
                             areaIDStr,@"areaId",
                             nil];
    [[NSUserDefaults standardUserDefaults] setObject:tempDic forKey:@"userLocation"];
}
#pragma mark 获取用户定位数据
+ (NSString *)getUserLocationinfo
{
    NSString *locationIndoStr;
    
    NSDictionary *tempDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLocation"];
    
//    [[[NSUserDefaults standardUserDefaults] objectForKey:@"userLocation"] objectForKey:@"city"]
    
    if ([[tempDic objectForKey:@"district"] length] != 0) {
        return [tempDic objectForKey:@"district"];
    }
    
    if ([[tempDic objectForKey:@"city"] length] != 0) {
        return [tempDic objectForKey:@"city"];
    }

    return locationIndoStr;
}
+ (NSDictionary *)getUserLocationDic
{
     NSDictionary *tempDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLocation"];
    
    return [tempDic mutableCopy];
}

//获取设备udid
+ (NSString *)getUDIDStr
{
//    ////设备唯一标识符
//    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSLog(@"设备唯一标识符:%@",identifierStr);
//    //手机别名： 用户定义的名称
//    NSString* userPhoneName = [[UIDevice currentDevice] name];
//    NSLog(@"手机别名: %@", userPhoneName);
//    //设备名称
//    NSString* deviceName = [[UIDevice currentDevice] systemName];
//    NSLog(@"设备名称: %@",deviceName );
//    //手机系统版本
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"手机系统版本: %@", phoneVersion);
//    //手机型号
//    NSString * phoneModel =  [self deviceVersion];
//    NSLog(@"手机型号:%@",phoneModel);
//    //地方型号  （国际化区域名称）
//    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
//    NSLog(@"国际化区域名称: %@",localPhoneModel );
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    // 当前应用软件版本  比如：1.0.1
//    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"当前应用软件版本:%@",appCurVersion);
//    // 当前应用版本号码   int类型
//    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
//    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//    NSLog(@"物理尺寸:%.0f × %.0f",width,height);
//    CGFloat scale_screen = [UIScreen mainScreen].scale;
//    NSLog(@"分辨率是:%.0f × %.0f",width*scale_screen ,height*scale_screen);
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    CTCarrier *carrier = info.subscriberCellularProvider;
//    NSLog(@"运营商:%@", carrier.carrierName);
    
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    advertisingId = [advertisingId stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return advertisingId;
}

//iphone型号
+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    //iPhone
//    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
//    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
//    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
//    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
//    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
//    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
//    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
//    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
//    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
//    if ([deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
//    if ([deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
//    if ([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
//    if ([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
//    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    　return deviceString;
}


+ (BOOL)foldActivityListWithID:(NSString *)idStr withActivityArrat:(NSArray *)array{
    BOOL shouldFold = NO;
    for (int i = 0; i < array.count; i ++) {
        NSString *tempIdStr = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
//        NSString *temp2IdStr = [NSString stringWithFormat:@"%@",idStr];
//        NSLog(@"tempIdStr.length == === == = = %lu",(unsigned long)tempIdStr.length);
//        NSLog(@"idStr.length == === == = = %lu",(unsigned long)idStr.length);
        if ([tempIdStr intValue] == [idStr intValue]) {
            shouldFold = YES;
            return shouldFold;
        }
    }
    
    return shouldFold;
}

+ (float)listHeightWithArray:(NSArray *)array withShowAllBool:(BOOL)showAll{
    if (array.count == 0) {
        return 0;
    }
    
    int x = 1;
    if (showAll == YES) {
            x = (int)array.count;
    }
    float _listHeight = 0;
    for (int i = 0; i < x; i ++) {
        
         NSString *tempTitleStr = [NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] objectForKey:@"ActivityTheme"],[[array objectAtIndex:i] objectForKey:@"ActivityTitle"]];
       
        CGSize titleSize;
        if (array.count == 1) {
            titleSize = [ToolsObject getText:tempTitleStr withTextSize:CGSizeMake(ScreenWidth-124-80, 200) withTextFont:12];
        }else{
            if (i == 0) {
                titleSize = [ToolsObject getText:tempTitleStr withTextSize:CGSizeMake(ScreenWidth-124-80, 200) withTextFont:12];
            }else{
                titleSize = [ToolsObject getText:tempTitleStr withTextSize:CGSizeMake(ScreenWidth-124-20, 200) withTextFont:12];
            }
            
        }
        
        float height = 40+titleSize.height;
        if (titleSize.height<20) {
            height = 40+20;
        }
        _listHeight = _listHeight + height;
    }
    
    return _listHeight;
}

+ (float)detailHeightWithArray:(NSArray *)array withShowAllBool:(BOOL)showAll{
    int x = 1;
    if (showAll == YES) {
        x = (int)array.count;
    }
    float _listHeight = 0;
    for (int i = 0; i < x; i ++) {
        
        NSString *tempTitleStr = [NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] objectForKey:@"ActivityTheme"],[[array objectAtIndex:i] objectForKey:@"ActivityTitle"]];
        
        CGSize titleSize;
        
        titleSize = [ToolsObject getText:tempTitleStr withTextSize:CGSizeMake(ScreenWidth-20-60, 200) withTextFont:12];
        
        float height = 40+titleSize.height;
        if (titleSize.height<20) {
            height = 40+20;
        }
        _listHeight = _listHeight + height;
    }
    
    return _listHeight;
}

+ (int)baiDuMapType:(NSString *)string{
    int type = 1;
    
    if (string.length == 0) {
        return 1;
    }
    
    if ([string rangeOfString:@">"].location == NSNotFound) {
        NSLog(@"string 不存在 >");
    }else{
        
        return 3;
    }
    
    if ([string rangeOfString:@"km"].location == NSNotFound) {
         NSLog(@"string 不存在 km");
        return 1;
        
    }else{
         NSLog(@"string 包含 m");
        string = [string stringByReplacingOccurrencesOfString:@"km" withString:@""];
        if ([string doubleValue] >= 1 && [string doubleValue] < 5) {
            return 3;
        }else if ([string doubleValue] >= 5) {
            return 3;
        }
        
       
    }
    
    
    
    return type;
}








+ (NSString *)x_tokenJoint:(NSDictionary *)jointDic andPrivateKeys:(NSString *)privateKey
{
    int i = 0;
    NSString *jointStr = [[NSString alloc] init];
    NSArray *keys = [jointDic allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (NSString *categoryId in sortedArray) {
        NSLog(@"[dict objectForKey:categoryId] ===%@",[jointDic objectForKey:categoryId]);
        
        if (i == 0) {
            jointStr = [NSString stringWithFormat:@"%@=%@",categoryId,[jointDic objectForKey:categoryId]];
        }else{
            jointStr = [NSString stringWithFormat:@"%@&%@=%@",jointStr,categoryId,[jointDic objectForKey:categoryId]];
        }
        
        i ++;
    }
    privateKey = companyKey;
    jointStr = [NSString stringWithFormat:@"%@&key=%@",jointStr,privateKey];
    
    //去空格
    jointStr = [jointStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    jointStr = [self md5:jointStr];
    
    NSLog(@"jointStr ===  %@",jointStr);
    
   
    return jointStr;
}

+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (CGSize)getText:(NSString *)textStr withTextSize:(CGSize)size withTextFont:(CGFloat)textFont
{
    if (textStr.length == 0) {
        return CGSizeMake(0, 0);
    }
    CGSize mySize = [textStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil].size;
    
    return mySize;
}


#pragma mark leftImage:左侧图片 rightImage:右侧图片 margin:两者间隔
+ (UIImage *) combineWithLeftImg:(UIImage*)leftImage rightImg:(UIImage*)rightImage withMargin:(NSInteger)margin
{
    if (rightImage == nil) {
        return leftImage;
    }
    CGFloat width = leftImage.size.width + rightImage.size.width + margin;
    CGFloat height = leftImage.size.height;
    CGSize offScreenSize = CGSizeMake(width, height);
    
     UIGraphicsBeginImageContext(offScreenSize);//用这个重绘图片会模糊
//    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, [UIScreen mainScreen].scale);
    
    CGRect rectL = CGRectMake(0, 0, leftImage.size.width, height);
    [leftImage drawInRect:rectL];
    
    CGRect rectR = CGRectMake(rectL.origin.x + leftImage.size.width + margin, 0, rightImage.size.width, height);
    [rightImage drawInRect:rectR];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imagez;
}

+ (void)SVProgressHUDShowStatus:(NSString *)statusStr WithMask:(BOOL)showMask
{
//    [SVProgressHUD dismiss];
    
    /**
     *  设置HUD背景图层的样式
     *
     *  SVProgressHUDMaskTypeNone：默认图层样式，当HUD显示的时候，允许用户交互。
     *
     *  SVProgressHUDMaskTypeClear：当HUD显示的时候，不允许用户交互。
     *
     *  SVProgressHUDMaskTypeBlack：当HUD显示的时候，不允许用户交互，且显示黑色背景图层。
     *
     *  SVProgressHUDMaskTypeGradient：当HUD显示的时候，不允许用户交互，且显示渐变的背景图层。
     *
     *  SVProgressHUDMaskTypeCustom：当HUD显示的时候，不允许用户交互，且 显示背景图层自定义的颜色。
     */
    
    if (SVProgressHUD.isVisible == YES) {
        [SVProgressHUD dismiss];
    }

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];//设置HUD的Style
    [SVProgressHUD dismissWithDelay:10.0];
//    [SVProgressHUD setForegroundColor:[UIColor clearColor]];//设置HUD和文本的颜色
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];//设置HUD的背景颜色
    
//    if (SVProgressHUD.isVisible == YES) {
//        [SVProgressHUD dismiss];
//    }
    
    if ([statusStr isEqualToString:@""] || statusStr == nil) {
        [SVProgressHUD show];
    }else{
        [SVProgressHUD showWithStatus:statusStr];
    }
    
    
    
    if (showMask == YES) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
}

//警告
+ (void)SVProgressHUDShowStatus_waring:(NSString *)statusStr WithMask:(BOOL)showMask
{
   
    
    if (SVProgressHUD.isVisible == YES) {
        [SVProgressHUD dismiss];
    }
   
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];//设置HUD的Style
    [SVProgressHUD dismissWithDelay:10.0];
    //    [SVProgressHUD setForegroundColor:[UIColor clearColor]];//设置HUD和文本的颜色
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];//设置HUD的背景颜色
    
    //    if (SVProgressHUD.isVisible == YES) {
    //        [SVProgressHUD dismiss];
    //    }
    
    if ([statusStr isEqualToString:@""] || statusStr == nil) {
        [SVProgressHUD show];
    }else{
        [SVProgressHUD showInfoWithStatus:statusStr];
    }
    
    
    
    if (showMask == YES) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
}

+ (void)SVProgressHUDDismiss
{
    [SVProgressHUD dismiss];
}
+ (BOOL)HUDDismissType {
//    if (SVProgressHUD.isVisible == YES) {
//        [SVProgressHUD dismiss];
//    }
    
    return SVProgressHUD.isVisible;
}

/**
 *  正则表达式验证手机号
 *
 *  @param mobile 传入手机号
 *
 *  @return
 */
+ (BOOL)validateMobile:(NSString *)mobile
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,175,176,177,178
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/**
     *iOS 正则表达式
     *不能全部为数字
     *不能全部为字母
     *必须包含字母和数字
     *6-16位
*/
+ (NSString *)validateUserName:(NSString *)password
{
    //6-16位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:password]) {
        return @"正确";
    }else
        return @"请输入6-20位数字字母组合用户名";
}

+ (NSString *)validatePassword:(NSString *)password
{
    //6-16位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,25}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:password]) {
        return @"正确";
    }else
        return @"请输入8-25位字符密码";
}

+ (BOOL)checkEmail:(NSString *)email{
    
    //^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w{2,3}){1,3})$
    
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:email];
    
}

//获取当前时间戳 （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}
//获取当前时间戳有两种方法(以秒为单位)
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}

#pragma mark 创建一个Base64编码的NSString对象
+ (NSString *)dataWitbBase64ToStrimg:(NSData *)data
{
    // Create NSData object
    NSData *nsdata = data;
    
    // Get NSString from NSData object in Base64
//    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    
    
    return base64Encoded;
}


+ (void)gradientView:(UIImageView *)view withStartColor:(CGColorRef)startColor withEndColor:(CGColorRef)endColor withCGRect:(CGRect)rect
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor, (__bridge id)endColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = rect;
    [view.layer addSublayer:gradientLayer];
    
    
}

+ (void)showUnSuccess:(UIView *)view withRect:(CGRect)rect
{
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app.remindView removeFromSuperview];
//    app.remindView = [[[NSBundle mainBundle] loadNibNamed:@"RemindView_unSuccess" owner:self options:nil] lastObject];
//    [app.remindView setFrame:rect];
//    [view addSubview:app.remindView];
}

+ (void)showError500:(UIView *)view withRect:(CGRect)rect
{
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app.remindView removeFromSuperview];
//    app.remindView = [[[NSBundle mainBundle] loadNibNamed:@"RemindView_500" owner:self options:nil] lastObject];
//    [app.remindView setFrame:rect];
//    [view addSubview:app.remindView];
}

+ (void)showSuccessNoData:(UIView *)view withRect:(CGRect)rect
{
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app.remindView removeFromSuperview];
//    app.remindView = [[[NSBundle mainBundle] loadNibNamed:@"RemindView_success_noData" owner:self options:nil] lastObject];
//    app.remindView.noDataBtn.hidden = YES;
//    [app.remindView setFrame:rect];
//    [view addSubview:app.remindView];
}

+ (void)showNoNet:(UIView *)view withRect:(CGRect)rect
{
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app.remindView removeFromSuperview];
//    app.remindView = [[[NSBundle mainBundle] loadNibNamed:@"RemindView_noNet" owner:self options:nil] lastObject];
//    [app.remindView setFrame:rect];
//    [view addSubview:app.remindView];
}

+ (void)removeRemindView
{
////    RemindView *_remindView = [[RemindView alloc] init];
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app.remindView removeFromSuperview];
}

#pragma mark 加密数据
+ (id) encryptProcessDictionaryIsNSNull:(id)obj{
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:@"" forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                [dt setObject:[AESUtility EncryptString:strobj] forKey:key];
            }
            else if ([object isKindOfClass:[NSNumber class]]){
                NSString *strobj = [NSString stringWithFormat:@"%@",object];
                [dt setObject:[AESUtility EncryptString:strobj] forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                [dt setObject:[AESUtility EncryptString:strobj] forKey:key];
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self encryptProcessDictionaryIsNSNull:da];
                [dt setObject:da forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self encryptProcessDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self encryptProcessDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

#pragma mark 解密数据
+ (id) decryptProcessDictionaryIsNSNull:(id)obj{
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:@"" forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                [dt setObject:[AESUtility DecryptString:strobj] forKey:key];
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self decryptProcessDictionaryIsNSNull:da];
                [dt setObject:da forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self decryptProcessDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self decryptProcessDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

#pragma mark 获取当前的时间
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

#pragma mark NSString转NSData
+ (NSString *)stringToJsonData:(NSDictionary *)dict
{
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

#pragma mark 去除null
+ (id) processDictionaryIsNSNull:(id)obj{
    const NSString *blank = @"";
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"] || [strobj isEqualToString:@"(null)"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

#pragma mark 设置状态栏颜色
+ (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark 如果想要判断设备是ipad，要用如下方法
+ (BOOL)getIsIpad
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}

#pragma mark MBProgressHUD提示封装
+ (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt andImage:(NSString *)imageStr{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    hud.userInteractionEnabled = YES;
    
    hud.backgroundColor = [UIColor clearColor];
    
    hud.animationType = MBProgressHUDAnimationZoomOut;
    
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    
    hud.detailsLabel.text = title;
    
    hud.square = NO;
    
    hud.mode = MBProgressHUDModeCustomView;
    

    if (imageStr == nil || [imageStr length] == 0) {
        
    }else{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        imageView.image = [UIImage imageNamed:imageStr];
        
        hud.customView = imageView;
    }
    
    [hud hideAnimated:YES afterDelay:timeInt];
    //    [hud hide:YES afterDelay:timeInt];
    
}

#pragma mark 判断全汉字
+ (BOOL)inputShouldChinese:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

#pragma mark 判断全数字：
+ (BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

#pragma mark 判断全字母：
+ (BOOL)inputShouldLetter:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

#pragma mark 判断仅输入字母或数字：
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

#pragma mark 判断仅输入字母和数字：
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6 && [pass length] <= 16){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

#pragma mark 判断是否为邮箱
+ (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}


 + (NSString *)internetStatus {
    
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"WIFI";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"WIFI";
            break;
            
        case ReachableViaWWAN:
            net = @"蜂窝数据";
            net = [self getNetType ];   //判断具体类型
            break;
            
        case NotReachable:
            net = @"无";//@"当前无网路连接";
            
        default:
            break;
    }
    
    return net;
}
+ (NSString *)getNetType
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    NSString *netconnType;
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
        netconnType = @"GPRS";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        netconnType = @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
        netconnType = @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
        netconnType = @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
        netconnType = @"2G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
        netconnType = @"HRPD";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
        netconnType = @"4G";
    }
    
    return netconnType;
}

#pragma mark 计算动态高度
+ (CGSize)getStringRect:(NSString *)aString width:(CGFloat)width fonts:(float)myFont height:(CGFloat)height lineSpacing:(float)lineSpacingFloat {
    if (aString.length == 0) {
        return CGSizeMake(0, 0);
    }
    
    CGSize size = CGSizeZero;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aString];
    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    NSRange range = NSMakeRange(0, atrString.length); //获取指定位置上的属性信息，并返回与指定位置属性相同并且连续的字符串的范围信息。
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range]; //不存在段落属性，则存入默认值
    NSMutableParagraphStyle *paragraphStyle = dic[NSParagraphStyleAttributeName];
    if (!paragraphStyle || nil == paragraphStyle) {
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.hyphenationFactor = 1.0;
        paragraphStyle.lineSpacing = 0;//增加行高//lineSpacingFloat
        paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
        paragraphStyle.tailIndent = 0;//相当于右padding
        paragraphStyle.lineHeightMultiple = 1.3;//行间距是多少倍
        paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
        paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
        paragraphStyle.paragraphSpacing = 0;//段落后面的间距
        paragraphStyle.paragraphSpacingBefore = 0;//段落之前的间距
        [atrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        
    }
    //设置默认字体属性
    UIFont *font = dic[NSFontAttributeName];
    if (!font || nil == font) {
        font = [UIFont systemFontOfSize:myFont];
        [atrString addAttribute:NSFontAttributeName value:font range:range];
        
    }
    NSMutableDictionary *attDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [attDic setObject:font forKey:NSFontAttributeName];
    [attDic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    CGSize strSize = [[attributedString string] boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attDic context:nil].size;
    size = CGSizeMake(CGFloat_ceil(strSize.width), CGFloat_ceil(strSize.height));
    
    
    return size;
    
    
    /*
     static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
     #if CGFLOAT_IS_DOUBLE
     return ceil(cgfloat);
     #else
     return ceilf(cgfloat);
     #endif
     }
     */
}

#pragma mark NSAttributedString文本
+ (NSAttributedString *)getStringWithRect:(NSString *)aString width:(CGFloat)width fonts:(float)myFont height:(CGFloat)height lineSpacing:(float)lineSpacingFloat {
    
    CGSize size = CGSizeZero;
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aString];
    
    if (aString.length == 0) {
        return attributedString;
    }
    
    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    NSRange range = NSMakeRange(0, atrString.length); //获取指定位置上的属性信息，并返回与指定位置属性相同并且连续的字符串的范围信息。
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range]; //不存在段落属性，则存入默认值
    NSMutableParagraphStyle *paragraphStyle = dic[NSParagraphStyleAttributeName];
    if (!paragraphStyle || nil == paragraphStyle) {
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.hyphenationFactor = 1.0;
        paragraphStyle.lineSpacing = 0;//增加行高//lineSpacingFloat
        paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
        paragraphStyle.tailIndent = 0;//相当于右padding
        paragraphStyle.lineHeightMultiple = 1.3;//行间距是多少倍
        paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
        paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
        paragraphStyle.paragraphSpacing = 0;//段落后面的间距
        paragraphStyle.paragraphSpacingBefore = 0;//段落之前的间距
        [atrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        
    }
    //设置默认字体属性
    UIFont *font = dic[NSFontAttributeName];
    if (!font || nil == font) {
        font = [UIFont systemFontOfSize:myFont];
        [atrString addAttribute:NSFontAttributeName value:font range:range];
        
    }
    NSMutableDictionary *attDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [attDic setObject:font forKey:NSFontAttributeName];
    [attDic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    CGSize strSize = [[attributedString string] boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attDic context:nil].size;
    size = CGSizeMake(CGFloat_ceil(strSize.width), CGFloat_ceil(strSize.height));
    
    return atrString;
    
    
    
    /*
     static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
     #if CGFLOAT_IS_DOUBLE
     return ceil(cgfloat);
     #else
     return ceilf(cgfloat);
     #endif
     }
     */
}

#pragma mark NSAttributedString文本,可修改行间距
+ (NSAttributedString *)getStringWithRect:(NSString *)aString width:(CGFloat)width fonts:(float)myFont height:(CGFloat)height lineHeight:(float)lineHeightFloat {
    
    CGSize size = CGSizeZero;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aString];
    
    if (aString.length == 0) {
        return attributedString;
    }
    
    NSMutableAttributedString *atrString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    NSRange range = NSMakeRange(0, atrString.length); //获取指定位置上的属性信息，并返回与指定位置属性相同并且连续的字符串的范围信息。
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range]; //不存在段落属性，则存入默认值
    NSMutableParagraphStyle *paragraphStyle = dic[NSParagraphStyleAttributeName];
    if (!paragraphStyle || nil == paragraphStyle) {
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.hyphenationFactor = 1.0;
        paragraphStyle.lineSpacing = 0;//增加行高//lineSpacingFloat
        paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
        paragraphStyle.tailIndent = 0;//相当于右padding
        paragraphStyle.lineHeightMultiple = lineHeightFloat;//行间距是多少倍
        paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
        paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
        paragraphStyle.paragraphSpacing = 0;//段落后面的间距
        paragraphStyle.paragraphSpacingBefore = 0;//段落之前的间距
        [atrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        
    }
    //设置默认字体属性
    UIFont *font = dic[NSFontAttributeName];
    if (!font || nil == font) {
        font = [UIFont systemFontOfSize:myFont];
        [atrString addAttribute:NSFontAttributeName value:font range:range];
        
    }
    NSMutableDictionary *attDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [attDic setObject:font forKey:NSFontAttributeName];
    [attDic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    CGSize strSize = [[attributedString string] boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attDic context:nil].size;
    size = CGSizeMake(CGFloat_ceil(strSize.width), CGFloat_ceil(strSize.height));
    
    return atrString;
    
    
    
    /*
     static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
     #if CGFLOAT_IS_DOUBLE
     return ceil(cgfloat);
     #else
     return ceilf(cgfloat);
     #endif
     }
     */
}

#pragma mark 生成一张纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return theImage;
    
}

#pragma mark 渐变色
+ (void)gradientColor:(UIView *)view startColor:(NSString *)startColor endColor:(NSString *)endColor {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[UIColor colorWithHexString:startColor].CGColor,(id)[UIColor  colorWithHexString:endColor].CGColor];
    gradient.startPoint = CGPointMake(0.5, 0);//0，0）为左上角、（1，0）为右上角、（0，1）为左下角、（1，1）为右下角，默认是值是（0.5，0）和（0.5，1）
    gradient.endPoint = CGPointMake(0.5, 1);
//        gradient.locations = @[@(0.5f), @(1.0f)];//控制渐变发生的位置
    [view.layer addSublayer:gradient];
}

//在第 n 位 插入新的字符串
+ (NSString *)insertString:(NSString *)insertStr fromString:(NSString *)fromStr withInsertIndex:(int)index {
    
    NSMutableString  *a = [[NSMutableString alloc ] initWithString:fromStr];
    
    NSLog(@"\n a: %@",a);
    
    [a insertString:insertStr  atIndex:index];
    
    NSLog(@"\n a: %@",a);
    
    return a;
    
}

//使用UIImageView实现加载GIF图片
+ (void)playGIFWithNameL:(NSString *)gifName playTime:(int)time showImageView:(UIImageView *)imageView{
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifName withExtension:@"gif"];//加载GIF图片
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);//将GIF图片转换成对应的图片源
    
    size_t frameCout=CGImageSourceGetCount(gifSource);//获取其中图片源个数，即由多少帧图片组成
    
    NSMutableArray* frames=[[NSMutableArray alloc] init];//定义数组存储拆分出来的图片
    
    
    
    for (size_t i=0; i<frameCout; i++) {
        
        CGImageRef imageRef=CGImageSourceCreateImageAtIndex(gifSource, i, NULL);//从GIF图片中取出源图片
        
        UIImage* imageName=[UIImage imageWithCGImage:imageRef];//将图片源转换成UIimageView能使用的图片源
        
        [frames addObject:imageName];//将图片加入数组中
        
        CGImageRelease(imageRef);
        
    }
    
    CFRelease(gifSource);
    
    //         UIImageView* imageview=[[UIImageView alloc] initWithFrame:CGRectMake(20, 64, 40, 40)];
    
    imageView.animationImages=frames;//将图片数组加入UIImageView动画数组中
    
    imageView.animationDuration=time;//每次动画时长
    
    [imageView startAnimating];//开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
        //animationRepeatCount：可设置动画执行的次数
}


//#pragma mark 半圆角
//- (void)buttonrounder {
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_searchButton.bounds      byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight    cornerRadii:CGSizeMake(8, 8)];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//
//    maskLayer.frame = _searchButton.bounds;
//
//    maskLayer.path = maskPath.CGPath;
//
//    _searchButton.layer.mask = maskLayer;
//
//}

@end
