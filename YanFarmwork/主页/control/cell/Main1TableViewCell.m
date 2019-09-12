//
//  Main1TableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "Main1TableViewCell.h"

#import "MainCollectionViewCell.h"


@interface Main1TableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

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
    _middleView.layer.masksToBounds = YES;
    
    //    [self addShadowToView:_fourBtnView withColor:MAINCOLOR];
    // 阴影颜色
    _fourBtnView.layer.shadowColor = MAINCOLOR.CGColor;
    // 阴影偏移，默认(0, -3)
    _fourBtnView.layer.shadowOffset = CGSizeMake(0,-3);
    // 阴影透明度，默认0
    _fourBtnView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    _fourBtnView.layer.shadowRadius = 10;
}



- (IBAction)moreAdvertisButton:(id)sender {
    if (_pressMoreAdvertis) {
        _pressMoreAdvertis(YES);
    }
}

- (void)createCell {
    
//    [self createCollectionViewFromView:_fourBtnView];
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/32fa828ba61ea8d3fcd2e9ce9e0a304e241f5803.jpg"] placeholderImage:[UIImage imageNamed:@"userLogo.png"] options:SDWebImageCacheMemoryOnly];
    
    
    
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
    
}

//4个按钮点击
- (void)fourViewPress:(UITapGestureRecognizer *)tapGestureRecognizer {
NSLog(@"4个按钮点击: %ld",(long)tapGestureRecognizer.view.tag);
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:tapGestureRecognizer.view.tag forKey:@"PUSHTAG"];
    
    if (_pressCollectionTag) {
        _pressCollectionTag((int)tapGestureRecognizer.view.tag);
    }

    
}

//- (void)createCollectionViewFromView:(UIView *)myView {
//
//    _picArray=@[@"row1.png",@"row2.png",@"row3.png",@"row4.png"];
//    _nameArray=@[@"普通收款",@"超级收款",@"二维码收款",@"闪付优惠"];
//
//    _myCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
//    [_myCollectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    _myCollectionViewLayout.minimumLineSpacing = 0.0f;
//    _myCollectionViewLayout.minimumInteritemSpacing = 0.0f;
//    _myCollectionViewLayout.itemSize = CGSizeMake(_fourBtnView.frame.size.width/4, 90);
//    //
//    [_myCollection removeFromSuperview];
//    _myCollection = [[UICollectionView alloc] initWithFrame:myView.bounds collectionViewLayout:_myCollectionViewLayout];
//    _myCollection.delegate = self;
//    _myCollection.dataSource = self;
//    _myCollection.allowsMultipleSelection = YES;
//    [_myCollection setBackgroundColor:[UIColor clearColor]];
//    _myCollection.showsHorizontalScrollIndicator = NO;
//    _myCollection.showsVerticalScrollIndicator = NO;
//    _myCollection.pagingEnabled = NO;
//    _myCollection.scrollEnabled = NO;
//
//
//    static NSString *cityHistoryCell = @"MainCollectionViewCell";
//    [_myCollection registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell];
//    [myView addSubview:_myCollection];
//}
//
//#pragma mark - UICollectionDelegate
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _picArray.count;
//}
////
////-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
////{
////    return CGSizeMake((_fourBtnView.frame.size.width)/4, 90);
////}
//
////-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
////{
////    return UIEdgeInsetsMake(0, 0, 0, 0);
////}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    static NSString *collectionID = @"MainCollectionViewCell";
//
//    MainCollectionViewCell *cell = (MainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
//
//    cell.imageView.image = [UIImage imageNamed:[_picArray objectAtIndex:indexPath.row]];
//    cell.titleLabel.text = [_nameArray objectAtIndex:indexPath.row];
//
//
//    return cell;
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (_pressCollectionTag) {
//        _pressCollectionTag(indexPath.row);
//    }
//
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
