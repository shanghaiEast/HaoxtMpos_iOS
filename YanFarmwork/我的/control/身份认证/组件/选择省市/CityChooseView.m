//
//  CityChooseView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/20.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "CityChooseView.h"

@interface CityChooseView () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSArray *proviceArray, *cityArray;



@end

@implementation CityChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView{
    
    _BGView.userInteractionEnabled = YES;
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forRemoveView)];
    [_BGView addGestureRecognizer:touch];
    
    _myTableView.backgroundColor = [UIColor clearColor];
//    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    
    [self requestProviceOrCity];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_showTag == 1) {
        return _proviceArray.count;
    }
    
    return _cityArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (_showTag == 1) {
        return 40;
    }
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *topCell = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_showTag == 1) {
        cell.textLabel.text = [[_proviceArray objectAtIndex:indexPath.row] objectForKey:@"LABEL"];
    }else{
        cell.textLabel.text = [[_cityArray objectAtIndex:indexPath.row] objectForKey:@"LABEL"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_showTag == 1) {
        
        if (_getProviceBlock) {
            _getProviceBlock([_proviceArray objectAtIndex:indexPath.row]);
        }
        
    }else{
        if (_getCityBlock) {
            _getCityBlock([_cityArray objectAtIndex:indexPath.row]);
        }
    }
}

- (void)forRemoveView {
 
    [self setHidden:YES];
    [self removeFromSuperview];
}

- (void)requestProviceOrCity {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic;
    if (_showTag == 1) {
        parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @"PROV",@"FLAG",
                      @"",@"SEARCH",
                      @"",@"VALUE",
                      nil];
    }else{
        parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @"AREA",@"FLAG",
                      @"",@"SEARCH",
                      [NSString stringWithFormat:@"%@",[_proviceDict objectForKey:@"VALUE"]],@"VALUE",
                      nil];
    }
   
    
    [YanNetworkOBJ postWithURLString:pubthlp_qryProvCity parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            if (wSelf.showTag == 1) {
                _proviceArray = [responseObject objectForKey:@"rspData"];
                
            }else{
                 _cityArray = [responseObject objectForKey:@"rspData"];
            }
            
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
