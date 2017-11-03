//
//  WDTradeChildViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTradeChildViewModel.h"
#import "WDTradeDataModel.h"

@interface WDTradeChildViewModel ()

@property (nonatomic,strong) NSArray *realArray;

@end

@implementation WDTradeChildViewModel

- (RACSubject *)dataSubject {
    if (!_dataSubject) {
        _dataSubject = [RACSubject subject];
    }
    return _dataSubject;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
//    [self getData];
}

- (void)getData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < self.dataArray.count - 1; i ++) {
        NSInteger index = i;
        
        if (i >= _index) {
            index += 1;
        }
        
        if (i == 0) {
            [self.dataSubject sendNext:@"reload"];
        }
        
        [WDWalletManager getPriceFromBaseCoin:self.dataArray[_index] quoteCoin:self.dataArray[index] withSuccess:^(NSDictionary *dic) {
            WDTradeDataModel *model = [WDTradeDataModel modelToDic:dic];
            
            [array addObject:model];
            
            if (array.count == self.dataArray.count - 1) {
                self.realArray = array;
                
                [self.dataSubject sendNext:array];
            }
        }];
    }
    
    
}

- (void)testGetData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < self.dataArray.count - 1; i ++) {
            NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            [self.dataSubject sendNext:[WDSocketBaseModel modelToDic:dic withDataModelTransFormName:@"WDTradeDataModel"].result];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.dataSubject sendCompleted];
        });
    });
}

@end
