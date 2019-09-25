//
//  AreaPickerView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/25.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "AreaPickerView.h"

@interface AreaPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) UIPickerView *addresspPickerView;

@property (retain, nonatomic) NSArray *proviceArray, *cityArray;

@property (nonatomic) int proviceIndex, cityIndex;

@end

@implementation AreaPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createPickerView {
    _showTag = 1;
    [self requestProvice];
    
    
    typeof(self) wSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        wSelf.addresspPickerView = [[UIPickerView alloc] initWithFrame:wSelf.showPickerView.bounds];
        wSelf.addresspPickerView.delegate = self;
        wSelf.addresspPickerView.dataSource = self;
        //        _pickerView.showsSelectionIndicator = YES;
        [wSelf.showPickerView addSubview:wSelf.addresspPickerView];
    });
}
#pragma mark - dataSouce
//有几行
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
//行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _proviceArray.count;
    }
    return _cityArray.count;
}
//列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    if (component == 0) {
        return [[_proviceArray objectAtIndex:row] objectForKey:@"LABEL"];
    }
    return [[_cityArray objectAtIndex:row] objectForKey:@"LABEL"];;
}
// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _proviceIndex = (int)row;
        
        _cityArray = [[NSArray alloc] init];
        _cityIndex = 0;
        [_addresspPickerView reloadComponent:1];
        [self requestCity];
        
    }else if (component == 1) {
        _cityIndex = (int)row;
    }
}
















- (IBAction)AddressBtnClick:(id)sender {
    UIButton *button = (id)sender;

    if (button.tag == 1) {
        if (_cityArray.count == 0) {
            [ToolsObject showMessageTitle:@"请选择城市" andDelay:1 andImage:nil];
            return;
        }
        
        NSLog(@"%@----%@",[_proviceArray objectAtIndex:_proviceIndex],[_cityArray objectAtIndex:_cityIndex]);
        if (_selectProviceAndCityBlock) {
            _selectProviceAndCityBlock([_proviceArray objectAtIndex:_proviceIndex],[_cityArray objectAtIndex:_cityIndex]);
        }
    }
    
    
    [self removeFromSuperview];
}




- (void)requestProvice {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @"PROV",@"FLAG",
                      @"",@"SEARCH",
                      @"",@"VALUE",
                      nil];
    
    
    
    [YanNetworkOBJ postWithURLString:pubthlp_qryProvCity parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.proviceArray = [responseObject objectForKey:@"rspData"];
            
                [wSelf.addresspPickerView reloadComponent:0];
                
            
            if (wSelf.proviceIndex == 0) {
                [self requestCity];
            }
            
            
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

- (void)requestCity {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @"CITY",@"FLAG",
                      @"",@"SEARCH",
                      [NSString stringWithFormat:@"%@",[[_proviceArray objectAtIndex:_proviceIndex] objectForKey:@"VALUE"]],@"VALUE",
                      nil];

    
    
    [YanNetworkOBJ postWithURLString:pubthlp_qryProvCity parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.cityArray = [responseObject objectForKey:@"rspData"];
            
            [wSelf.addresspPickerView reloadComponent:1];
            
            
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
