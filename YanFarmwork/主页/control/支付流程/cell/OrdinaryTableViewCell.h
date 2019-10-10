//
//  OrdinaryTableViewCell.h
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

@interface OrdinaryTableViewCell : UITableViewCell

@property (copy, nonatomic) ChooseBankBlock chooseBankBlock;
@property (copy, nonatomic) PayWayBlock payWayBlock;
@property (copy, nonatomic) SaveMoneyBlock saveMoneyBlock;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *moneyNumber;

@property (weak, nonatomic) IBOutlet UIButton *chooseBankBtn;
- (IBAction)chooseBankClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtnClick:(id)sender;



@property (nonatomic) int payWayTag;
@property (nonatomic) int processTag;//支付流程
//@property (retain, nonatomic)

- (void)createView;

@end

NS_ASSUME_NONNULL_END
