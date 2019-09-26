//
//  POSCollectionViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface POSCollectionViewController : UIViewController





@property (weak, nonatomic) IBOutlet UIImageView *stateBGImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;



@property (weak, nonatomic) IBOutlet UIImageView *toolsImageView;
@property (weak, nonatomic) IBOutlet UILabel *toolsNameLabel;



@property (nonatomic) int processTag;//支付流程
@property (retain, nonatomic) NSString *moneyString;

@end

NS_ASSUME_NONNULL_END
