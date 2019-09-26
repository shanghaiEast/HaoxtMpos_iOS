//
//  PayResultViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayResultViewController : UIViewController

@property (nonatomic) int resultTag;//结果展示页面,暂时无用; 


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)buttonCilck:(id)sender;




@property (nonatomic) int processTag;//支付流程
@property (nonatomic) int payWayTag;//传值，判断微信还是支付宝,0=支付宝,1=微信
@property (nonatomic,retain) NSString *scanString;//扫描的数据
@property (nonatomic,retain) NSString *moneyString;//支付金额


@end

NS_ASSUME_NONNULL_END
