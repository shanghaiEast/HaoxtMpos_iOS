//
//  TradingViewController.m
//  YanFarmwork
//
//  Created by 国时 on 2019/4/12.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TradingViewController.h"

#import "TradingTableViewCell.h"

#import "TradDetailTableViewController.h"

#import "FilterView.h"
#import "TimeView.h"



@interface TradingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int page;
@property (retain, nonatomic) UIButton *leftBtn;

@property (retain, nonatomic) FilterView *filterView;
@property (retain, nonatomic) TimeView *timeView;

@end

@implementation TradingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"交易查询" itemColor:BLACKCOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:nil];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTableView];
}

- (void)createTableView {
    //table view
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight-kNavBarHAbove7) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor clearColor];
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
    
//    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
    
    [self refreshTableView];
    
}
#pragma mark  -----  Refresh
-(void)refreshTableView
{
    [self refreshHeader];
}
- (void)refreshHeader
{
    _page = 1;
    
    [self mjRefreshStopWhenTen];
}
- (void)upDown
{
    _page ++;
    
    [self mjRefreshStopWhenTen];
}
- (void)tableEndRefresh
{
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}
- (void)mjRefreshStopWhenTen
{
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf.myTableView.mj_header endRefreshing];
        [wSelf.myTableView.mj_footer endRefreshing];
    });
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 72;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    headView.backgroundColor = [UIColor whiteColor];
    
    CGSize timeSize = [ToolsObject getText:[NSString stringWithFormat:@"%@  %@",[self dateToday],[self dateToday]] withTextSize:CGSizeMake(200, 28) withTextFont:14];
    
    float leftBtnWidth = timeSize.width+20;
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setFrame:CGRectMake(15, 13, leftBtnWidth, 28)];
    [_leftBtn setTitle:[NSString stringWithFormat:@"%@  %@",[self dateToday],[self dateToday]] forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_leftBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [_leftBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_leftBtn setImage:[UIImage imageNamed:@"downTriangle.png"] forState:UIControlStateNormal];
    [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(12, leftBtnWidth-8-7, 12, 8)];
    [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 14)];
    _leftBtn.layer.cornerRadius = 14;
    _leftBtn.layer.masksToBounds =YES;
    _leftBtn.tag = 0;
    [_leftBtn addTarget:self action:@selector(selectTimeAndfilter:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_leftBtn];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(ScreenWidth-50-15, 13, 53, 28)];
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [rightBtn setImage:[UIImage imageNamed:@"downTriangle.png"] forState:UIControlStateNormal];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(12, 50-5-7, 12, 5)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 14)];
    rightBtn.layer.cornerRadius = 14;
    rightBtn.layer.masksToBounds =YES;
    rightBtn.tag = 1;
    [rightBtn addTarget:self action:@selector(selectTimeAndfilter:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightBtn];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0,53,ScreenWidth,1);
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#979797"];
    lineLabel.alpha = 0.2;
    [headView addSubview:lineLabel];
    
    return headView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"TradingTableViewCell";
    TradingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TradDetailTableViewController *detailVC = [[TradDetailTableViewController alloc] initWithNibName:@"TradDetailTableViewController" bundle:nil];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.detailDict = [NSDictionary new];
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *)dateToday {
    //将日期转换成需要的样式
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    NSString *dateString = [YMD stringFromDate:date];
    
    NSLog(@"时间：%@",dateString);
    
    return dateString;
}

- (void)selectTimeAndfilter:(UIButton *)button{
    if (button.tag == 0) {
        //time
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _timeView = [[[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil] lastObject];
        [_timeView setFrame:app.window.bounds];
        [_timeView createView];
        [app.window addSubview:_timeView];
        _timeView.timeBolck = ^(NSDictionary * _Nonnull dict) {
            NSLog(@"返回的数据：%@",dict);
            
            [_leftBtn setTitle:[NSString stringWithFormat:@"%@  %@",[dict objectForKey:@"startTime"],[dict objectForKey:@"endTime"]] forState:UIControlStateNormal];
        };
        
    }else{
        //filter
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _filterView = [[[NSBundle mainBundle] loadNibNamed:@"FilterView" owner:self options:nil] lastObject];
        [_filterView setFrame:app.window.bounds];
        [_filterView createView];
        [app.window addSubview:_filterView];
        _filterView.filtrBolck = ^(NSDictionary * _Nonnull dict) {
            NSLog(@"返回的数据：%@",dict);
        };
    }
}

@end
