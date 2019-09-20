//
//  CityChooseView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/20.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetProviceBlock)(NSDictionary *dict);
typedef void(^GetCityBlock)(NSDictionary *dict);


@interface CityChooseView : UIView

@property (copy, nonatomic) GetProviceBlock getProviceBlock;
@property (copy, nonatomic) GetCityBlock getCityBlock;



@property (retain, nonatomic) UIViewController *rootView;

@property (nonatomic) int showTag;//1--provice  ,2--city;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *BGView;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *whiteView;

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *myTableView;


@property (copy, nonatomic) NSDictionary *proviceDict;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
