//
//  WDOldUserViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/29.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOldUserViewModel.h"

#import "WDPasswordUserPrivateFileModel.h"
@implementation WDOldUserViewModel



- (void)clear {
    self.userName = @"";
    self.password = @"";
}

- (void)confirmPasswordWithSuccess:(void(^)())success {
    if (self.isPassword) {
        [WDWalletManager getKeyFromPassword:self.password success:^(NSDictionary *dic) {
            WDPasswordUserPrivateFileModel *model = [WDPasswordUserPrivateFileModel modelToDic:dic];
            
            [WDWalletManager addWithUserName:self.userName priKey:model.wif_priv_key success:^{
                [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"导入成功" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                    success();
                }];
            } failture:^(NSString *msg) {
                [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"用户名或密码不正确" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                    
                }];
            }];
        }];
    }else {
        [WDWalletManager addWithUserName:self.userName priKey:self.password success:^{
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"导入成功" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                success();
            }];
        } failture:^(NSString *msg) {
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"用户名或私钥不正确" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }];
    }
    
    
}

@end
