//
//  SignOrderViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignOrderViewController : UIViewController

@property (nonatomic) int processTag;//支付流程

@property (retain, nonatomic)  UITableView *myTableView;

@end

NS_ASSUME_NONNULL_END
