//
//  SignatureView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "SignatureView.h"
#import "SignOrderTableViewController.h"

@implementation SignatureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView{
    
    [_signView addSubview:[self drawView]];
}


- (SDDrawView *)drawView{
    
    if(_drawView == nil){
        
        _drawView = [[SDDrawView alloc] initWithFrame:CGRectMake(0, 0, ScreenHeight, 193)];
        _drawView.drawViewColor = [UIColor lightGrayColor];
        _drawView.lineWidth = 2.0f;
        _drawView.drawStyle = DrawStyleLine;
        _drawView.lineColor = [UIColor blackColor];
//        _drawView.layer.borderWidth = 1.0f;
//        _drawView.layer.borderColor = [self hexStringToColor:@"c0c0c0"].CGColor;
    }
    
    return _drawView;
}

- (UIImage *)saveScreen:(SDDrawView *)view {
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *image = [[UIImage alloc]init];
    //    image = UIGraphicsGetImageFromCurrentImageContext();
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //不保存签名图片到本地
    //    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    CGSize imagesize = image.size;
    imagesize.height =50;
    imagesize.width =100;
    //    self.image = [NumberVerification imageWithImage:image scaledToSize:imagesize];
    return image;
}



- (IBAction)buttonClick:(id)sender {
    UIButton *button = (id)sender;
    if ([button.currentTitle isEqualToString:@"关闭"]) {
        self.hidden = YES;
        
    }else if ([button.currentTitle isEqualToString:@"重写"]) {
        
    }else if ([button.currentTitle isEqualToString:@"确定"]) {
        
        self.hidden = YES;
        
        if (_processTag == 0) {
            
        }else{
            SignOrderTableViewController *signVC = [[SignOrderTableViewController alloc] initWithNibName:@"SignOrderTableViewController" bundle:nil];
            signVC.processTag = _processTag;
            signVC.hidesBottomBarWhenPushed = YES;
            [_rootVC.navigationController pushViewController:signVC animated:YES];
        }
        
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        imageView.backgroundColor = [UIColor yellowColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_rootVC.view addSubview:imageView];
        imageView.image = [self saveScreen:_drawView];
    
    }
}
@end
