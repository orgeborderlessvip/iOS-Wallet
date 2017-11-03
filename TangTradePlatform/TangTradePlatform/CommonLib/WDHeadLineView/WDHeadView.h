//
//  WDHeadView.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDHeadView : UIView

@property (nonatomic,strong) NSArray <NSString *>*dataArray;

@property (nonatomic,strong) UIColor *lineColor;

@property (nonatomic,copy) void (^touchBlock) (NSInteger selectedIndex);

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) CGFloat lineHeight;

@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,assign) NSInteger numberOfItemInScreen;

@property (nonatomic,assign) BOOL showSymbol;

- (void)setCenterPercent:(CGFloat)centerPercent withUsrSelected:(BOOL)usrSelected;

@end
