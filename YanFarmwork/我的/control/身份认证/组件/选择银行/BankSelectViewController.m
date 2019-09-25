//
//  BankSelectViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/20.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "BankSelectViewController.h"

#import "BankSelectTableViewCell.h"



@interface BankSelectViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (retain, nonatomic) NSArray *headBankArray, *footBankArray;

//search
@property (retain, nonatomic) UIView *searchView;
@property (retain, nonatomic) UITextField *textField;
@property (retain, nonatomic) UIButton *cancelButton;

@end

@implementation BankSelectViewController

- (UIButton *)createButton
{
    _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_cancelButton setFrame:CGRectMake(_searchView.frame.size.width-30, 2, 40, 40)];
    [_cancelButton setTintColor:[UIColor darkGrayColor]];
    [_cancelButton setTitle:@"搜索" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cancelButton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _cancelButton;
}
- (UITextField *)textField
{
    if (_textField == nil) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, _searchView.frame.size.width-50, 34)];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.placeholder = @"请输入关键字查询";
        //        searchField.borderStyle = UITextBorderStyleNone;
        //        searchField.background = [UIImage imageNamed:@"ic_top"];
        _textField.backgroundColor = RGB(242, 242, 242, 1);
        _textField.leftViewMode=UITextFieldViewModeNever;
        _textField.textColor=[UIColor darkGrayColor];
        _textField.layer.cornerRadius = 17.0;
        _textField.layer.borderWidth = 1.0f;
        _textField.layer.borderColor = [RGB(230, 230, 230, 1) CGColor];
        _textField.layer.masksToBounds = YES;
        _textField.delegate = self;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeySearch;
        //        //改变placeholder的颜色
//        [_textField setValue:[]  forKeyPath:@"_placeholderLabel.textColor"];
        
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 30, 16)];
        phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
        phoneImageView.image = [UIImage imageNamed:@"searchIcon.png"];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = phoneImageView;
        
    }
    
    return _textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self requestBank];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self requestBank];
    
    
    return YES;
}

- (void)cancelBtnClick
{
    [self requestBank];
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    
    //将搜索条放在一个UIView上
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(50, 0, ScreenWidth-80, 44)];
    _searchView.backgroundColor = [UIColor clearColor];
    [_searchView addSubview:[self textField]];
    [_searchView addSubview:[self createButton]];
    [self.navigationController.navigationBar addSubview:_searchView];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_searchView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self createTableView];
    
    [self requestBank];
}

- (void)createTableView {
    //table view
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight-kBottomSafeHeight) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
    
    if (@available(iOS 11.0, *)) {
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_showTag == 1) {
        return _headBankArray.count;
    }
    
    return _footBankArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *topCell = @"BankSelectTableViewCell";
    BankSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankSelectTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_showTag == 1) {
       cell.bankNameLabel.text = [[_headBankArray objectAtIndex:indexPath.row] objectForKey:@"fldExp"];
    }else{
        cell.bankNameLabel.text = [[[_footBankArray objectAtIndex:indexPath.row] objectForKey:@"cmmtbkin"] objectForKey:@"lbnkNm"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_showTag == 1) {
        
        if (_getHeadBankBlock) {
            _getHeadBankBlock([_headBankArray objectAtIndex:indexPath.row]);
        }
        
    }else{
        if (_getFootBankBlock) {
            _getFootBankBlock([[_footBankArray objectAtIndex:indexPath.row] objectForKey:@"cmmtbkin"]);
        }
    }
    
    [self popViewClick];
}



- (void)requestBank {
    
    _headBankArray = [[NSArray alloc] init];
    _footBankArray = [[NSArray alloc] init];
    [_myTableView reloadData];
    
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic;
    NSString *urlString;
    
    if (_showTag == 1) {
        urlString = pubthlp_bankList;
        parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                      [NSString stringWithFormat:@"%@",_headBankName],@"FLD_NM",
                      [NSString stringWithFormat:@"%@",_textField.text],@"SAERCH",
                      nil];
    }else{
        urlString = pubthlp_openBankList;
        parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                       [NSString stringWithFormat:@"%@",[_headBankDict objectForKey:@"fldVal"]],@"blbnkNo",
                      [NSString stringWithFormat:@"%@",[_proviceDict objectForKey:@"VALUE"]],@"provCd",
                      [NSString stringWithFormat:@"%@",_textField.text],@"SEARCH",
                      [NSString stringWithFormat:@"%@",[_cityDict objectForKey:@"VALUE"]],@"cityCd",
                      nil];
 
    }
    
    
    [YanNetworkOBJ postWithURLString:urlString parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            if (wSelf.showTag == 1) {
                wSelf.headBankArray = [responseObject objectForKey:@"rspData"];
                
            }else{
                wSelf.footBankArray = [responseObject objectForKey:@"rspData"];
            }
            
            wSelf.myTableView.delegate = self;
            wSelf.myTableView.dataSource = self;
            
            [wSelf.myTableView reloadData];
            
             wSelf.myTableView.ly_emptyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"emptycell.png"] titleStr:@"暂无消息…" detailStr:@""];
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
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
