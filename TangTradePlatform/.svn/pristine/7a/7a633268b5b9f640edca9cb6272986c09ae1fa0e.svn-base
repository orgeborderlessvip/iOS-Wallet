//
//  BaseTabBarViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "WDHomeViewController.h"
#import "WDMeViewController.h"
#import "WDChengDuiViewController.h"
#import "WDTradeViewController.h"
@interface BaseTabBarViewController ()<UserLanguageChange>

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation BaseTabBarViewController

- (NSArray *)dataArray {
    NSString *home = WDLocalizedString(@"首页");
    NSString *me = WDLocalizedString(@"我的");
    NSString *trade = WDLocalizedString(@"交易");
    NSString *chengDui = WDLocalizedString(@"承兑");
    _dataArray = @[home,trade,chengDui,me];
    return _dataArray;
}

- (void)languageSet {
    NSArray *imageArray = @[@"home",@"trade",@"chengDui",@"me"];
    
    for (int i = 0; i < self.viewControllers.count; i ++) {
        [self setName:self.dataArray[i] image:imageArray[i] toVC:self.viewControllers[i]];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageArray = @[@"home",@"trade",@"chengDui",@"me"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:[WDHomeViewController new]];
    
    [array addObject:[WDTradeViewController new]];
    
    [array addObject:[WDChengDuiViewController new]];
    
    [array addObject:[WDMeViewController new]];
    
    
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    for (int i = 0; i < array.count; i ++) {
        UIViewController *vc = array[i];
        
        [self setName:self.dataArray[i] image:imageArray[i] toVC:vc];
    }
    
    self.viewControllers = array;
}

- (void)setName:(NSString *)name image:(NSString *)image toVC:(UIViewController *)vc {
    vc.tabBarItem.title=name;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    UIImage *orign = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.image=[self scaleToSize:orign size:CGSizeMake(24, 24)];
    
    UIImage *imager = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",image]];
    
    UIImage *selected = [imager imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[self scaleToSize:selected size:CGSizeMake(24, 24)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBColor(0, 162, 242, 1),NSForegroundColorAttributeName,[UIFont systemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBColor(132, 158, 175, 1),NSForegroundColorAttributeName,[UIFont systemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
//    CGFloat titleTopMargin = (48 - 18) / 2 - 29;
    
//    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(12, titleTopMargin)];
    
//    CGFloat topMargin = (48  - 24) / 2 - 6;
//    CGFloat margin = 36;
    
//    vc.tabBarItem.imageInsets=UIEdgeInsetsMake(topMargin, -margin,-topMargin, margin);
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(newsize,NO,0.f);
    //    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
