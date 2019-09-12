//
//  BindToolsViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BindToolsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *toolsIDLabel;



- (IBAction)commitToolsBtnClick:(id)sender;




@property (retain, nonatomic)NSString *mySNString;


@end

NS_ASSUME_NONNULL_END
