//
//  SingOrderTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConfirmSignViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface SingOrderTableViewCell : UITableViewCell

@property (retain, nonatomic) UIViewController *rootVC;


@property (weak, nonatomic) IBOutlet UILabel *keyLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;






@property (nonatomic) int processTag;//支付流程
- (void)createView;

@end

NS_ASSUME_NONNULL_END
