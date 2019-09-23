//
//  DebitCardViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "DebitCardViewController.h"

#import "ChangeDebitCardViewController.h"

@interface DebitCardViewController ()

@property (retain, nonatomic) NSDictionary *bankDict;

@end

@implementation DebitCardViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"我的结算卡" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 100, 38)];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [rightButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [rightButton setTitle:@"更换结算卡" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(changeDebitCard) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//更换结算卡
- (void)changeDebitCard{
//    if (_bankDict.count != 0) {
        ChangeDebitCardViewController *changeCardVC = [[ChangeDebitCardViewController alloc] initWithNibName:@"ChangeDebitCardViewController" bundle:nil];
        changeCardVC.detailDict = _bankDict;
        changeCardVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeCardVC animated:YES];
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self requestCard];
}

- (void)createCardView {
    _bankNameLabel.text = [_bankDict objectForKey:@"STL_BANK_NAME"];
    
//    _bankCardType.text = [_bankDict objectForKey:@"STL_BANK_NAME"];
    
    _bankCardID.text = [_bankDict objectForKey:@"STL_ACO_NO"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestCard {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    
    
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] init];
    
    [YanNetworkOBJ postWithURLString:stl_get parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.bankDict = [responseObject objectForKey:@"rspMap"];
            
            [self createCardView];
            
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
