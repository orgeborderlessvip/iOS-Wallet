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
    //买单
    if ([key isEqualToString:@"bids"]) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *dataArray = value;
        
        for (int i = 0; i < dataArray.count; i ++) {
            NSMutableDictionary *dic = [dataArray[i] mutableCopy];
            
            [dic setObject:@(NO) forKey:@"isSell"];
            [dic setObject:@(i + 1) forKey:@"count"];
            
            [array addObject:[WDBuy_SellTableDataModel modelToDic:dic]];
        }
    
        _bids = array;
        
        return;
    //卖单
    }else if ([key isEqualToString:@"asks"]) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *dataArray = value;
        
        for (int i = 0; i < dataArray.count; i ++) {
            NSMutableDictionary *dic = [dataArray[i] mutableCopy];
            
            [dic setObject:@(YES) forKey:@"isSell"];
            [dic setObject:@(5 - i) forKey:@"count"];
            
            [array addObject:[WDBuy_SellTableDataModel modelToDic:dic]];
        }
    
        _asks = array;
        
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
