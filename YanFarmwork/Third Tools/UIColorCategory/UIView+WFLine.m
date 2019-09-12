//
//  UIView+WFLine.m
//  YiDingTongiOS
//
//  Created by 周军 on 16/7/14.
//  Copyright © 2016年 YiDingTongiOS.com. All rights reserved.
//

#import "UIView+WFLine.h"

@implementation UIView (WFLine)

+ (UIView *)createLineViewWith:(CGRect)rect color:(UIColor *)color
{
    UIView *view = [[UIView alloc] init];
    view.frame = rect;
    view.backgroundColor = color;
    return view;
}

@end
