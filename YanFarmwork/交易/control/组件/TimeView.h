//
//  TimeView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^TimeBolck)(NSDictionary *dict);


@interface TimeView : UIView

@property (copy, nonatomic) TimeBolck timeBolck;


@property (weak, nonatomic) IBOutlet UIView *chooseTimeView;

@property (weak, nonatomic) IBOutlet UIView *dateView;


- (IBAction)cancelOrConfirmBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UIButton *leftTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightTimeBtn;
- (IBAction)timeBtnClick:(id)sender;







- (void)createView;

@end

NS_ASSUME_NONNULL_END
