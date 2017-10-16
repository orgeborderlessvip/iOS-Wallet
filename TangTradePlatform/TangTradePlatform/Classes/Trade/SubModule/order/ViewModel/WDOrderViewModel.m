//
//  WDOrderViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOrderViewModel.h"
#import "WDOrderTableDataModel.h"
@implementation WDOrderViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self testGetData];
    }
    return self;
}

- (void)testGetData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++) {
        WDOrderTableDataModel *mdoel = [WDOrderTableDataModel new];
        
        mdoel.price = @"4388.6842";
        mdoel.coinAmount = @"0.08M";
        mdoel.coinTotalAmount = @"30.1k";
        mdoel.riseTime = @"2017/12/27 11:29:01";
        mdoel.operationState = 0;
        
        [array addObject:mdoel];
    }
    
    self.dataBuyArray = array;
    self.dataSellArray = array;
}

@end
