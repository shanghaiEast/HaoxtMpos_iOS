//
//  Main1TableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PressMoreAdvertis)(BOOL prsssBool);

typedef void(^PressCollectionTag)(int tag);

NS_ASSUME_NONNULL_BEGIN

@interface Main1TableViewCell : UITableViewCell


@property (copy, nonatomic) PressMoreAdvertis pressMoreAdvertis;

@property (copy, nonatomic) PressCollectionTag pressCollectionTag;


@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (weak, nonatomic) IBOutlet UIView *viewFour;



@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;

@property (weak, nonatomic) IBOutlet UIView *fourBtnView;


@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UILabel *todayMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;

@property (weak, nonatomic) IBOutlet UIView *advertisView;

- (IBAction)moreAdvertisButton:(id)sender;


@property (retain, nonatomic) NSArray *noticeArray;
- (void)createCell;


@end

NS_ASSUME_NONNULL_END
