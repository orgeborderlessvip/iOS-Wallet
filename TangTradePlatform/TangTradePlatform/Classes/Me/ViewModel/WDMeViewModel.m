//
//  WDMeViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMeViewModel.h"
#import "WDUploadGetHistoryModel.h"
#import "WDMeTransactionModel.h"
#import "WDNetworkManager.h"
@implementation WDMeViewModel

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
        
        [self.dataSubject sendNext:self.dataArray];
    }];
}


- (RACSubject *)dataSubject {
    if (!_dataSubject) {
        _dataSubject = [RACSubject subject];
    }
    return _dataSubject;
}

@end
