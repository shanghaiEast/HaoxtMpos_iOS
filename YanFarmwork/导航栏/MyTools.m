//
//  MyTools.m
//  Parking
//
//  Created by 逸动 on 2017/8/22.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "MyTools.h"
#import "UIBarButtonItem+SXCreate.h"

@interface MyTools ()
{
    
}

@end

@implementation MyTools

+ (void)setViewController:(UIViewController *)viewController withNavigationBarColor:(UIColor *)BarColor andItem:(NSString *)itemString itemColor:(UIColor *)itemColor haveBackBtn:(BOOL)haveBtn withBackImage:(UIImage *)image withBackClickTarget:(id)target BackClickAction:(SEL)action
{
    
    UIColor * topleftColor = BarColor;
    UIColor * bottomrightColor = BarColor;
    UIImage * bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(ScreenWidth, [[UIApplication sharedApplication] statusBarFrame].size.height + viewController.navigationController.navigationBar.frame.size.height)];
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    viewController.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:bgImg];
    [viewController.navigationController.navigationBar setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
    viewController.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    UIColor *color = itemColor;
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    viewController.navigationController.navigationBar.titleTextAttributes = dict;
    [viewController.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium],NSForegroundColorAttributeName:color}];
    viewController.navigationItem.title = itemString;
  
    
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setFrame:CGRectMake(0, 0, 45, 38)];
//    [leftButton setImage:image forState:UIControlStateNormal];
//    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
//    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
//    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
//    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//
//
//    UIBarButtonItem *backBtnI = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    if (haveBtn == YES) {
//        viewController.navigationItem.leftBarButtonItems = @[backBtnI];
//    }
    

    if (haveBtn == YES) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:target action:action image:image];
    }else{
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:nil action:nil image:[UIImage new]];
    }
   

}


+ (UIImage *)imageWithImageString:(NSString *)imageUrl scaledToSize:(CGSize)newSize
{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    UIImage *image = [UIImage imageWithData:data];
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.8);
    
    return newImage;
}



@end
