//
//  SignatureView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDDrawView.h"


NS_ASSUME_NONNULL_BEGIN

@interface SignatureView : UIView



@property (weak, nonatomic) IBOutlet UIView *editView;



@property(nonatomic,strong) SDDrawView *drawView;




@property (retain, nonatomic) UIViewController *rootVC;


@property (weak, nonatomic) IBOutlet UIView *signView;



- (IBAction)buttonClick:(id)sender;



@property (nonatomic) int processTag;//支付流程
@property (nonatomic) int payWayTag;//传值，判断微信还是支付宝,0=支付宝,1=微信
@property (nonatomic,retain) NSString *scanString;//扫描的数据
@property (nonatomic,retain) NSString *moneyString;//支付金额
@property (nonatomic,retain) NSDictionary *detailDict;//支付数据
- (void)createView;



@end

NS_ASSUME_NONNULL_END
