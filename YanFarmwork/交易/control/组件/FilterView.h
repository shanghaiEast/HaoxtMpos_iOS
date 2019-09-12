//
//  FilterView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^FiltrBolck)(NSDictionary *dict);


@interface FilterView : UIView

@property (copy, nonatomic) FiltrBolck filtrBolck;



- (IBAction)cancelOrConfirmBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *stateView;

@property (weak, nonatomic) IBOutlet UIView *typeView;

@property (weak, nonatomic) IBOutlet UITextField *minPrice;

@property (weak, nonatomic) IBOutlet UITextField *maxPrice;




- (void)createView;

@end

NS_ASSUME_NONNULL_END
