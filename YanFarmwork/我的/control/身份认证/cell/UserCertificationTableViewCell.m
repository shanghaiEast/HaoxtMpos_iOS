//
//  UserCertificationTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "UserCertificationTableViewCell.h"

#import "UserStatementTableViewController.h"

#import "IDCardTimeView.h"

#import "CWURLSession.h"
#import "CWCommon.h"
#import "CWMBProgressHud.h"
#import "CWIDCardCaptureController.h"

@interface UserCertificationTableViewCell ()<cwIdCardRecoDelegate>

@property (retain,nonatomic) CWIDCardCaptureController  * cvctrl;

@property (retain, nonatomic) IDCardTimeView *timeView;

@property (nonatomic) BOOL cardZMBool, cardFMBool;

@property (retain,nonatomic) NSString *dateStartString, *dateEndString;


@end


@implementation UserCertificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _cardZMBool = NO;
    _cardFMBool = NO;
    
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

- (IBAction)timeBtnSelect:(id)sender {
    typeof(self) wSelf = self;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _timeView = [[[NSBundle mainBundle] loadNibNamed:@"IDCardTimeView" owner:self options:nil] lastObject];
    [_timeView setFrame:app.window.bounds];
    [_timeView createView];
    [app.window addSubview:_timeView];
    _timeView.timeBolck = ^(NSDictionary * _Nonnull dict) {
        NSLog(@"返回的数据：%@",dict);
        /*
         {
         endTime = "2019-09-20";
         startTime = "2019-09-20";
         }
         */
        wSelf.dateStartString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"startTime"]];
        wSelf.dateEndString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"endTime"]];
        
        wSelf.dateStartString = [wSelf.dateStartString stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        wSelf.dateEndString = [wSelf.dateEndString stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        
         [wSelf.timeBtn setTitle:[NSString stringWithFormat:@"%@    %@",wSelf.dateStartString,wSelf.dateEndString] forState:UIControlStateNormal];
       
    };
    
}

- (IBAction)nextBtnClick:(id)sender {
    
    if (_cardZMBool == NO) {
        [ToolsObject showMessageTitle:@"请先上传身份证正面" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_cardFMBool == NO) {
        [ToolsObject showMessageTitle:@"请先上传身份证反面" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_nameTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入姓名" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_idNOTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入身份证号码" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_timeBtn.currentTitle.length == 0) {
        [ToolsObject showMessageTitle:@"请先选择时间" andDelay:1 andImage:nil];
        
        return;
    }
    
    
    [self requestCommit];
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
        
        
        [self requestCommitPic:@"1" withImage:cardImage];
        
    }else{
         _idCardFMimageView.image = cardImage;
        
        _dateStartString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"validdate1"]];
        _dateEndString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"validdate2"]];
        
        NSString *date1Str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"validdate1"]];
        date1Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:4];
        date1Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:7];
        
        
        NSString *date2Str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"validdate2"]];
        date2Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:4];
        date2Str = [ToolsObject insertString:@"/" fromString:date1Str withInsertIndex:7];
        
        [_timeBtn setTitle:[NSString stringWithFormat:@"%@    %@",date1Str,date2Str] forState:UIControlStateNormal];
        
         NSLog(@"date1Str: %@",date1Str);
        
        
         [self requestCommitPic:@"2" withImage:cardImage];
    }
    
}

- (void)requestCommitPic:(NSString *)typeStr withImage:(UIImage *)image {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    
    //UIImage转换为NSData
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0) ;
    NSString *base64String = [ToolsObject dataWitbBase64ToStrimg:imageData];
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                base64String,@"file",
                                typeStr,@"FILE_TYPE",
                                nil];
    
    [YanNetworkOBJ postWithURLString:pub_uploadFile parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
        
            if ([typeStr isEqualToString:@"1"]) {
                wSelf.cardZMBool = YES;
            }
            if ([typeStr isEqualToString:@"2"]) {
                wSelf.cardFMBool = YES;
            }
            
             [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}


- (void)requestCommit {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    int isLoginFloat = 0;
    if (_yesBtn.selected == YES) {
        isLoginFloat = 1;
    }
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _nameTextField.text,@"CARD_NAME",
                                _idNOTextField.text,@"CARD_NO",
                                [_dateStartString stringByReplacingOccurrencesOfString:@"/" withString:@""],@"CER_EXP_DT_START",
                                [_dateEndString stringByReplacingOccurrencesOfString:@"/" withString:@""],@"CER_EXP_DT_END",
                                [NSString stringWithFormat:@"%d",isLoginFloat],@"IS_LONG",
                                nil];
    
    [YanNetworkOBJ postWithURLString:usr_updIdentityCard parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            UserStatementTableViewController *userStatementVC = [[UserStatementTableViewController alloc] initWithNibName:@"UserStatementTableViewController" bundle:nil];
            userStatementVC.hidesBottomBarWhenPushed = YES;
            [wSelf.rootVC.navigationController pushViewController:userStatementVC animated:YES];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}


@end
