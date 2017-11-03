//
//  WDBuy_SellBaseResultModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBuy_SellBaseResultModel.h"
#import "WDBuy_SellTableDataModel.h"
@implementation WDBuy_SellBaseResultModel
+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    //卖单
    if ([key isEqualToString:@"bids"]) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *dataArray = value;
        
        for (int i = 0; i < dataArray.count; i ++) {
            NSMutableDictionary *dic = [dataArray[i] mutableCopy];
            
            
            [dic setObject:@(NO) forKey:@"isSell"];
            [dic setObject:@(array.count + 1) forKey:@"count"];
            
            WDBuy_SellTableDataModel *model = [WDBuy_SellTableDataModel modelToDic:dic];
            
            if (i != 0) {
                WDBuy_SellTableDataModel *last = array.lastObject;
                
                if ([last.price isEqualToString:model.price]) {
                    last.amount = [NSString stringWithFormat:@"%.5f",[last.amount doubleValue] + [model.amount doubleValue]];
                    last.GMV = [NSString stringWithFormat:@"%.5f",[last.GMV doubleValue] + [model.GMV doubleValue]];
                }else {
                    if (array.count >= 5) {
                        break;
                    }
                    
                    [array addObject:model];
                }
            }else {
                [array addObject:model];
            }
        }
    
        _asks = array;
        
        return;
    //买单
    }else if ([key isEqualToString:@"asks"]) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *dataArray = value;
        
        for (int i = 0; i < dataArray.count; i ++) {
            NSMutableDictionary *dic = [dataArray[i] mutableCopy];
            
            
            [dic setObject:@(YES) forKey:@"isSell"];
            [dic setObject:@(dataArray.count < 5?(dataArray.count - i):(5 - i)) forKey:@"count"];
            
            WDBuy_SellTableDataModel *model = [WDBuy_SellTableDataModel modelToDic:dic];
            
            if (i != 0) {
                WDBuy_SellTableDataModel *last = array.firstObject;
                
                if ([last.price isEqualToString:model.price]) {
                    last.amount = [NSString stringWithFormat:@"%.5f",[last.amount doubleValue] + [model.amount doubleValue]];
                    last.GMV = [NSString stringWithFormat:@"%.5f",[last.GMV doubleValue] + [model.GMV doubleValue]];
                }else {
                    if (array.count >= 5) {
                        break;
                    }
                    
                    [array addObject:model];
                }
            }else {
                [array addObject:model];
            }
            
            array = [[array sortedArrayUsingComparator:^NSComparisonResult(WDBuy_SellTableDataModel *obj1, WDBuy_SellTableDataModel *obj2) {
                return [obj1.price doubleValue] < [obj2.price doubleValue];
            }] mutableCopy];
            
            for (int i = 0; i < array.count; i ++) {
                WDBuy_SellTableDataModel *last = array[i];
                
                last.count = array.count - i;               
            }
        }
    
        _bids = array;
        
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
