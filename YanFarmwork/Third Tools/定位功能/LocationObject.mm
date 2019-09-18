//
//  LocationObject.m
//  YanFarmwork
//
//  Created by HG on 2019/9/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LocationObject.h"

#import <CoreLocation/CLLocationManager.h>


#import <BMKLocationKit/BMKLocationManager.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocation.h>


@interface LocationObject () <BMKLocationAuthDelegate, BMKLocationManagerDelegate, CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;

@end

@implementation LocationObject

+(instancetype)instance{
    static LocationObject *xTokenOj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xTokenOj = [[LocationObject alloc] init];
    });
    
    return xTokenOj;
}

- (instancetype)init{
    if (self = [super init]) {
       
    }
    
    return self;
}


- (void)locationView:(UIViewController *)rootView {
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"模拟器运行暂不开启定位");
#else
     
    [self checkLocationServicesAuthorizationStatus];
    
    _rootView = rootView;
    
    [self startBaiDuLocation];
    
#endif
    
  
    
    
}

- (void)startBaiDuLocation {
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:baiduKey authDelegate:self];
    
    //初始化实例
    _bmkLocationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _bmkLocationManager.delegate = self;
    //设置返回位置的坐标系类型
    _bmkLocationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _bmkLocationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _bmkLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _bmkLocationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _bmkLocationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    //_locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    _bmkLocationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _bmkLocationManager.reGeocodeTimeout = 10;
    
    [_bmkLocationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:self.completionBlock];
    
    typeof(self) wSelf = self;
    self.completionBlock = ^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {//得到定位信息，添加annotation
            
            if (location.location) {
//                NSLog(@"LOC = %@",location.location);
            }
            if (location.rgcData) {
//                NSLog(@"rgc = %@",[location.rgcData description]);
            }
            
            NSLog(@"%@",[NSString stringWithFormat:@"当前位置信息： \n经纬度：%.6f,%.6f \n地址信息：%@ \n网络状态：%d",location.location.coordinate.latitude, location.location.coordinate.longitude, [location.rgcData description], state]);
            
            NSArray *array = [[location.rgcData description] componentsSeparatedByString:@" | "]; //字符串按照 | 分隔成数组
//            NSLog(@"array=%@=",array); //结果是
            
            float latitudeFloat = location.location.coordinate.latitude;
            float longitudeFloat = location.location.coordinate.longitude;
            NSString *latitudeStr = [NSString stringWithFormat:@"%.6f",latitudeFloat];
            NSString *longitudeStr = [NSString stringWithFormat:@"%.6f",longitudeFloat];
            
            
            NSArray *tempArr = @[latitudeStr, longitudeStr, [array objectAtIndex:3], [array objectAtIndex:8], [array objectAtIndex:7]];//经纬度，省，市，区 //顺序
            
//             NSLog(@"tempArr = %@",tempArr);
            
            if (wSelf.locationMessageBlock) {
                wSelf.locationMessageBlock(tempArr);
            }
        }
        
    };
}

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error
{
    NSLog(@"error = %@",error);
}

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error {
    NSLog(@"error = %@",error);
}

/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"status = %d",status);
}

/**
 * @brief 该方法为BMKLocationManager所在App系统网络状态改变的回调事件。
 * @param manager 提供该定位结果的BMKLocationManager类的实例
 * @param state 当前网络状态
 * @param error 错误信息
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
     didUpdateNetworkState:(BMKLocationNetworkState)state orError:(NSError * _Nullable)error {
    NSLog(@"state = %d",state);
}






#pragma mark - 以下为系统方法--检查授权状态
- (void)checkLocationServicesAuthorizationStatus {
    
    [self reportLocationServicesAuthorizationStatus:[CLLocationManager authorizationStatus]];
}



- (void)reportLocationServicesAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusNotDetermined)
    {
        //未决定，继续请求授权
        [self requestLocationServicesAuthorization];
        
    }
    else if(status == kCLAuthorizationStatusRestricted)
    {
        //受限制，尝试提示然后进入设置页面进行处理（根据API说明一般不会返回该值）
        [self alertViewWithMessage];
        
    }
    else if(status == kCLAuthorizationStatusDenied)
    {
        //拒绝使用，提示是否进入设置页面进行修改
        [self alertViewWithMessage];
        
    }
    else if(status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        //授权使用，不做处理
        [self startBaiDuLocation];
    }
    else if(status == kCLAuthorizationStatusAuthorizedAlways)
    {
        //始终使用，不做处理
        
    }
    
}

#pragma mark - Helper methods


- (void)alertViewWithMessage {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请在系统设置中开启服务" delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"去设置", nil];
    [alter show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        //进入系统设置页面，APP本身的权限管理页面
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark - 获取授权

- (void)requestLocationServicesAuthorization
{
//    CLLocationManager的实例对象一定要保持生命周期的存活
    if (!self.locationManager) {
        self.locationManager  = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }

    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}
#pragma mark - CLLocationMangerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{

    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [self reportLocationServicesAuthorizationStatus:status];
}





@end
