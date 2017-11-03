//
//  WDMyTradeRecordViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/29.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMyTradeRecordViewModel.h"
#import "WDMeTransactionModel.h"
@implementation WDMyTradeRecordViewModel

- (void)loadData {
    [WDWalletManager getAccountHistoryWithSuccess:^(NSArray *array) {
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            NSString *string = dic[@"description"];
            
            if ([string hasPrefix:@"Transfer"]) {
                [dataArray addObject:[WDMeTransactionModel modelToString:string]];
            }
        }
        
        self.dataArray = dataArray;
    }];
}



@end
