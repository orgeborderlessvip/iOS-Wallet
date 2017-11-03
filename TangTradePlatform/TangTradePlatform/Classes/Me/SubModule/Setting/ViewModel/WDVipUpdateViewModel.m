//
//  WDVipUpdateViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDVipUpdateViewModel.h"
#import "WDVipFeeModel.h"

#import "WDSendOutViewModel.h"
#import "WDHomeTableDataModel.h"
@implementation WDVipUpdateViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isVip = [WDWalletManager selectedModel].isLifeTime;
        
        [self getFee];
        [self getMyMoney];
        
        
    }
    return self;
}

- (void)getFee {
    [WDWalletManager getFeeWithKind:account_upgrade success:^(NSDictionary *result) {
        WDVipFeeModel *model = [WDVipFeeModel modelToDic:result];
        
        self.updateFee = model.membership_lifetime_fee;
    }];
}

- (void)getMyMoney {
    [WDSendOutViewModel loadMyDataWithSuccess:^(NSArray *dataArray) {
        for (WDHomeTableDataModel *data in dataArray) {
            if ([data.coinName isEqualToString:@"BDS"]) {
                self.myAmount = [data.coinPrice doubleValue];
                break;
            }
        }
    } error:^{
        
    }];
}

- (void)clickUpdate {
    if ([WDWalletManager selectedModel].isLifeTime) {
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"账户已经是终身会员" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            self.isVip = YES;
        }];
    }else {
        [WDWalletManager updateVipWithsuccess:^{
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"升级成功" message:nil withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                self.isVip = YES;
                [WDWalletManager selectedModel].isLifeTime = YES;
            }];
        }error:^(NSString *msg) {
            BOOL amount = [msg rangeOfString:@"itr->get_balance()"].location != NSNotFound || [msg rangeOfString:@"delta.amount > 0"].location != NSNotFound;
            
            BOOL account = [msg rangeOfString:@"account_obj.is_lifetime_member()"].location != NSNotFound;
            
            NSString *rel = nil;
            
            if (amount) {
                rel = WDLocalizedString(@"账户余额不足");
            }
            
            if (account) {
                rel = WDLocalizedString(@"账户已经是终身会员");
                self.isVip = YES;
                [WDWalletManager selectedModel].isLifeTime = YES;
                
                [WDWalletManager saveCurrentWithSuccess:^{
                    
                }];
            }
            
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:rel withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }];
    }
    
    
    
}

@end
