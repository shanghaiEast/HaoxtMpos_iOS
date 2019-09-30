//
//  SignOrderViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignOrderViewController : UIViewController

@property (nonatomic) int processTag;//支付流程

@property (retain, nonatomic)  UITableView *myTableView;

@property (nonatomic,retain) NSDictionary *requestDict;//请求数据

@property (nonatomic,retain) NSString *testImageString;//测试图片base64

@end

NS_ASSUME_NONNULL_END
