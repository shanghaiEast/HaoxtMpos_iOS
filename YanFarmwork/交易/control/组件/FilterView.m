//
//  FilterView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "FilterView.h"

@interface FilterView ()

//@property (retain, nonatomic) NSArray *stateArray, *typeArray;

@property (retain, nonatomic) UIView *myStateView, *myTypeView;

@property (nonatomic) int stateTag, typeTag;


@end

@implementation FilterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)createView{
    UIImageView *rightImageView = [[UIImageView alloc]init];
    rightImageView.image = [UIImage imageNamed:@"priceRMB.png"];
    [rightImageView setFrame:CGRectMake(0, 0, 30, 30)];
    rightImageView.contentMode = UIViewContentModeCenter;


    _minPrice.leftView = rightImageView;
    _minPrice.leftViewMode = UITextFieldViewModeAlways;
    _minPrice.layer.borderWidth = 1.0f;
    _minPrice.layer.borderColor = [[UIColor colorWithHexString:@"#C1C1C1"] CGColor];
    _minPrice.layer.masksToBounds = YES;

    
    UIImageView *rightImageView2 = [[UIImageView alloc]init];
    rightImageView2.image = [UIImage imageNamed:@"priceRMB.png"];
    [rightImageView2 setFrame:CGRectMake(0, 0, 30, 30)];
    rightImageView2.contentMode = UIViewContentModeCenter;
    _maxPrice.leftView = rightImageView2;
    _maxPrice.leftViewMode = UITextFieldViewModeAlways;
    _maxPrice.layer.borderWidth = 1.0f;
    _maxPrice.layer.borderColor = [[UIColor colorWithHexString:@"#C1C1C1"] CGColor];
    _maxPrice.layer.masksToBounds = YES;
    
    
    [self createStateBtn];
    [self createTypeBtn];
}

//靠边等距排列一行
- (void)createStateBtn{
    [_myStateView removeFromSuperview];
    _myStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-36, 40)];
    [_stateView addSubview:_myStateView];
    
    NSArray *stateArray = @[@"全选",@"成功",@"失败",@"未知"];
    float btnWidth = 60;
    float btnHeight = 30;
    float clearanceWidth = (_myStateView.frame.size.width-btnWidth*stateArray.count)/3;
    
    for (int i = 0; i < stateArray.count; i ++) {
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*i+btnWidth*i, 5, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[stateArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 2.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_stateTag == i) {
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FE4049"]];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        }
        [stateBtn addTarget:self action:@selector(stateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_myStateView addSubview:stateBtn];
        
        
    }
}

- (void)createTypeBtn{
    [_myTypeView removeFromSuperview];
    _myTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-36, 40)];
    [_typeView addSubview:_myTypeView];
    
    NSArray *stateArray = @[@"全选",@"刷卡",@"微信",@"支付宝"];
    float btnWidth = 60;
    float btnHeight = 30;
    float clearanceWidth = (_myTypeView.frame.size.width-btnWidth*stateArray.count)/3;
    
    for (int i = 0; i < stateArray.count; i ++) {
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*i+btnWidth*i, 5, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[stateArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 2.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_typeTag == i) {
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FE4049"]];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        }
        [stateBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_myTypeView addSubview:stateBtn];
        
        
    }
}


- (void)stateBtnClick:(UIButton *)button{
    _stateTag = (int)button.tag;
    [self createStateBtn];
}

- (void)typeBtnClick:(UIButton *)button{
    _typeTag = (int)button.tag;
    [self createTypeBtn];
}


- (IBAction)cancelOrConfirmBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        // 取消
        self.hidden = YES;
        
    }else{
        //确定
        
        if ([_maxPrice.text floatValue] < [_minPrice.text floatValue]) {
            [ToolsObject showMessageTitle:@"最低价格不能高于最高价格" andDelay:1 andImage:nil];
            return;
        }
        
        
        self.hidden = YES;
        
        if (_filtrBolck) {
            NSDictionary *dict = @{
                                   @"state":[NSString stringWithFormat:@"%d",_stateTag],
                                   @"type":[NSString stringWithFormat:@"%d",_typeTag],
                                   @"minPrice":[NSString stringWithFormat:@"%f",[_minPrice.text floatValue]],
                                   @"maxPrice":[NSString stringWithFormat:@"%f",[_maxPrice.text floatValue]]
                                   };
            _filtrBolck(dict);
        }
        
    }
}
@end
