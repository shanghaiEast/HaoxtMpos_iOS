//
//  AreaPickerView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/25.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectProviceAndCityBlock)(NSDictionary *proviceDict, NSDictionary *cityDict);


@interface AreaPickerView : UIView

@property (copy, nonatomic) SelectProviceAndCityBlock selectProviceAndCityBlock;



@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)AddressBtnClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *showPickerView;


@property (nonatomic) int showTag;//1--provice  ,2--city;

- (void)createPickerView;

@end

NS_ASSUME_NONNULL_END
