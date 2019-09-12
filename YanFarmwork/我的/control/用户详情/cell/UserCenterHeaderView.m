//
//  UserCenterHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "UserCenterHeaderView.h"

@implementation UserCenterHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)popBtnClick:(id)sender {
    [_rootVC.navigationController popViewControllerAnimated:YES];
}

- (void)createHeaderView {
    _headImageView.layer.cornerRadius = 24.0f;
    _headImageView.layer.masksToBounds = YES;
    
}

@end
