//
//  WDHistory_TradeHistoryViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHistory_TradeHistoryViewModel.h"
#import "WDBuy_SellBaseResultModel.h"

@implementation WDHistory_TradeHistoryViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self testGetData];
    }
    return self;
}

- (void)testGetData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"history_Trade_History" ofType:@"json"]];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = [WDSocketBaseModel modelToDic:dic withDataModelTransFormName:@"WDHistory_TradeHistoryDataModel"].result;
    });
}

@end
