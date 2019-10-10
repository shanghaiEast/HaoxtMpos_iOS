//
//  PersonCenterViewController.m
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import "PersonCenterViewController.h"

#import "PersonCenterTableViewCell.h"

#import "PersonCenterView.h"

#import "TCreditCardCerTableViewController.h"
#import "ToolsClaimsViewController.h"


@interface PersonCenterViewController () <UITableViewDelegate, UITableViewDataSource>


@property (retain, nonatomic) PersonCenterView *personCenterView;


@property (retain, nonatomic) NSArray *titleArrar, *picturArray;

@property (retain, nonatomic) NSDictionary *merchantsDict;


@end

@implementation PersonCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self showMerchin];
    [_myTableView reloadData];
    
    
    if ([myData TOKEN_ID].length != 0) {
        if (([[myData USR_STATUS] intValue] == 0 && [MY_USR_REAL_STS intValue] != 2)) {
            
        }else{
            [self requestMerchantsMessage];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated:(BOOL)animated {
    [super viewDidAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   
    
//    _titleArrar = @[@"信用卡认证", @"机具申领", @"在线客服", @"帮助中心"];
//    _picturArray = @[@"personCard.png", @"personGoods.png", @"personService.png", @"personCenter.png"];
    
    [self showMerchin];
    
    [self createTableView];
}

- (void)showMerchin{
    
    //机具申领([[myData USR_STATUS] intValue] == 0 && [MY_USR_REAL_STS intValue] != 2)
    if ([myData TOKEN_ID].length != 0 && [[myData USR_TERM_STS] intValue] == 0) {
        _titleArrar = @[@"信用卡认证", @"机具申领"];
        _picturArray = @[@"personCard.png", @"personGoods.png"];
       
    }else{
        _titleArrar = @[@"信用卡认证"];
        _picturArray = @[@"personCard.png"];
    }
}

- (void)createTableView {
    //table view
    
    float height = YYISiPhoneX ? 44 : 20;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EF5F48"];
    [self.view addSubview:view];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, ScreenHeight-kTabBarHeight-height) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
    _myTableView.bounces = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleArrar.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 270;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _personCenterView = [[[NSBundle mainBundle] loadNibNamed:@"PersonCenterView" owner:self options:nil] lastObject];
    [_personCenterView setFrame:CGRectMake(0, 0, ScreenWidth, 270)];
    if (_merchantsDict.count != 0) {
        _personCenterView.detialDict = SHOP_DETAIL;
    }
    _personCenterView.rootVC = self;
    [_personCenterView createView];
    
    return _personCenterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"PersonCenterTableViewCell";
    PersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftImageView.image = [UIImage imageNamed:[_picturArray objectAtIndex:indexPath.row]];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",[_titleArrar objectAtIndex:indexPath.row]];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([myData TOKEN_ID].length != 0) {
        if (([[myData USR_STATUS] intValue] == 0 && [MY_USR_REAL_STS intValue] != 2)) {
            
            [self requestMerchantsMessage];
            
            return;
        }
    }
    
    
    if (indexPath.row == 0) {
        //信用卡认证
        TCreditCardCerTableViewController *cardCerVC = [[TCreditCardCerTableViewController alloc] initWithNibName:@"TCreditCardCerTableViewController" bundle:nil];
        cardCerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cardCerVC animated:YES];
    }
    if (indexPath.row == 1) {
        //机具申领
        ToolsClaimsViewController *toolsVC = [[ToolsClaimsViewController alloc] initWithNibName:@"ToolsClaimsViewController" bundle:nil];
        toolsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:toolsVC animated:YES];
    }
}

//UITableView顶部不可拖动
-(void)scrollViewDidScroll:(UIScrollView*)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if(offset.y<=0) {
        
        offset.y=0;
        
    }
    scrollView.contentOffset= offset;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestMerchantsMessage {
    
    if ([SHOP_DETAIL count] == 0) {//第一次展示
        [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    }

    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] init];
    
    [YanNetworkOBJ postWithURLString:usr_get parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.merchantsDict = [responseObject objectForKey:@"rspMap"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:wSelf.merchantsDict forKey:@"shopDetail"];
            
            
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
