//
//  POSCollectionViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "POSCollectionViewController.h"

#import "SignOrderTableViewController.h"


#import "TianYuView.h"
#import <CoreBluetooth/CBPeripheral.h>


#import "LocationObject.h"



@interface POSCollectionViewController ()


@property (retain, nonatomic) NSString *deviceName;


@property (retain, nonatomic) NSMutableArray *blueArr;
@property (retain, nonatomic) TianYuView *tianYuView;

@end

@implementation POSCollectionViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"机具申领" itemColor:BLACKCOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [_stateBGImageView stopAnimating];
    
    [_tianYuView stopBlueLink];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [ToolsObject disableTheSideslip:self];
    
    _deviceName = @"MP46-000005";
    
    [self createView];
    [self createBooth];
   
    
}

- (void)createView {
//    [_stateBGImageView setImage:[UIImage imageNamed:@"searchTools.png"]];
    _stateLabel.text = @"请连接刷卡器";
    
    [ToolsObject playGIFWithNameL:@"searchTools" playTime:3 showImageView:_stateBGImageView];
    
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tradAgain)];
    _toolsNameLabel.userInteractionEnabled = YES;
    [_toolsNameLabel addGestureRecognizer:TapGesture];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        SignOrderTableViewController *signVC = [[SignOrderTableViewController alloc] initWithNibName:@"SignOrderTableViewController" bundle:nil];
//        signVC.hidesBottomBarWhenPushed = YES;
//        signVC.processTag = _processTag;
//        [self.navigationController pushViewController:signVC animated:YES];
//    });
 
}

- (void)tradAgain{
    [_tianYuView startTrading];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


///.........................天谕pos。。。。。。。。。。。。。。。。。。。
- (void)createBooth{
    if (_tianYuView == nil) {
        _blueArr = [[NSMutableArray alloc] init];
        
        _tianYuView = [[TianYuView alloc] init];
        [self.view addSubview:_tianYuView];
        [_tianYuView startTianYu];
    }
    typeof(self)wSelf = self;
    
    _tianYuView.connectedSearchBlock = ^(NSArray * _Nonnull array) {
        wSelf.blueArr = [array mutableCopy];
        for (int i = 0; i < wSelf.blueArr.count; i++) {
            CBPeripheral *device = [wSelf.blueArr objectAtIndex:i];
            if ([device.name isEqualToString:wSelf.deviceName]) {
                //有绑定的pos机
                [wSelf.tianYuView stopSearchPOS];
                [wSelf.tianYuView clickedIndexDict:device];
                
                break ;
            }
        }
    };
    _tianYuView.getMessageBlock = ^(CBPeripheral * _Nonnull myDevice, NSString * _Nonnull snString) {
        
        NSLog(@"myDevice:%@",myDevice);
        NSLog(@"snString:%@",snString);
        
        
        [wSelf.stateBGImageView stopAnimating];
        [wSelf.stateBGImageView setImage:[UIImage imageNamed:@"toolsCollection.png"]];
        wSelf.stateLabel.text = @"连接成功，请刷卡";
        
        
        [wSelf.tianYuView startTrading];

    };
    _tianYuView.tradSuccessBlock = ^(BOOL success) {
      //交易成功
    };
    _tianYuView.disConnectedDeviceBlock = ^(BOOL success) {
        //已断开连接
        [wSelf.tianYuView startTianYu];
        
        wSelf.stateLabel.text = @"请连接刷卡器";
        [ToolsObject playGIFWithNameL:@"searchTools" playTime:3 showImageView:wSelf.stateBGImageView];
    };
    
}



@end
