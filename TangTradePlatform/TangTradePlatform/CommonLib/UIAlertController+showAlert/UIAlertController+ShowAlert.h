//
//  UIAlertController+ShowAlert.h
//  FlbCartercoin
//
//  Created by ctcios2 on 2017/7/13.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ShowAlert)

+ (void)showAlert:(BOOL)alert fromVC:(UIViewController *)vc withTitle:(NSString *)title message:(NSString *)message withButtonTitle:(NSArray <__kindof NSString *>*)titleArray clickAction:(void(^)(NSInteger index,NSString *title))clickAction;

@end
