//
//  QrCodeTableViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QrCodeTableViewController : UITableViewController

@property (nonatomic) int payWayTag;//传值，判断微信还是支付宝,0=支付宝,1=微信

@property (nonatomic) int processTag;//支付流程

@end

NS_ASSUME_NONNULL_END
