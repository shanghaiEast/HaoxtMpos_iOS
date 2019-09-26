//
//  ToolsObject.h
//  HuaTongAPP
//
//  Created by huatong on 2017/10/20.
//  Copyright © 2017年 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsObject : NSObject


+(instancetype)instance;

//分享功能
+ (void)shareSDK_alertWithImageUrl:(NSString *)imageUrl shareTitle:(NSString *)title  shareContent:(NSString *)Content shareUrl:(NSString *)url withType:(int)shareType;
+ (void)shareToProgram_alertWithImageUrl:(NSString *)imageUrl shareTitle:(NSString *)title  shareContent:(NSString *)Content shareUrl:(NSString *)url withType:(int)shareType;

//保存用户数据
+ (void)savaUserData:(NSDictionary *)dataDic;
//删除用户数据
+ (void)deleteUserData;

//保存用户定位数据
+ (void)savaUserLocationWithProvince:(NSString *)provinceStr withCity:(NSString *)cityStr withDistrict:(NSString *)districtStr withCityID:(NSString *)cityID withType:(NSString *)typeStr withAresID:(NSString *)areaIDStr;
//获取用户定位数据
+ (NSString *)getUserLocationinfo;
+ (NSDictionary *)getUserLocationDic;

//获取设备udid
+ (NSString *)getUDIDStr;
//iphone型号
+ (NSString*)deviceVersion;

//判断是否展开列表
+ (BOOL)foldActivityListWithID:(NSString *)idStr withActivityArrat:(NSArray *)array;
//判断是否展开高度
+ (float)listHeightWithArray:(NSArray *)array withShowAllBool:(BOOL)showAll;

+ (float)detailHeightWithArray:(NSArray *)array withShowAllBool:(BOOL)showAll;

//百度步行、公交、驾车距离判断
+ (int)baiDuMapType:(NSString *)string;


//字符串拼接，加密用
+ (NSString *)x_tokenJoint:(NSDictionary *)jointDic andPrivateKeys:(NSString *)privateKey;


//MD5加密 32位 小写
+ (NSString *) md5: (NSString *) inPutText ;



#pragma mark 解密数据
+ (id) decryptProcessDictionaryIsNSNull:(id)obj;
#pragma mark 加密数据
+ (id) encryptProcessDictionaryIsNSNull:(id)obj;

//文字高度计算
+ (CGSize)getText:(NSString *)textStr withTextSize:(CGSize)size withTextFont:(CGFloat)textFont;

//leftImage:左侧图片 rightImage:右侧图片 margin:两者间隔
+ (UIImage *) combineWithLeftImg:(UIImage*)leftImage rightImg:(UIImage*)rightImage withMargin:(NSInteger)margin;

//SVProgressHUD展示  showMask展示蒙版
+ (void)SVProgressHUDShowStatus:(NSString *)statusStr WithMask:(BOOL)showMask;
//警告
+ (void)SVProgressHUDShowStatus_waring:(NSString *)statusStr WithMask:(BOOL)showMask;
+ (void)SVProgressHUDDismiss;
+ (BOOL)HUDDismissType;

//手机号码正则判断
+ (BOOL)validateMobile:(NSString *)mobile;

//用户名正则判断
+ (NSString *)validateUserName:(NSString *)password;

//密码正则判断
+ (NSString *)validatePassword:(NSString *)password;

// 判断邮箱
+ (BOOL)checkEmail:(NSString *)email;

//创建一个Base64编码的NSString对象
+ (NSString *)dataWitbBase64ToStrimg:(NSData *)data;

//获取当前的时间
+(NSString*)getCurrentTimes;

//NSString转NSData
+ (NSString *)stringToJsonData:(NSDictionary *)dict;

//去除null 方法一
+ (id) processDictionaryIsNSNull:(id)obj;

//去除null 方法二
+ (NSDictionary *) DictionaryIsNSNull:(NSDictionary *)responseObject;

+ (NSDictionary *)checkNull:(NSDictionary *)dict ;

//获取当前时间戳 （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3;

//获取当前时间戳有两种方法(以秒为单位)
+(NSString *)getNowTimeTimestamp;

//设置状态栏颜色
+ (void)setStatusBarBackgroundColor:(UIColor *)color;

//渐变色
+ (void)gradientView:(UIImageView *)view withStartColor:(CGColorRef)startColor withEndColor:(CGColorRef)endColor withCGRect:(CGRect)rect;

//数据错误回调
+ (void)showUnSuccess:(UIView *)view withRect:(CGRect)rect;
+ (void)showError500:(UIView *)view withRect:(CGRect)rect;
+ (void)showSuccessNoData:(UIView *)view withRect:(CGRect)rect;
+ (void)showNoNet:(UIView *)view withRect:(CGRect)rect;
+ (void)removeRemindView;

//如果想要判断设备是ipad，要用如下方法
+ (BOOL)getIsIpad;

//MBProgressHUD提示封装
+ (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt andImage:(NSString *)imageStr;


//判断全汉字
+ (BOOL)inputShouldChinese:(NSString *)inputString;

// 判断全数字：
+ (BOOL)inputShouldNumber:(NSString *)inputString;

//判断全字母：
+ (BOOL)inputShouldLetter:(NSString *)inputString;

// 判断仅输入字母或数字：
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString;

// 判断仅输入字母和数字：
+(BOOL)judgePassWordLegal:(NSString *)pass;

//判断是否为邮箱
+ (BOOL) validateEmail: (NSString *) candidate;

//iOS 判断当前网络状态
+ (NSString *)internetStatus;


#pragma mark 计算动态高度
+ (CGSize)getStringRect:(NSString *)aString width:(CGFloat)width fonts:(float)myFont height:(CGFloat)height lineSpacing:(float)lineSpacingFloat;

#pragma mark NSAttributedString文本
+ (NSAttributedString *)getStringWithRect:(NSString *)aString width:(CGFloat)width fonts:(float)myFont height:(CGFloat)height lineSpacing:(float)lineSpacingFloat;

#pragma mark NSAttributedString文本,可修改行间距
+ (NSAttributedString *)getStringWithRect:(NSString *)aString width:(CGFloat)width fonts:(float)myFont height:(CGFloat)height lineHeight:(float)lineHeightFloat;

#pragma mark 生成一张纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;


#pragma mark 渐变色
+ (void)gradientColor:(UIView *)view startColor:(NSString *)startColor endColor:(NSString *)endColor ;

#pragma mark 在第 n 位 插入新的字符串
+ (NSString *)insertString:(NSString *)insertStr fromString:(NSString *)fromStr withInsertIndex:(int)index;

#pragma mark 使用UIImageView实现加载GIF图片
+ (void)playGIFWithNameL:(NSString *)gifName playTime:(int)time showImageView:(UIImageView *)imageView;

#pragma mark  禁用侧滑返回手势
+ (void)disableTheSideslip:(UIViewController *)rootView;

#pragma mark iOS访问相册、相机权限
+ (void)getAuthorizationStatus:(void(^)(void))authorizedBlock;

#pragma mark 当编写代码时，不论是在TabbarController还是在Viewcontroller或者是NavagationController中任何一个页面写方法时，我们都可以使用以下方法获取程序正在展示的当前页
+ (UIViewController*) currentViewController;

#pragma mark UIButton实现左边文字,右边图片
+ (void)buttonImageRight:(UIButton *)button;

+ (NSDictionary *)modelToDictionary;

@end
