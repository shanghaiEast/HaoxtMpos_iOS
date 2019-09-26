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
    _keyArray = @[@"终端机号", @"商户名称", @"商户编号", @"金额"];
    _valueArray = @[@"SL21323234", @"大雷子", @"3223423434", @"1323"];
    
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
    
   
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height-65) style:UITableViewStylePlain];
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
    
    
    _requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%@",@"001514"],@"cseqNo",
                             [NSString stringWithFormat:@"%@",@"000001"],@"batchNo",
                             [NSString stringWithFormat:@"%@",@"00000005"],@"trmNo",
                             [NSString stringWithFormat:@"%@",@"20190926"],@"actDt",
                             nil];
    
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
             "FILE_NO" = "/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a\nHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy\nMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCABaAGkDASIA\nAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA\nAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3\nODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm\np6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA\nAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx\nBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK\nU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3\nuLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD32iii\ngAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiio5zMtvK1vHHJOEJjSRyis2OAWAJAz\n3wcehoAkqvfX9nplnJeX93BaWseN808gjRckAZY8DJIH41n3Ok6jf7lutbngh818R6fEsPmQnGEd\nm3vuAB+eNoz82RggEFj4V0LT7yO9h0yBr9M4vpwZrk5BHMz5kPB28twOOnFAFf8A4S23uONK03Vd\nUbqDb2pjjZP76TTGOJ1PGNrnIOQCMkWJv+EjuPtCQf2VYbJR5Ez+ZeebH82dyDytjfdPDOOo9DWx\nRQBz/wDwjEs/y6h4j1y9hHIj89LXDeu62SJzxngsV5zjIBGhpmi2WkeabVZ2klwHlubmS4kYDOF3\nyMzbRliFzgFmIGSc6FFABRRRQAUUUUAFFFFABRRRQBn6zLcW2nPe2zTlrTM7wQQCZ7lFB3RBcgli\nPu4I+YLnIypuQTLc28U6CQJIgdRJGyMARnlWAKn2IBHeq97py3jxyi5u7eeJJFikgnZQpdcbinKO\nR1G9WAPOKp2uk6lZ+e//AAkd9eSNEyRLfQW5jRz0ciKONmxjpuGQT3wQAbFFRwCZbeJbiSOScIBI\n8aFFZsckKSSBntk49TUlABRVe+v7PTLOS8v7uC0tY8b5p5BGi5IAyx4GSQPxrDmhvvFSBHOpaPpa\nur/JJ5F1d4YMOVJaGIjqPllJJB8vaQ4BYnnm124lsbGWSHT4nMd3eRMVaRgcNDCw5BByHkH3eVX5\n9zRblRwQQ2tvFb28UcMESBI441CqigYAAHAAHGKkoAKKKKACiiigAooooAKKK4y58YarqNxc2fh7\nQNS3wIHNzqFhJCsgJX/VJIYw5GSCHkiI6rvwRQB1888Nrby3FxLHDBEheSSRgqooGSSTwABzmsP+\n3bzVfk8PWXmwnj+0rsGO2A/vRj783BVhtAjcZxKDWRaaD4g1GU3esRWLXa7ZrSa9ma5S2kDBgBaI\nEjRgN+HEsjrnHmOOa6Oztda+z3UWpapaO8ibYZbGyMDQnBy37ySUMehGRjjkHNAEdj4et4byPUr9\nvt+qrki6mBIhJBDCBCSIVIO3C8sAN5c/MdisPw7c3by6xYXd1JdnTr0W6XEqoskitBFLl9gVcgyk\nDCjgDqck7lABRRRQAUUUUAFFFFABRRRQAUUUUAFU9V1KHSNLuL+dZHSFMiOIAvK3RUQEjc7MQqju\nSB3o1XVbHRNLuNT1O5jtrO3TfLK/RR/MknAAHJJAHJrD0GHUdcvIvEWsW09iqbxp2mSlSYY2CgTS\nrjKzkbxgNhEcr1LkgGxo9pcWtm7Xpga+uJXnnaFABkn5VyAN+xAkYcgFggJA6DQoooAKKKKACiii\ngAooooAKKKKACo554bW3luLiWOGCJC8kkjBVRQMkkngADnNSVz/iP59V8MQN80MuqnzIzyr7LW4k\nXI74dEYejKp6gUAFtaXGuaiup35nj01NjWemyoFy6kkXEoxuDHI2xsfl2qxAk4j6CiigAooooAKK\nKKAP/9k=";
             ORGA = CUP;
             "TXN_AMT" = "0.01";
             "TXN_CD" = "\U6d88\U8d39";
             "TXN_TM" = 20190926183411;
             };
             **/
            _resultDict = [responseObject objectForKey:@"rspMap"];
            
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

@end
