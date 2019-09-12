//
//  LinesViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *remainingAmountLabel;


@property (weak, nonatomic) IBOutlet UILabel *otherCardDayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherCardSingleMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *ICCardDayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *ICCardSingleMoneyLabel;



@end

NS_ASSUME_NONNULL_END
