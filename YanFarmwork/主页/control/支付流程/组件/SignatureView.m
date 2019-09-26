//
//  SignatureView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "SignatureView.h"
#import "SignOrderViewController.h"

#import "ConfirmSignViewController.h"

#import "LocationObject.h"



@interface SignatureView ()


//接口查询次数
@property (nonatomic) int searchCount;

@end

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
    //    self.image = ;
    

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
            
            [self requestCommitImage];
            
        }
    
    }
}



- (void)requestCommitImage {
    
//    if (_image == nil) {
//        [ToolsObject showMessageTitle:@"请先上传图片" andDelay:1 andImage:nil];
//        
//        return;
//    }
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSData *imageData = UIImageJPEGRepresentation([self saveScreen:_drawView], 1.0) ;
    NSString *base64String = [ToolsObject dataWitbBase64ToStrimg:imageData];
    
//    NSString *actDtString = [_detailDict objectForKey:@"dateLocalTransaction"];
//    actDtString = [NSString stringWithFormat:@"%@%@",[self getCurrentTimes],actDtString];
    NSString *actDtString = [self getCurrentTimes];
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",[_detailDict objectForKey:@"systemsTraceAuditNumber"]],@"cseqNo",
                                 [NSString stringWithFormat:@"%@",[_detailDict objectForKey:@"batchNo"]],@"batchNo",
                                [NSString stringWithFormat:@"%@",[_detailDict objectForKey:@"cardAcceptorTerminalId"]],@"trmNo",
                                 [NSString stringWithFormat:@"%@",actDtString],@"actDt",
                                 [NSString stringWithFormat:@"%@",base64String],@"strBaseImg",
                                nil];
    
    
    
    [YanNetworkOBJ postWithURLString:sign_upLoadSign parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            NSDictionary *pushDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        [NSString stringWithFormat:@"%@",[wSelf.detailDict objectForKey:@"systemsTraceAuditNumber"]],@"cseqNo",
                                        [NSString stringWithFormat:@"%@",[wSelf.detailDict objectForKey:@"batchNo"]],@"batchNo",
                                        [NSString stringWithFormat:@"%@",[wSelf.detailDict objectForKey:@"cardAcceptorTerminalId"]],@"trmNo",
                                        [NSString stringWithFormat:@"%@",actDtString],@"actDt",
                                        nil];
            
            SignOrderViewController *signVC = [[SignOrderViewController alloc] initWithNibName:@"SignOrderViewController" bundle:nil];
            signVC.processTag = wSelf.processTag;
            signVC.requestDict = pushDic;
            signVC.hidesBottomBarWhenPushed = YES;
            [_rootVC.navigationController pushViewController:signVC animated:YES];

            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

#pragma mark 获取当前的时间
-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYYMMdd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}


@end
