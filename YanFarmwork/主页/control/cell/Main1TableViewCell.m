//
//  Main1TableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "Main1TableViewCell.h"

#import "GYRollingNoticeView.h"
#import "GYNoticeViewCell.h"

#import "MainCollectionViewCell.h"


@interface Main1TableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, GYRollingNoticeViewDelegate, GYRollingNoticeViewDataSource>

@property (retain, nonatomic) GYRollingNoticeView *noticeView;

@property (retain, nonatomic)NSArray *picArray, *nameArray;
@property (retain, nonatomic)UICollectionView *myCollection;
@property (retain, nonatomic)UICollectionViewFlowLayout *myCollectionViewLayout;

@end

@implementation Main1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headImage.layer.cornerRadius = 24;
    _headImage.layer.masksToBounds = YES;
    
    _middleView.layer.cornerRadius = 9;
//    _middleView.layer.masksToBounds = YES;
    
 

    [self addShadowToView:_middleView withColor:[UIColor colorWithHexString:@"#FAF3F4"]];
    
//    _middleView.layer.masksToBounds = YES;
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,3);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}




- (IBAction)moreAdvertisButton:(id)sender {
    if (_pressMoreAdvertis) {
        _pressMoreAdvertis(YES);
    }
}

- (void)createCell {
    
//    [self createCollectionViewFromView:_fourBtnView];
    
//    [_headImage sd_setImageWithURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/32fa828ba61ea8d3fcd2e9ce9e0a304e241f5803.jpg"] placeholderImage:[UIImage imageNamed:@"userLogo.png"] options:SDWebImageRefreshCached];
    
    NSLog(@"%@",[myData USR_NM]);
    NSLog(@"%@",[myData USR_OPR_MBL]);
    _nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@  %@",[myData USR_OPR_NM],[myData USR_LOGIN_MBL]];
    
    _todayMoneyLabel.text = [NSString stringWithFormat:@"%@",checkNull([_receiveDict objectForKey:@"BAL_AMT_DAY"])];
     _allMoneyLabel.text = [NSString stringWithFormat:@"%@",checkNull([_receiveDict objectForKey:@"BAL_AMT_MON"])];
    
    
    UITapGestureRecognizer *viewOneTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewOne.tag = 0;
    [_viewOne addGestureRecognizer:viewOneTouch];
    
    UITapGestureRecognizer *viewTwoTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewTwo.tag = 1;
    [_viewTwo addGestureRecognizer:viewTwoTouch];
    
    UITapGestureRecognizer *viewThreeTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewThree.tag = 2;
    [_viewThree addGestureRecognizer:viewThreeTouch];
    
    UITapGestureRecognizer *viewFourTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fourViewPress:)];
    _viewFour.tag = 3;
    [_viewFour addGestureRecognizer:viewFourTouch];
    
    
    _noticeArray = @[@"ccdcdcsdcsc",@"sdscdcsdcsdcsvrgbgsbfgng",@"234242423424324243423424424"];
    
    typeof(self)wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _advertisView
        wSelf.noticeView = [[GYRollingNoticeView alloc]initWithFrame:wSelf.advertisView.bounds];
        wSelf.noticeView.dataSource = self;
        wSelf.noticeView.delegate = self;
        [wSelf.advertisView addSubview:wSelf.noticeView];
        
        [wSelf.noticeView registerClass:[GYNoticeViewCell class] forCellReuseIdentifier:@"GYNoticeViewCell"];
        
        [wSelf.noticeView reloadDataAndStartRoll];
    });
    
}

- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
   return _noticeArray.count;
    
}
- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    // 普通用法，只有一行label滚动显示文字
    GYNoticeViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"GYNoticeViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _noticeArray[index]];
    cell.contentView.backgroundColor = [UIColor clearColor];
   
    return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    NSLog(@"点击的index: %lu", (unsigned long)index);
}









//4个按钮点击
- (void)fourViewPress:(UITapGestureRecognizer *)tapGestureRecognizer {
NSLog(@"4个按钮点击: %ld",(long)tapGestureRecognizer.view.tag);
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:tapGestureRecognizer.view.tag forKey:@"PUSHTAG"];
    
    if (_pressCollectionTag) {
        _pressCollectionTag((int)tapGestureRecognizer.view.tag);
    }

    
}

@end
