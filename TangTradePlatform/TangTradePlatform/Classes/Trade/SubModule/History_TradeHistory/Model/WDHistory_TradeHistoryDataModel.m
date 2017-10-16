//
//  WDHistory_TradeHistoryDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHistory_TradeHistoryDataModel.h"

@implementation WDHistory_TradeHistoryDataModel

+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        CGFloat amount = [_amount doubleValue];
        CGFloat price = [_price doubleValue];
        CGFloat value = [_value doubleValue];
        _amount = [NSString stringWithFormat:@"%.4f",amount];
        _price = [NSString stringWithFormat:@"%.4f",price];
        _value = [NSString stringWithFormat:@"%.4f",value];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
