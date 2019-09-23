//
//  ChangeDebitCardViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BankChangeSuccessBlock)(NSDictionary *cardDict);


@interface ChangeDebitCardViewController : UIViewController

@property (copy, nonatomic) BankChangeSuccessBlock bankChangeSuccessBlock;



@property (weak, nonatomic) IBOutlet UILabel *oldUserCardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldUserCardIDLabel;

@property (weak, nonatomic) IBOutlet UIButton *cardIdBtn;
- (IBAction)cardIdBtnClick:(id)sender;

- (IBAction)scanBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *openCardBankBtn;
- (IBAction)openCardBankBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *openCardAddressBtn;
- (IBAction)openCardAddressBtnClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *branchBankBtn;
- (IBAction)branckBankBtnClick:(id)sender;



- (IBAction)commitBtnClick:(id)sender;



@property (retain, nonatomic) NSDictionary *detailDict;


@end

NS_ASSUME_NONNULL_END
