//
//  AddCreditCardViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "AddCreditCardViewController.h"

#import "ConfirmSignViewController.h"

@interface AddCreditCardViewController ()

@end

@implementation AddCreditCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"信用卡认证" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [_headBankBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _headBankBtn.imageView.image.size.width, 0, _headBankBtn.imageView.image.size.width)];
    [_headBankBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _headBankBtn.titleLabel.bounds.size.width, 0, -_headBankBtn.titleLabel.bounds.size.width)];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)headBankBtnClick:(id)sender {
    
    
}

- (IBAction)commitBtnClick:(id)sender {
    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
    confirmSignVC.payType = TYPE_CARDCER;
    confirmSignVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:confirmSignVC animated:YES];
    
}


- (void)requestCommit{
    
//    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
//    typeof(self) wSelf = self;
//
//    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                [NSString stringWithFormat:@"%d",_page],@"PAGE_NUM",
//                                @"10",@"PAGE_SIZE",
//                                [NSString stringWithFormat:@"%@",[myData CER_NO]],@"",
//                                nil];
//
//    [YanNetworkOBJ postWithURLString:check_list parameters:parametDic success:^(id  _Nonnull responseObject) {
//        [ToolsObject SVProgressHUDDismiss];
//        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//
//            if (wSelf.page == 1) {
//                wSelf.cardArray = [responseObject objectForKey:@"rspData"];
//            }else{
//                [wSelf.cardArray addObjectsFromArray:[responseObject objectForKey:@"rspData"]];
//            }
//
//            [wSelf.tableView reloadData];
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
