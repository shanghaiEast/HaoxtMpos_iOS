//
//  UIImage+WFColorImage.h
//  YiDingTongiOS
//
//  Created by apple  on 16/6/19.
//  Copyright © 2016年 YiDingTongiOS.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WFColorImage)

+ (UIImage *)createImageWithColor:(UIColor *)color;
+(UIImage *)imageWithCaputureView:(UIView *)view;
@end
