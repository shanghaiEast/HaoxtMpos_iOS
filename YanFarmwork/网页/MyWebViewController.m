//
//  MyWebViewController.m
//  YanFarmwork
//
//  Created by 国时 on 2019/6/12.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MyWebViewController.h"

#import <WebKit/WebKit.h>

@interface MyWebViewController () <WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) WKWebView *wkWebView;
@property (nonatomic, retain) UIProgressView *progressView;

@end

@implementation MyWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//   [MyTools setViewController:self withNavigationBarColor:NavigationBarColor andItem:@"网页加载测试" itemColor:[UIColor blackColor] haveBackBtn:YES withBackImage:defaultBarBackImage_white withBackClickTarget:self BackClickAction:@selector(popToPreviousPage)];
    
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [ToolsObject SVProgressHUDDismiss];
    
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    
}

- (void)popToPreviousPage
{
    if (_wkWebView.canGoBack==YES) {
        //返回上级页面
        [_wkWebView goBack];
        
    }else{
        //退出控制器
       [self.navigationController popViewControllerAnimated:YES];
    }

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
      [self webviewStart];
}


- (void)webviewStart
{
//    if ([[ToolsObject internetStatus] isEqualToString:@"无"]) {
//        [ToolsObject showNoNet:_myWebView withRect:_myWebView.frame];
//        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        app.remindView.netTryAgainBlock = ^(NSString *tryAgain) {
//            [ToolsObject removeRemindView];
//            [self webviewStart];
//        };
//
//        return;
//    }
    
    
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kBottomSafeHeight-kNavBarHAbove7)];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    _wkWebView.scrollView.scrollEnabled = YES;
    _wkWebView.scrollView.delegate = self;
    [self.view addSubview:_wkWebView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0.0];
    
    NSLog(@"打印测试网址：%@", self.urlString);
    
    
    [self createProssView];
    
    
    [_wkWebView loadRequest:request];
}

//** 2：初始化**
- (void)createProssView {
    
    //    // KVO，监听webView属性值得变化(estimatedProgress,title为特定的key)
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    // UIProgressView初始化
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.frame = CGRectMake(0, 0, ScreenWidth, 2); self.progressView.trackTintColor = [UIColor clearColor]; // 设置进度条的色彩
    self.progressView.progressTintColor = [UIColor colorWithHexString:@"#2165D7"]; // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
    [self.progressView setProgress:0.1 animated:YES];
    [_wkWebView addSubview:self.progressView];
    
}
//3：完成监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([object isEqual:_wkWebView] && [keyPath isEqualToString:@"estimatedProgress"]) {
        // 进度条
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue]; NSLog(@"打印测试进度值：%f", newprogress);
//        if (newprogress > 0.5 && newprogress < 0.8 ) {
//            [_wkWebView stopLoading];
//            _wkWebView.UIDelegate = nil;
//            _wkWebView.navigationDelegate = nil;
//        }
        
        if (newprogress == 1) {
            // 加载完成
            // 首先加载到头
            [self.progressView setProgress:newprogress animated:YES];
            // 之后0.2秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
                
            });
            
        } else {
            // 加载中
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
            
        }
        
    } else if ([object isEqual:_wkWebView] && [keyPath isEqualToString:@"title"]) {
        // 标题
        //        self.title = self.webView.title;
        
    } else {
        // 其他
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark  WKWebView代理
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"截取的URL：%@",webView.URL.absoluteString);
    
}


/*
#pragma mark - Navigation

 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
