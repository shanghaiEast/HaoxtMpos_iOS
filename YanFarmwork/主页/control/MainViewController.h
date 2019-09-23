//
//  MainViewController.h
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController


@property (retain, nonatomic)  UITableView *myTableView;


- (void)checkLogin;

@end

NS_ASSUME_NONNULL_END
