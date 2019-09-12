//
//  QrCodeView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "QrCodeView.h"

#import "PayResultViewController.h"

//qrcode
#import "WSLScanView.h"
#import "WSLNativeScanTool.h"

@interface QrCodeView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)  WSLNativeScanTool * scanTool;
@property (nonatomic, strong)  WSLScanView * scanView;


@end

@implementation QrCodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView{
//    [ToolsObject gradientColor:self startColor:@"#FE4049" endColor:@"#EF5F48"];
    
    _payView.layer.cornerRadius = 16.0f;
    _payView.layer.masksToBounds = YES;
    
    _payLogoImageView.image = [UIImage imageNamed:@"payWX.png"];//payZFB.png
    
    _payTitleLabel.text = @"微信扫一扫，向我付款";//支付宝扫一扫，向我付款
    
    _payMoneyLabel.text = [NSString stringWithFormat:@"￥ %@",@"1233"];

    
     [self createScan];
}



- (void)createScan{
    [self layoutIfNeeded];
    
    typeof(self) wSelf = self;
    
    //输出流视图
//    UIView *preview  = [[UIView alloc] initWithFrame:_qrCodeView.bounds];
//    [_qrCodeView addSubview:preview];
    
    //构建扫描样式视图
    _scanView = [[WSLScanView alloc] initWithFrame:_qrCodeView.bounds];
    _scanView.scanRetangleRect = _qrCodeView.bounds;
    _scanView.colorAngle = [UIColor greenColor];
    _scanView.photoframeAngleW = 20;
    _scanView.photoframeAngleH = 20;
    _scanView.photoframeLineW = 0;
    _scanView.isNeedShowRetangle = YES;
    _scanView.colorRetangleLine = [UIColor whiteColor];
    _scanView.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _scanView.animationImage = [UIImage imageNamed:@"scanLine"];
    _scanView.myQRCodeBlock = ^{
        NSLog(@"block");
        
    };
    _scanView.flashSwitchBlock = ^(BOOL open) {
        [wSelf.scanTool openFlashSwitch:open];
    };
    [_qrCodeView addSubview:_scanView];
    
    //初始化扫描工具
    _scanTool = [[WSLNativeScanTool alloc] initWithPreview:_qrCodeView andScanFrame:_scanView.scanRetangleRect];
    _scanTool.scanFinishedBlock = ^(NSString *scanString) {
        NSLog(@"扫描结果 %@",scanString);
        [wSelf.scanView handlingResultsOfScan];
        
        if (_processTag == 0) {
            
        }else{
            PayResultViewController *resultVC = [[PayResultViewController alloc] initWithNibName:@"PayResultViewController" bundle:nil];
            resultVC.hidesBottomBarWhenPushed = YES;
            resultVC.processTag = _processTag;
            [_rootVC.navigationController pushViewController:resultVC animated:YES];
        }
        

        
        
        
        
    };
    
    /*
    _scanTool.monitorLightBlock = ^(float brightness) {
//        NSLog(@"环境光感 ： %f",brightness);
        if (brightness < 0) {
            // 环境太暗，显示闪光灯开关按钮
            [wSelf.scanView showFlashSwitch:YES];
        }else if(brightness > 0){
            // 环境亮度可以,且闪光灯处于关闭状态时，隐藏闪光灯开关
            if(!wSelf.scanTool.flashOpen){
                [wSelf.scanView showFlashSwitch:NO];
            }
        }
    };
     */
    
    [_scanTool sessionStartRunning];
    [_scanView startScanAnimation];
}


#pragma mark -- Events Handle
- (void)photoBtnClicked{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController * _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [_rootVC presentViewController:_imagePickerController animated:YES completion:nil];
    }else{
        NSLog(@"不支持访问相册");
    }
}
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^) (UIAlertAction *action))handler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:action];
    [_rootVC presentViewController:alert animated:YES completion:nil];
}
#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    //    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
    [_rootVC dismissViewControllerAnimated:YES completion:nil];
    [_scanTool scanImageQRCode:image];
}


@end
