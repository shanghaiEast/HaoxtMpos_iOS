//
//  UserCertificationTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCertificationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *idCardZMimageView;
@property (weak, nonatomic) IBOutlet UIImageView *idCardFMimageView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idNOTextField;

@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UIButton *noBtn;

- (IBAction)yesOrNoBtnClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *timeBtn;



- (IBAction)nextBtnClick:(id)sender;

@property (retain, nonatomic) UIViewController *rootVC;
- (void)createHeaderView;


//-----------------------以下为身份证识别ocr
@property(nonatomic,strong)NSString  * authCode;//授权码
@property(nonatomic,assign)double  idcardQuality;//质量分数阈值

@end

NS_ASSUME_NONNULL_END
