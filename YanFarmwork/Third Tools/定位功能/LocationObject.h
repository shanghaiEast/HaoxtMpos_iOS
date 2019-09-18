//
//  LocationObject.h
//  YanFarmwork
//
//  Created by HG on 2019/9/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BMKLocationKit/BMKLocationManager.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocation.h>


typedef void(^LocationMessageBlock)(NSArray *array);


NS_ASSUME_NONNULL_BEGIN

@interface LocationObject : NSObject <BMKLocationAuthDelegate>


@property (copy, nonatomic) LocationMessageBlock locationMessageBlock;



@property (retain, nonatomic) UIViewController *rootView;

@property (retain, nonatomic) BMKLocationManager *bmkLocationManager;

@property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;


+(instancetype)instance;

- (void)locationView:(UIViewController *)rootView;


@end

NS_ASSUME_NONNULL_END
