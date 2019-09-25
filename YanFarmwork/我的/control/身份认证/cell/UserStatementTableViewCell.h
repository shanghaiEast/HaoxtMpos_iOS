//
//  UserStatementTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserStatementTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *bankCardImageView;

@property (weak, nonatomic) IBOutlet UITextField *accountNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountNoTextField;

@property (weak, nonatomic) IBOutlet UIButton *headquartersBankBtn;
- (IBAction)headquartersBankBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *provinceAddresBtn;
- (IBAction)provinceBtnClick:(id)sender;

//@property (weak, nonatomic) IBOutlet UIButton *cityAddresBtn;
//- (IBAction)cityBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *branchBankBtn;
- (IBAction)branchBankBtnClick:(id)sender;

- (IBAction)nextBtnClick:(id)sender;





@property (retain, nonatomic) UIViewController *rootVC;
- (void)createHeaderView;

@end

NS_ASSUME_NONNULL_END
