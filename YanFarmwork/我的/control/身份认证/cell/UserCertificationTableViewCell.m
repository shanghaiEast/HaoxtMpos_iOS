//
//  UserCertificationTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "UserCertificationTableViewCell.h"

#import "UserStatementTableViewController.h"


#import "CWURLSession.h"
#import "CWCommon.h"
#import "CWMBProgressHud.h"
#import "CWIDCardCaptureController.h"

@interface UserCertificationTableViewCell ()<cwIdCardRecoDelegate>

@property (retain,nonatomic) CWIDCardCaptureController  * cvctrl;

@end


@implementation UserCertificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _idcardQuality = 0.65;
    _authCode = AuthCodeString;
    
    [self createView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createView {
    _idCardZMimageView.tag = 1;
    UITapGestureRecognizer *touch_zm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    [_idCardZMimageView addGestureRecognizer:touch_zm];
    
    _idCardFMimageView.tag = 2;
    UITapGestureRecognizer *touch_fm = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    [_idCardFMimageView addGestureRecognizer:touch_fm];
}

- (IBAction)nextBtnClick:(id)sender {
    
    UserStatementTableViewController *userStatementVC = [[UserStatementTableViewController alloc] initWithNibName:@"UserStatementTableViewController" bundle:nil];
    userStatementVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:userStatementVC animated:YES];
}
- (IBAction)yesOrNoBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if (button == _yesBtn) {
        _yesBtn.selected = YES;
        _noBtn.selected = NO;
        
    }else{
        _yesBtn.selected = NO;
        _noBtn.selected = YES;
    }
}





//-----------------------以下为身份证识别ocr
-(void)selectPhoto:(UITapGestureRecognizer *)tapGesture{
    
    //身份证扫描自动检测 无需拍照
    _cvctrl = [[CWIDCardCaptureController alloc]init];
    //设置授权码
    _cvctrl.lisenceStr = _authCode;
    
    _cvctrl.delegate = self;
    if (tapGesture.view.tag == 1) {
        _cvctrl.type = CWIDCardTypeFront;
    }else{
        _cvctrl.type = CWIDCardTypeBack;
    }
    //设置图片清晰度阈值 推荐阈值为0.65
    _cvctrl.cardQualityScore = self.idcardQuality;
    [_rootVC presentViewController:_cvctrl animated:YES completion:nil];
}

-(void)cwIdCardRecoResult:(NSDictionary *)dict idCardType:(CWIDCardType)idcardType cardImage:(UIImage *)cardImage idFaceImage:(UIImage *)idFaceImage{
    
    UIImageWriteToSavedPhotosAlbum(cardImage, nil, nil, nil);
    
//    [self setSelectImage:cardImage];
    
    NSLog(@"dict : %@",dict);
    
    if(idcardType == CWIDCardTypeFront){
        _idCardZMimageView.image = cardImage;
        
        _nameTextField.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
        
        _idNOTextField.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"idNumber"]];
        
    }else{
         _idCardFMimageView.image = cardImage;
        
        NSString *date1Str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"validdate1"]];
        date1Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:4];
        date1Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:7];
        
        
        NSString *date2Str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"validdate2"]];
        date2Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:4];
        date2Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:7];
        
        [_timeBtn setTitle:[NSString stringWithFormat:@"%@    %@",date1Str,date2Str] forState:UIControlStateNormal];
        
         NSLog(@"date1Str: %@",date1Str);
    }
    
}




@end
