//
//  WxAndZfbTableViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "WxAndZfbTableViewController.h"

#import "POSCollectionViewController.h"

#import "WxAndZfbTableViewCell.h"
#import "OrdinaryTableViewCell.h"
#import "ConfirmView.h"
#import "QrCodeTableViewController.h"

@interface WxAndZfbTableViewController ()

@property (nonatomic) int payWayTag;
@property (retain, nonatomic) ConfirmView *confirmView;

@end

@implementation WxAndZfbTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"" itemColor:WHITECOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.bounces = NO;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_processTag == 0) {
        if ((ScreenHeight-kNavBarHAbove7)<417) {
            
            return 417;
        }
    }
    if ((ScreenHeight-kNavBarHAbove7)<450) {
        
        return 450;
    }
    
    tableView.scrollEnabled = NO;
    return ScreenHeight-kNavBarHAbove7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //确定
    if (_processTag != 0) {
        static NSString *cellStr = @"WxAndZfbTableViewCell";
        WxAndZfbTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellStr owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell createCell];
        
        
        __weak typeof(self) wSelf = self;
        cell.chooseBankBlock = ^(BOOL chooseBankBool) {
            NSLog(@"选择银行");
        };
        cell.payWayBlock = ^(int payWaytag) {
            NSLog(@"选择支付方式");
            wSelf.payWayTag = payWaytag;
        };
        cell.saveMoneyBlock = ^(NSDictionary *dict) {
            NSLog(@"确定收款");
            if ([cell.moneyNumber.text floatValue] == 0) {
                [ToolsObject showMessageTitle:@"请输入付款金额" andDelay:1 andImage:nil];
                
                return ;
            }
            if (wSelf.confirmView == nil) {
                wSelf.confirmView = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmView" owner:self options:nil] lastObject];
                [wSelf.confirmView setFrame:self.tableView.bounds];
                wSelf.confirmView.payType = wSelf.payWayTag;
                wSelf.confirmView.moneyString = [NSString stringWithFormat:@"%@",cell.moneyNumber.text];
                [wSelf.confirmView createView];
                [tableView addSubview:wSelf.confirmView];
                
                wSelf.confirmView.btnClickBlock = ^(int btnTag) {
                    wSelf.confirmView.hidden = YES;
                    if (btnTag == 1) {
                        QrCodeTableViewController *qrCodeVC = [[QrCodeTableViewController alloc] initWithNibName:@"QrCodeTableViewController" bundle:nil];
                        qrCodeVC.hidesBottomBarWhenPushed = YES;
                        qrCodeVC.payWayTag = wSelf.payWayTag;
                        qrCodeVC.processTag = wSelf.processTag;
                        qrCodeVC.moneyString = cell.moneyNumber.text;
                        [self.navigationController pushViewController:qrCodeVC animated:YES];
                    }else{
                        //取消
                    }
                };
            }else{
                wSelf.confirmView.payType = wSelf.payWayTag;
                [wSelf.confirmView createView];
                wSelf.confirmView.hidden = NO;
            }
            
            
            
        };
        
        return cell;
        
    }else{
        static NSString *cellStr = @"OrdinaryTableViewCell";
        OrdinaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellStr owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        [cell createCell];
        
        
        __weak typeof(self) wSelf = self;
        cell.chooseBankBlock = ^(BOOL chooseBankBool) {
            NSLog(@"选择银行");
        };
        cell.payWayBlock = ^(int payWaytag) {
            NSLog(@"选择支付方式");
            wSelf.payWayTag = payWaytag;
        };
        cell.saveMoneyBlock = ^(NSDictionary *dict) {
            NSLog(@"确定收款");
            if ([cell.moneyNumber.text floatValue] == 0) {
                [ToolsObject showMessageTitle:@"请输入付款金额" andDelay:1 andImage:nil];
                
                return ;
            }
            if (wSelf.confirmView == nil) {
                wSelf.confirmView = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmView" owner:self options:nil] lastObject];
                [wSelf.confirmView setFrame:self.tableView.bounds];
                wSelf.confirmView.payType = wSelf.payWayTag;
                wSelf.confirmView.moneyString = [NSString stringWithFormat:@"%@",cell.moneyNumber.text];
                [wSelf.confirmView createView];
                [tableView addSubview:wSelf.confirmView];
                
                wSelf.confirmView.btnClickBlock = ^(int btnTag) {
                    wSelf.confirmView.hidden = YES;
                    if (btnTag == 1) {
                        POSCollectionViewController *posVC = [[POSCollectionViewController alloc] initWithNibName:@"POSCollectionViewController" bundle:nil];
                        posVC.hidesBottomBarWhenPushed = YES;
                        posVC.processTag = _processTag;
                        posVC.moneyString = cell.moneyNumber.text;
                        [self.navigationController pushViewController:posVC animated:YES];
                    }else{
                        //取消
                    }
                };
            }else{
                wSelf.confirmView.payType = wSelf.payWayTag;
                [wSelf.confirmView createView];
                wSelf.confirmView.hidden = NO;
            }
            
            
            
        };
        
        return cell;
    }
   
    return [UITableViewCell new];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
