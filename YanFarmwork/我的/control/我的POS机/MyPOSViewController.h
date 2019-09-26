//
//  MyPOSViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    
    CAN_EDIT       = 1,//可编辑状态
    CANT_EDIT      = 2,//不可编辑状态
    
} showType;

@interface MyPOSViewController : UIViewController

@property (nonatomic) int showType;

@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *SNLabel;




@end

NS_ASSUME_NONNULL_END
