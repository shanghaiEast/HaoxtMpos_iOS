//
//  UIColor+WFHex.h
//  YiDingTongiOS
//
//  Created by apple  on 16/6/2.
//  Copyright © 2016年 YiDingTongiOS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) RGBA_COLOR(R, G, B, 1);


@interface UIColor (WFHex)

/*
 * 十六进制字符串获取颜色
 * @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/*
 * 十六进制字符串获取颜色
 * 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 * color : 十六进制字符串
 * alpha : 透明度
 * @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
