//
//  BindToolsViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "BindToolsViewController.h"

#import "ConfirmSignViewController.h"

@interface BindToolsViewController ()

@end

@implementation BindToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createView];
}

- (void)createView {
    
    NSLog(@"mySNString:%@",self.mySNString);
    
    
     _toolsIDLabel.text = self.mySNString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)commitToolsBtnClick:(id)sender {
    
    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
    confirmSignVC.payType = TYPE_TOOLS;
    confirmSignVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:confirmSignVC animated:YES];
}

@end
