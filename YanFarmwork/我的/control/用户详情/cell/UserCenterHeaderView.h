//
//  UserCenterHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCenterHeaderView : UIView


- (IBAction)popBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;




@property (retain, nonatomic) UIViewController *rootVC;
- (void)createHeaderView;

@end

NS_ASSUME_NONNULL_END
