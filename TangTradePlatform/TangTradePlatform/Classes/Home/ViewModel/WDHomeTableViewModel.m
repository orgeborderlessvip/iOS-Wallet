//
//  WDHomeTableView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHomeTableViewModel.h"
#import "WDHomeTableDataModel.h"
#import "WDSendOutViewModel.h"
@interface WDHomeTableViewModel ()



@end

@implementation WDHomeTableViewModel

- (void)loadMoreData {
    [WDSendOutViewModel loadMyDataWithSuccess:^(NSArray *dataArray) {
        _dataArray = dataArray;
        
        [self.dataSubject sendNext:dataArray];
    } error:^{
        
    }];
    
//    [WDSendOutViewModel loadMyDataWithSuccess:^(CGFloat haveAmount, NSString *coinKind) {
//        NSArray *testArray = @[coinKind,@"CNY",@"USD",@"BTC",@"ETH"];
//        NSArray *test1Array = @[[NSString stringWithFormat:@"%.5f",haveAmount],@"0.00000",@"0.00000",@"0.00000",@"0.00000"];
//        NSMutableArray *array = [NSMutableArray arrayWithCapacity:testArray.count];
//        for (int i = 0; i < testArray.count; i ++) {
//            [array addObject:({
//                WDHomeTableDataModel *data = [WDHomeTableDataModel new];
//                
//                data.coinName = testArray[i];
//                
//                data.coinPrice = test1Array[i];
//                
//                data;
//            })];
//        }
//        
//        _dataArray = array;
//        
//        [self.dataSubject sendNext:array];
//    } error:^{
//        
//    }];
}

- (RACSubject *)dataSubject {
    if (!_dataSubject) {
        _dataSubject = [RACSubject subject];
    }
    return _dataSubject;
}

@end
