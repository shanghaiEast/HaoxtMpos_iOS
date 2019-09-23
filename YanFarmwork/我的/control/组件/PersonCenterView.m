//
//  PersonCenterView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PersonCenterView.h"

#import "SetAppViewController.h"
#import "UserSenterTableViewController.h"
#import "UserCertificationTableViewController.h"
#import "LinesViewController.h"
#import "DebitCardViewController.h"
#import "MyPOSViewController.h"

@implementation PersonCenterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView {
    
    [_bgView setFrame:CGRectMake(0, 0, ScreenWidth, 270)];
    [ToolsObject gradientColor:_bgView startColor:@"#EF5F48" endColor:@"#FE4049"];
    
    
    _bottonImageView.layer.cornerRadius = 10.0f;
    _bottonImageView.layer.masksToBounds = YES;
    
    
    _nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@  %@",[myData USR_OPR_NM],[myData USR_OPR_MBL]];
    
    _shopNOLabel.text = [NSString stringWithFormat:@"商户编号   %@",checkNull([_detialDict objectForKey:@"MERC_ID"])];
    
    
    
    UITapGestureRecognizer *headTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(puchToUserMessage)];
    [_headImageView addGestureRecognizer:headTouch];
    
    UITapGestureRecognizer *nameAndPhoneTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(puchToUserMessage)];
    [_nameAndPhoneLabel addGestureRecognizer:nameAndPhoneTouch];
    
    UITapGestureRecognizer *viewOneTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewOne.tag = 1;
    [_viewOne addGestureRecognizer:viewOneTouch];
    
    UITapGestureRecognizer *viewTwoTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewTwo.tag = 2;
    [_viewTwo addGestureRecognizer:viewTwoTouch];
    
    UITapGestureRecognizer *viewThreeTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewThree.tag = 3;
    [_viewThree addGestureRecognizer:viewThreeTouch];
    
    UITapGestureRecognizer *viewFourTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewFour.tag = 4;
    [_viewFour addGestureRecognizer:viewFourTouch];
    
}

//设置app信息
- (IBAction)setBtnClick:(id)sender {
    NSLog(@"设置app信息");
    SetAppViewController *setAppVC = [[SetAppViewController alloc] initWithNibName:@"SetAppViewController" bundle:nil];
    setAppVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:setAppVC animated:YES];
}

//跳转个人资料
- (void)puchToUserMessage{
    NSLog(@"跳转个人资料");
    UserSenterTableViewController *userVC = [[UserSenterTableViewController alloc] initWithNibName:@"UserSenterTableViewController" bundle:nil];
    userVC.detialDict = _detialDict;
    userVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:userVC animated:YES];
}
//4个按钮点击
- (void)fourViewPress:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSLog(@"4个按钮点击: %ld",(long)tapGestureRecognizer.view.tag);
    if (tapGestureRecognizer.view.tag == 1) {
        if ([[myData USR_STATUS] intValue] != 0) {
            [ToolsObject showMessageTitle:@"您已经认证过了" andDelay:1 andImage:nil];
            return;
        }
        UserCertificationTableViewController *userCerVC = [[UserCertificationTableViewController alloc] initWithNibName:@"UserCertificationTableViewController" bundle:nil];
        userCerVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:userCerVC animated:YES];
    }
    
    if (tapGestureRecognizer.view.tag == 2) {
        DebitCardViewController *debitCardVC = [[DebitCardViewController alloc] initWithNibName:@"DebitCardViewController" bundle:nil];
        debitCardVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:debitCardVC animated:YES];
    }
    
    if (tapGestureRecognizer.view.tag == 3) {
        LinesViewController *linesVC = [[LinesViewController alloc] initWithNibName:@"LinesViewController" bundle:nil];
        linesVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:linesVC animated:YES];
    }
    
    if (tapGestureRecognizer.view.tag == 4) {
        MyPOSViewController *myPosVC = [[MyPOSViewController alloc] initWithNibName:@"MyPOSViewController" bundle:nil];
        myPosVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:myPosVC animated:YES];
    }
    
}

@end
