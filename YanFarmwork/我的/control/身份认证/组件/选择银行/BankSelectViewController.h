//
//  BankSelectViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/20.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetHeadBankBlock)(NSDictionary *dict);
typedef void(^GetFootBankBlock)(NSDictionary *dict);

@interface BankSelectViewController : UIViewController

@property (copy, nonatomic) GetHeadBankBlock getHeadBankBlock;
@property (copy, nonatomic) GetFootBankBlock getFootBankBlock;




@property (retain, nonatomic)  UITableView *myTableView;

@property (nonatomic) int showTag;//1--headBank  ,2--footBank;
@property (retain, nonatomic) NSString *headBankName;
@property (retain, nonatomic) NSDictionary *headBankDict, *proviceDict, *cityDict;

@end

NS_ASSUME_NONNULL_END
