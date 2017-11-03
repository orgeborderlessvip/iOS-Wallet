//
//  WDCreatAccountViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDCreatAccountViewModel.h"

@implementation WDCreatAccountViewModel

- (void)creatAccount {
    [WDWalletManager registerUserWithName:self.userName success:^{
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"注册成功" message:@"" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            [[UIViewController currentViewController].navigationController popViewControllerAnimated:YES];
        }];
    } error:^(NSString *msg) {
        if ([msg rangeOfString:@"current_account_itr == acnt_indx"].location != NSNotFound) {
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"账户名已存在" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }
        
        if ([msg rangeOfString:@"itr->get_balance() >= -delta"].location != NSNotFound) {
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"账户余额不足" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }
    }];
}

@end
