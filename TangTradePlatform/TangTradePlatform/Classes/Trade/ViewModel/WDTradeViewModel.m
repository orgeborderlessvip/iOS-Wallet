//
//  WDTradeViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTradeViewModel.h"
#import "WDTradeCoinKindLabelModel.h"
@implementation WDTradeViewModel

- (instancetype)init {
    if (self = [super init]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self testGetData];
        });
    }
    return self;
}

- (void)testGetData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"trade_test" ofType:@"json"]];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
    NSArray *array = [WDSocketBaseModel modelToDic:dic withDataModelTransFormName:@"WDTradeCoinKindLabelModel"].result;
    
    NSMutableArray *marray = [NSMutableArray array];
    
    for (WDTradeCoinKindLabelModel *model in array) {
        [marray addObject:model.symbol];
    }
    
    self.dataArray = marray;
}



@end