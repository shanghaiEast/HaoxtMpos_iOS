//
//  MyTabBar.h
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyTabBar;
//MyTabBar的代理必须实现addButtonClick，以响应中间“+”按钮的点击事件
@protocol MyTabBarDelegate <NSObject>
-(void)addButtonClick:(MyTabBar *)tabBar;
@end


@interface MyTabBar : UITabBar

@property (nonatomic,weak) id<MyTabBarDelegate> myTabBarDelegate;

@end

NS_ASSUME_NONNULL_END
