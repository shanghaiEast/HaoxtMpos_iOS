//
//  MyPOSViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MyPOSViewController.h"

@interface MyPOSViewController ()

@end

@implementation MyPOSViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"我的POS机" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
        [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)popViewClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self requestMyMachine];
}

- (void)createView:(NSDictionary *)dict{
    _typeNameLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"TERM_TYPE"]];
    
    _typeNoLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"TRM_NO"]];
    
    _SNLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"SN_NO"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)requestMyMachine{
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    
    
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] init];
    
    [YanNetworkOBJ postWithURLString:term_list parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            //            wSelf.hasAppliedDict;
            
            [self createView:[[responseObject objectForKey:@"rspData"] objectAtIndex:0]];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

@end
