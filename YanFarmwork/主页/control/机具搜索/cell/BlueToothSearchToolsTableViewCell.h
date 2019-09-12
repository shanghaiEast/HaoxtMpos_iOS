//
//  BlueToothSearchToolsTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlueToothSearchToolsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *toolsImageView;
@property (weak, nonatomic) IBOutlet UILabel *toolsNameLabel;


@property (retain, nonatomic) UIViewController *rootVC;
- (void)createCellView;

@end

NS_ASSUME_NONNULL_END
