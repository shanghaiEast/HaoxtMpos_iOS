//
//  PayResultViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PayResultViewController.h"

#import "SignatureView.h"

@interface PayResultViewController ()

@property (retain, nonatomic) SignatureView *signatureView;

@end

@implementation PayResultViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"结果" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)createView{
    _searchBtn.layer.cornerRadius = 2;
    _searchBtn.layer.masksToBounds = YES;
    
    _cancelBtn.layer.cornerRadius = 2;
    _cancelBtn.layer.masksToBounds = YES;
    
    [ToolsObject SVProgressHUDShowStatus_waring:@"订单查询中" WithMask:NO];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonCilck:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 1) {
        //立即查询
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _signatureView = [[[NSBundle mainBundle] loadNibNamed:@"SignatureView" owner:self options:nil] lastObject];
        [_signatureView setFrame:app.window.bounds];
        _signatureView.processTag = _processTag;
        _signatureView.rootVC = self;
        [_signatureView createView];
        [app.window addSubview:_signatureView];
        
    }else{
        //取消
    }
}

@end
