//
//  UserShopDetailTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserShopDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *accountNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountNoTextField;

@property (weak, nonatomic) IBOutlet UIButton *chooseIndustryBtn;
- (IBAction)chooseIndustryBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *chooseAreaBtn;
- (IBAction)chooseAreaBtnClick:(id)sender;



- (IBAction)nextBtnClick:(id)sender;


@property (retain, nonatomic) UIViewController *rootVC;
- (void)createHeaderView;

@end

NS_ASSUME_NONNULL_END
