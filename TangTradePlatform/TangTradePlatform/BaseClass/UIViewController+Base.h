//
//  UIViewController+Base.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/20.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
typedef NS_ENUM(NSInteger,ChangeDirection) {
    ChangeDirectionLeft_Right,
    ChangeDirectionUp_Down,
};

#define changeLanguageNotification @"ChangeLanguageNotification"

@protocol UserLanguageChange <NSObject>

- (void)languageSet;

@end

@interface UIViewController (Base)

- (MBProgressHUD *)shareHud;

- (void)showHuDwith:(NSString *)title;

- (void)showHuDwith:(NSString *)title duration:(NSTimeInterval)duration;

- (void)hidenHUD;

+ (void)jumpToMainWithName:(NSString *)name password:(NSString *)password;

- (void)addChangeToView:(UIView *)view withDirection:(ChangeDirection)direction startColor:(UIColor *)startColor endColor:(UIColor *)endColor width:(CGFloat)width;

- (void)addChangeToHeadView:(UIView *)headView;

+ (void)addCornerRadius:(CGFloat)radius toView:(UIView *)view;

- (void)showPickerIndexViewWithArr:(NSArray *)arr andSelectStr:(NSString *)str selectBolck:(void(^)(NSString *selectedString,NSInteger index))selectBolck;

- (void)showPickerIndexViewWithUseLanguage:(BOOL)use arr:(NSArray *)arr andSelectStr:(NSString *)str selectBolck:(void (^)(NSString *selectedString, NSInteger index))selectBolck;

- (void)showPickerIndexViewToBaseWindowWithUseLanguage:(BOOL)use arr:(NSArray *)arr andSelectStr:(NSString *)str selectBolck:(void (^)(NSString *selectedString, NSInteger index))selectBolck;

- (void)setWithTextField:(UITextField *)textField toImageView:(UIImageView *)imageView;

+ (void)setWithCoin:(NSString *)coin toLabel:(UILabel *)label withFont:(UIFont *)font toFont:(UIFont *)toFont;

+ (void)setWithBase:(NSString *)base quote:(NSString *)quote toLabel:(UILabel *)label withFont:(UIFont *)font toFont:(UIFont *)toFont;

+ (void)setWithBase:(NSString *)base quote:(NSString *)quote withMinString:(NSString *)minString toLabel:(UILabel *)label withFont:(UIFont *)font toFont:(UIFont *)toFont;

@end
