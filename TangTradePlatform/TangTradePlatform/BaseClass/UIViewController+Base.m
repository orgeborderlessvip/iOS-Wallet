//
//  UIViewController+Base.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/20.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "UIViewController+Base.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
#import "BaseTabBarViewController.h"
#import "WDNetworkManager.h"
#import "MMPickerView.h"


@implementation UIViewController (Base)

- (MBProgressHUD *)shareHud {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    MBProgressHUD *shareHud = [MBProgressHUD HUDForView:window];
    
    if (!shareHud) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        
        shareHud = [[MBProgressHUD alloc] initWithView:keyWindow];
        
        [keyWindow addSubview:shareHud];
        
        [shareHud hideAnimated:NO];
    }
    return shareHud;
}

+ (void)load {
    UIViewController *con = [UIViewController new];
    [con swizzleInstanceMethod:@selector(viewDidLoad) withMethod:@selector(hookViewDidLoad)];
    [con swizzleInstanceMethod:@selector(viewWillAppear:) withMethod:@selector(hookViewWillAppear:)];
    [con swizzleInstanceMethod:@selector(viewDidAppear:) withMethod:@selector(hookViewDidAppear:)];
    [con swizzleInstanceMethod:@selector(viewWillDisappear:) withMethod:@selector(hookViewWillDisappear:)];
    [con swizzleInstanceMethod:@selector(viewDidDisappear:) withMethod:@selector(hookViewDidDisappear:)];
}

- (void)hookViewDidLoad {
    [self hookViewDidLoad];
    
    if ([self respondsToSelector:@selector(languageSet)]) {
        [self performSelector:@selector(languageSet)];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageSet) name:changeLanguageNotification object:nil];
        
        @weakify(self);
        
        [[self rac_willDeallocSignal] subscribeNext:^(id x) {
            @strongify(self);
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:changeLanguageNotification object:nil];
        }];
    }
    
    if (![self judgeUse]) return;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)hookViewWillAppear:(BOOL)animated {
    [self hookViewWillAppear:animated];
    
    if (![self judgeUse]) return;
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)hookViewDidAppear:(BOOL)animated {
    [self hookViewDidAppear:animated];
    
    if (![self judgeUse]) return;
    
}

- (void)hookViewWillDisappear:(BOOL)animated {
    [self hookViewWillDisappear:animated];
    
    if (![self judgeUse]) return;
}

- (void)hookViewDidDisappear:(BOOL)animated {
    [self hookViewDidDisappear:animated];
    
    if (![self judgeUse]) return;
}



- (BOOL)judgeUse {
    static NSString *const fileName = @"controlProperty";
    
    static NSString *const contentName = @"useList";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSArray *array = dic[contentName];
    
    BOOL result = [array containsObject:NSStringFromClass([self class])];
    
    return result;
}

- (void)showHuDwith:(NSString *)title {
    
    [self.shareHud showAnimated:YES];
    
    self.shareHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    self.shareHud.label.text = WDLocalizedString(title);
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    
    [keyWindow bringSubviewToFront:self.shareHud];
}

- (void)showHuDwith:(NSString *)title duration:(NSTimeInterval)duration {
    [self showHuDwith:title];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hidenHUD];
    });
}

- (void)hidenHUD{
    [self.shareHud hideAnimated:YES];
}

+ (void)jumpToMainWithName:(NSString *)name password:(NSString *)password {
    [WDNetworkManager sharedInstance].userName = name;
    
    [WDNetworkManager sharedInstance].password = password;
    
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"kUserName"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"kPassword"];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[BaseTabBarViewController new]];
}

/**
 给view 加渐变色
 */
- (void)addChangeToView:(UIView *)view withDirection:(ChangeDirection)direction startColor:(UIColor *)startColor endColor:(UIColor *)endColor width:(CGFloat)width {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    
    switch (direction) {
        case ChangeDirectionUp_Down:
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
        case ChangeDirectionLeft_Right:
            gradientLayer.endPoint = CGPointMake(1.0, 0);
            break;
    }
    CGRect frame = view.bounds;
    frame.size.width = width;
    gradientLayer.frame = frame;
    [view.layer addSublayer:gradientLayer];
    gradientLayer.zPosition = -1;
}

- (void)addChangeToHeadView:(UIView *)headView {
    [self addChangeToView:headView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width];
}

+ (void)addCornerRadius:(CGFloat)radius toView:(UIView *)view {
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

- (void)showPickerIndexViewWithArr:(NSArray *)arr andSelectStr:(NSString *)str selectBolck:(void(^)(NSString *selectedString,NSInteger index))selectBolck{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *string in arr) {
        [array addObject:WDLocalizedString(string)];
    }
    
    [MMPickerView showPickerViewInView:self.view withStrings:array withOptions:@{MMbackgroundColor: RGBColor(238, 238, 238,1),MMtextColor: [UIColor blackColor],MMtoolbarColor: [UIColor whiteColor],MMbuttonColor: RGBColor(121, 121, 121,1),MMfont: [UIFont systemFontOfSize:18],MMvalueY: @3,MMselectedObject:str,MMtextAlignment:@1} completion:^(NSString *selectedString, NSInteger index) {
        selectBolck(selectedString,index);
    }];
}

@end