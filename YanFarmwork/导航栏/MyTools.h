//
//  MyTools.h
//  Parking
//
//  Created by 逸动 on 2017/8/22.
//  Copyright © 2017年 yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MyTools : NSObject

/**
 navigationController 地区页面的UINavigationController；
 BarColor             导航栏颜色；
 itemString           导航栏标题；
 itemColor            导航栏标题颜色；
 image                返回按钮图片；
 **/

+ (void)setViewController:(UIViewController *)viewController withNavigationBarColor:(UIColor *)BarColor andItem:(NSString *)itemString itemColor:(UIColor *)itemColor haveBackBtn:(BOOL)haveBtn withBackImage:(UIImage *)image withBackClickTarget:(id)target BackClickAction:(SEL)action;



/**
 imageUrl             图片链接地址；
 newSize              图需裁剪尺寸；
 **/
+ (UIImage *)imageWithImageString:(NSString *)imageUrl scaledToSize:(CGSize)newSize;


@end
