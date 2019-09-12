//
//  TimeView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TimeView.h"

@interface TimeView ()

//@property (retain, nonatomic) NSArray *stateArray, *typeArray;

@property (retain, nonatomic) UIDatePicker * datePicker;


@end

@implementation TimeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)createView{
    
    [_leftTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    _leftTimeBtn.selected = YES;
    _leftLabel.backgroundColor = MAINCOLOR;
    
    [_rightTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    _rightTimeBtn.selected = NO;
    _rightLabel.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    
    
    [self createDateView];
}

- (void)createDateView{
    _datePicker = [[UIDatePicker alloc]
                   initWithFrame:CGRectMake(0, 0, ScreenWidth, 194)];
    _datePicker.locale= [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = [UIColor whiteColor];
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [_dateView addSubview:_datePicker];
    
    
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    date = [formatter dateFromString:@"2000-01-01"];
    
    _datePicker.minimumDate = date;
    _datePicker.maximumDate= [NSDate date];//今天
}

- (NSString *)dateToday {
    //将日期转换成需要的样式
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    NSString *dateString = [YMD stringFromDate:date];
    
    NSLog(@"时间：%@",dateString);
    
    return dateString;
}


- (void)dateChanged:(UIDatePicker*)sender {
    //将日期转换成需要的样式
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [YMD stringFromDate:_datePicker.date];
    
    NSLog(@"时间：%@",dateString);
    
    if (_leftTimeBtn.selected == YES) {
         [_leftTimeBtn setTitle:dateString forState:UIControlStateNormal];
        
        //n不能小于当前日期
//        _datePicker.minimumDate = _datePicker.date;
        
    }
    if (_rightTimeBtn.selected == YES) {
        [_rightTimeBtn setTitle:dateString forState:UIControlStateNormal];
        
    }
    
}

-(BOOL)dateCompare
{
    NSString *startDateString = _leftTimeBtn.currentTitle;
    NSString *endDateString = _rightTimeBtn.currentTitle;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startDate=[formatter dateFromString:startDateString];
    NSDate *endDate=[formatter dateFromString:endDateString];
    NSComparisonResult result=[endDate compare:startDate];
    
    switch (result) {
        case NSOrderedAscending: {
            NSLog(@"FlyElephant:%@--时间小于---%@",startDate,endDate);
            break;
            
            return NO;
        }
        case NSOrderedSame: {
            NSLog(@"FlyElephant:%@--时间等于---%@",startDate,endDate);
            
            return YES;
            
            break;
        }
        case NSOrderedDescending: {
            NSLog(@"FlyElephant:%@--时间大于---%@",startDate,endDate);
            
            return YES;
            
            break;
        }
    }
    
    return NO;
}

- (IBAction)timeBtnClick:(id)sender {
    UIButton *button = (id)sender;
    
    if (button.tag == 0) {
        //起始时间
        _leftTimeBtn.selected = YES;
        _leftLabel.backgroundColor = MAINCOLOR;
        
        _rightTimeBtn.selected = NO;
        _rightLabel.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        
    }else{
        //结束时间
        _leftTimeBtn.selected = NO;
        _leftLabel.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        
        _rightTimeBtn.selected = YES;
        _rightLabel.backgroundColor = MAINCOLOR;
        
    }
}

- (IBAction)cancelOrConfirmBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        // 取消
        self.hidden = YES;
        
    }else{
        //确定
        if ([self dateCompare] == NO) {
            [ToolsObject showMessageTitle:@"起始时间不能小于结束时间" andDelay:1.0 andImage:nil];
            
            return;
        }
        
        
        self.hidden = YES;
        
        if (_timeBolck) {
            NSDictionary *dict = @{
                                   @"startTime":[NSString stringWithFormat:@"%@",_leftTimeBtn.currentTitle],
                                    @"endTime":[NSString stringWithFormat:@"%@",_rightTimeBtn.currentTitle]
                                   };
            _timeBolck(dict);
        }
        
    }
}


@end
