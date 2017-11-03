//
//  WDTradeViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTradeViewModel.h"
#import "WDTradeCoinKindLabelModel.h"

#import "WDSendOutViewModel.h"
#import "WDHomeTableDataModel.h"
@implementation WDTradeViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self getData];
    }
    return self;
}

- (void)getData {
    [WDSendOutViewModel loadCoinDataWithShowBDS:NO Success:^(NSArray<WDHomeTableDataModel *> *dataArray) {
        NSMutableArray *marray = [NSMutableArray array];
        
        for (WDHomeTableDataModel *model in dataArray) {
            [marray addObject:model.coinName];
        }
        self.allInfoArray = dataArray;
        
        self.dataArray = marray;
    }];
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
