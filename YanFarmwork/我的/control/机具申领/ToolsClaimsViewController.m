//
//  ToolsClaimsViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ToolsClaimsViewController.h"

@interface ToolsClaimsViewController () <UITextViewDelegate>

@property (retain, nonatomic) NSDictionary *hasAppliedDict;

@end

@implementation ToolsClaimsViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"机具申领" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createView];
}

- (void)createView{
    
    _BGView.hidden = YES;
    
    if (_BGView.hidden == NO) {
        [_commitBtn setTitle:@"已申请" forState:UIControlStateNormal];
        _commitBtn.backgroundColor = [UIColor colorWithHexString:@"#F7C7CB"];
    }
    
    _specificAddressTextView.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView;
{
    if (textView.text.length != 0) {
        _remindLabel.hidden = YES;
    }else{
        _remindLabel.hidden = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)recipientAddressBtnClick:(id)sender {

}

- (IBAction)commitBtnClick:(id)sender {
    
//    [self request];
}

- (void)request_HasNoAppliedFor{
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    
    
    typeof(self) wSelf = self;
    
//    NSDictionary *parametDic = [[NSDictionary alloc] init];
//    
//    [YanNetworkOBJ postWithURLString:term_getTmstapply parameters:parametDic success:^(id  _Nonnull responseObject) {
//        [ToolsObject SVProgressHUDDismiss];
//        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//            
//            //            wSelf.hasAppliedDict;
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

- (void)request_HasAppliedFor{

    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];


    typeof(self) wSelf = self;

    NSDictionary *parametDic = [[NSDictionary alloc] init];

    [YanNetworkOBJ postWithURLString:term_getTmstapply parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {

//            wSelf.hasAppliedDict;

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
