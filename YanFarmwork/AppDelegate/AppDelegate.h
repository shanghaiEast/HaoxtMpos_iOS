//
//  AppDelegate.h
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>



//#import <IQKeyboardManager/IQKeyboardManager.h>


#import "MyTabBarController.h"

#import "MainViewController.h"
#import "TradingViewController.h"
#import "PersonCenterViewController.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (retain, nonatomic) IQKeyboardManager *keyboardManager;

@property (retain, nonatomic) MyTabBarController *myTabBarC;
@property (retain, nonatomic) UITabBarController *tabBarC;

@property (retain, nonatomic) MainViewController *mainVC;
@property (retain, nonatomic) TradingViewController *tradinVC;
@property (retain, nonatomic) PersonCenterViewController *personCenterVC;

@end

