//
//  LinesViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LinesViewController.h"

@interface LinesViewController ()

@property (retain, nonatomic) NSDictionary *detailDict;

@end

@implementation LinesViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"我的即时额度" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
        [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self requestMoney];
}

- (void)createView {
    
    _remainingAmountLabel.text = [NSString stringWithFormat:@"￥ %@",[_detailDict objectForKey:@"dayBal"]];
    
    _otherCardDayMoneyLabel.text = [NSString stringWithFormat:@"%@",[_detailDict objectForKey:@"magDay"]];
    _otherCardSingleMoneyLabel.text = [NSString stringWithFormat:@"%@",[_detailDict objectForKey:@"magSingle"]];
    
    _ICCardDayMoneyLabel.text = [NSString stringWithFormat:@"%@",[_detailDict objectForKey:@"icDay"]];
    _ICCardSingleMoneyLabel.text = [NSString stringWithFormat:@"%@",[_detailDict objectForKey:@"icSingle"]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)requestMoney{
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    
    
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] init];
    
    [YanNetworkOBJ getWithURLString:stl_quota parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.detailDict = [responseObject objectForKey:@"rspMap"];
            
            [self createView];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [ToolsObject SVProgressHUDDismiss];
    }];
    
//    [YanNetworkOBJ postWithURLString:stl_quota parameters:parametDic success:^(id  _Nonnull responseObject) {
//        [ToolsObject SVProgressHUDDismiss];
//        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//            
//           
//            
//        }else{
//            //filed
//            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
//        }
//        
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"test filed ");
//        [ToolsObject SVProgressHUDDismiss];
//    }];
    
}

@end
