//
//  SingOrderTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "SingOrderTableViewCell.h"

@implementation SingOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self createView];

}



- (void)createView{
//    [ToolsObject gradientColor:self.bgView startColor:@"#FE4049" endColor:@"#EF5F48"];
}

- (IBAction)confirmBtnClick:(id)sender {
    if (_processTag == 0) {
        
    }else{
        ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
        confirmSignVC.hidesBottomBarWhenPushed = YES;
        confirmSignVC.processTag = _processTag;
        [_rootVC.navigationController pushViewController:confirmSignVC animated:YES];
    }
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
