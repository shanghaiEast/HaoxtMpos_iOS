//
//  TradingTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TradingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *payTypeLogoImageView;

@property (weak, nonatomic) IBOutlet UILabel *payStateLabel;

@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;



@end

NS_ASSUME_NONNULL_END
