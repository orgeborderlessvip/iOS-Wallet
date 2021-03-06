//
//  UIAlertController+ShowAlert.m
//  FlbCartercoin
//
//  Created by ctcios2 on 2017/7/13.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import "UIAlertController+ShowAlert.h"

@implementation UIAlertController (ShowAlert)

+ (void)showAlert:(BOOL)alert fromVC:(UIViewController *)vc withTitle:(NSString *)title message:(NSString *)message withButtonTitle:(NSArray<__kindof NSString *> *)titleArray clickAction:(void (^)(NSInteger, NSString *))clickAction {
    
    title = WDLocalizedString(title);
    message = WDLocalizedString(message);
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(alert?UIAlertControllerStyleAlert:UIAlertControllerStyleActionSheet)];
    
    for (int i = 0; i < titleArray.count; i ++) {
        NSString *confirm = WDLocalizedString(titleArray[i]);
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:confirm style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            clickAction(i,titleArray[i]);
        }];
        
        [alertVC addAction:action];
    }
    
    [vc presentViewController:alertVC animated:YES completion:^{
        
    }];
}



@end
