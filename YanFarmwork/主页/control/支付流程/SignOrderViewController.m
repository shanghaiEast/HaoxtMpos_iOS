//
//  SignOrderViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "SignOrderViewController.h"

#import "SingOrderTableViewCell.h"

#import "SignOrderFooterView.h"

#import "ConfirmSignViewController.h"



@interface SignOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray *keyArray, *valueArray;

@property (retain, nonatomic) SignOrderFooterView *footerView;

@property (retain, nonatomic) NSDictionary *resultDict;


@end

@implementation SignOrderViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:MAINCOLOR andItem:@"" itemColor:WHITECOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_White withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:View];
    [ToolsObject gradientColor:View startColor:@"#FE4049" endColor:@"#EF5F48"];
    
    
    [self requestMessage];
    
    _keyArray = [[NSMutableArray alloc] init];
    _valueArray = [[NSMutableArray alloc] init];
   
    
    [ToolsObject disableTheSideslip:self];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, ScreenHeight-kNavBarHAbove7-kBottomSafeHeight-30)];
    //    bgImageView.backgroundColor = [UIColor blackColor];
    bgImageView.image = [UIImage imageNamed:@"singOrderBG.png"];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(0, bgImageView.frame.size.height-65, bgImageView.frame.size.width, 40)];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [confirmButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:confirmButton];
    
   
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height-65) style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.sectionFooterHeight = CGFLOAT_MIN;
//    self.myTableView.tableFooterView = [UIView new];
//    self.myTableView.sectionHeaderHeight = CGFLOAT_MIN;
//    self.myTableView.tableHeaderView = [UIView new];
//    self.myTableView.bounces = NO;
    [bgImageView addSubview:self.myTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _keyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 
    return 135;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    view.backgroundColor = [UIColor clearColor];
    
//    UIView *headColor = [[UIView alloc] initWithFrame:CGRectMake(20, 7, tableView.frame.size.width-40, 60-7)];
//    headColor.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
//    [view addSubview:headColor];
    
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.frame = CGRectMake(29,23,22,18);
    logoImage.image = [UIImage imageNamed:@"银联.png"];
    logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:logoImage];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(50,21,view.frame.size.width-100,24);
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLabel.text = @"签购单";
    [view addSubview:titleLabel];
    
    UIImageView *bottomLine = [[UIImageView alloc] init];
    bottomLine.frame = CGRectMake(20,58,view.frame.size.width-40,2);
    bottomLine.image = [UIImage imageNamed:@"mainLine.png"];
    bottomLine.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:bottomLine];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    _footerView = [[[NSBundle mainBundle] loadNibNamed:@"SignOrderFooterView" owner:self options:nil] lastObject];
    [_footerView setFrame:CGRectMake(0, 0, ScreenWidth-40, 135)];

    if (_resultDict.count != 0) {
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:[_resultDict objectForKey:@"FILE_NO"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:imageData];
        _footerView.signImageView.image = image;
        
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:_footerView.signImageView.bounds];
//            imageView.backgroundColor = [UIColor orangeColor];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            [self.view addSubview:imageView];
//            
//            NSData  *decodedImageData = [[NSData alloc] initWithBase64Encoding:_testImageString];
//            UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
//            
//            imageView.image = decodedImage;
//        });
    }
    
    
    return _footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_keyArray.count-1 == indexPath.row) {
        return 40;
    }
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStr = @"SingOrderTableViewCell";
    SingOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellStr owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    cell.processTag = _processTag;
    cell.rootVC = self;
    
    
    cell.keyLabel.text = [NSString stringWithFormat:@"%@",[_keyArray objectAtIndex:indexPath.row]];
    cell.valueLabel.text = [NSString stringWithFormat:@"%@",[_valueArray objectAtIndex:indexPath.row]];
    
    if (_keyArray.count-1 == indexPath.row) {
        cell.valueLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
        cell.valueLabel.textColor = MAINCOLOR;
    }

    
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)confirmBtnClick {
    ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
    confirmSignVC.payType = PAY_SUCCESS;
    confirmSignVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:confirmSignVC animated:YES];
}



- (void)requestMessage {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    [YanNetworkOBJ postWithURLString:sign_qrySignBillDtl parameters:_requestDict success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            /**
             rspMap =     {
             "AUT_CD" = "";
             "BANK_NAME" = "";
             "CORG_MERC_ID" = 84310008651000A;
             "CORG_MERC_NM" = "\U4e2a\U4f53\U6237\U4e25\U534e\U5f3a";
             "CORG_SREF_NO" = 000000822187;
             "CORG_TRM_NO" = 10006096;
             "CRD_EXP_DT" = "";
             "CRD_FLG" = "";
             "CRD_NO" = "";
             "FILE_NO" = yggkKFhcYGRolJicoKSo0NTY3\
             ORGA = CUP;
             "TXN_AMT" = "0.01";
             "TXN_CD" = "\U6d88\U8d39";
             "TXN_TM" = 20190926183411;
             };
             **/
            
            wSelf.resultDict = [responseObject objectForKey:@"rspMap"];
            
            
            [self getSourceArray];
            
            [wSelf.myTableView reloadData];
            
            
            
            
            
            
           
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

- (void)getSourceArray{
    NSArray *tempKeyArray = @[
                              @"终端机号",
                              @"商户名称",
                              @"商户编号",
                              @"有 效 期",
                              @"卡 组 织",
                              @"发 卡 行",
                              @"卡 类 别",
                              @"卡   号",
                              @"交易类型",
                              @"交易日期",
                              @"授 权 码",
                              @"金   额"
                              ];
    
    NSArray *tempValueArray = [[NSArray alloc] initWithObjects:
                               [_resultDict objectForKey:@"CORG_TRM_NO"],
                               [_resultDict objectForKey:@"CORG_MERC_NM"],
                               [_resultDict objectForKey:@"CORG_MERC_ID"],
                               [_resultDict objectForKey:@"CRD_EXP_DT"],
                               [_resultDict objectForKey:@"ORGA"],
                               [_resultDict objectForKey:@"BANK_NAME"],
                               [_resultDict objectForKey:@"CRD_FLG"],
                               [_resultDict objectForKey:@"CRD_NO"],
                               [_resultDict objectForKey:@"TXN_CD"],
                               [_resultDict objectForKey:@"TXN_TM"],
                               [_resultDict objectForKey:@"AUT_CD"],
                               [_resultDict objectForKey:@"TXN_AMT"], nil];
    
    for (int a = 0; a < tempValueArray.count; a ++) {
        if ([checkNull([tempValueArray objectAtIndex:a]) length] != 0) {
            [_keyArray addObject:checkNull([tempKeyArray objectAtIndex:a])];
            [_valueArray addObject:checkNull([tempValueArray objectAtIndex:a])];
        }
    }
    
    NSLog(@"_keyArray == %@",_keyArray);
}

@end
