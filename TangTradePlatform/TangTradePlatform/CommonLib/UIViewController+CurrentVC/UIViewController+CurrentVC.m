//
//  UIViewController+Utils.m
//  BankObject
//
//  Created by hanlu on 16/9/7.
//  Copyright © 2016年 袁伟森. All rights reserved.
//

#import "UIViewController+CurrentVC.h"

@implementation UIViewController (CurrentVC)
+(UIViewController *) findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
+(UIViewController *) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    viewController = [UIViewController findBestViewController:viewController];
    return viewController;
}

- (void)clearKeyBoard {
    [UIViewController clearKeyBoardToView:self.view];
}

+ (void)clearKeyBoardToView:(UIView *)view {
    for (UIView *item in view.subviews) {
        if ([item isKindOfClass:[UITextField class]] || [item isKindOfClass:[UITextView class]]) {
            UITextField *textField = (UITextField *)item;
            
            if (textField.isEditing) {
                [textField endEditing:YES];
                break;
            }
            
        }
        
        if (item.subviews.count) {
            [self clearKeyBoardToView:item];
        }
    }
}

+ (CGRect)relativeFrameForScreenWithView:(UIView *)v
{
    BOOL iOS7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7;
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (!iOS7) {
        screenHeight -= 20;
    }
    UIView *view = v;
    CGFloat x = .0;
    CGFloat y = .0;
    while (view.frame.size.width != 320 || view.frame.size.height != screenHeight) {
        x += view.frame.origin.x;
        y += view.frame.origin.y;
        
        if (!view.superview) break;
        view = view.superview;
        
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            x -= ((UIScrollView *) view).contentOffset.x;
            y -= ((UIScrollView *) view).contentOffset.y;
        }
    }
    return CGRectMake(x, y, v.frame.size.width, v.frame.size.height);
}

@end
