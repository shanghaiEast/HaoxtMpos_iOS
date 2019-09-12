//
//  WxAndZfbTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ChooseBankBlock)(BOOL chooseBankBool);
typedef void(^PayWayBlock)(int payWaytag);
typedef void(^SaveMoneyBlock)(NSDictionary *dict);

NS_ASSUME_NONNULL_BEGIN

@interface WxAndZfbTableViewCell : UITableViewCell

@property (copy, nonatomic) ChooseBankBlock chooseBankBlock;
@property (copy, nonatomic) PayWayBlock payWayBlock;
@property (copy, nonatomic) SaveMoneyBlock saveMoneyBlock;

@property (nonatomic) int payWayTag;
//@property (retain, nonatomic)




@property (weak, nonatomic) IBOutlet UITextField *moneyNumber;

@property (weak, nonatomic) IBOutlet UIButton *chooseBankBtn;
- (IBAction)chooseBankClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *chooseZFBBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseWXBtn;
- (IBAction)payWayChooseClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtnClick:(id)sender;





- (void)createCell;

@end

NS_ASSUME_NONNULL_END
