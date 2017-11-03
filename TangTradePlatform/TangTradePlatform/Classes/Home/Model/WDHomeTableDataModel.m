//
//  WDHomeTableDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHomeTableDataModel.h"

@interface WDHomeTableDataModel ()

@property (nonatomic,copy) NSString *bitasset_data_id;

@property (nonatomic,strong) NSDictionary *core_exchange_rate;

@end

@implementation WDHomeTableDataModel

+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        if (_coinPrice.length == 0) {
            _coinPrice = @"0.00000";
        }
        
        if (_bitasset_data_id.length != 0 || [_coinName isEqualToString:@"CNY"] || [_coinName isEqualToString:@"USD"]) {
            _isSmart = YES;
        }
        
        NSDictionary *base = _core_exchange_rate[@"base"];
        NSDictionary *quote = _core_exchange_rate[@"quote"];
        NSString *base_id = base[@"asset_id"];
        CGFloat baseAmount = [base[@"amount"] doubleValue];
        CGFloat quoteAmount = [quote[@"amount"] doubleValue];
        
        if ([self.asset_id isEqualToString:base_id]) {
            _rate = (baseAmount / pow(10, self.precision)) / (quoteAmount / pow(10, 5));
        }else {
            _rate = (quoteAmount / pow(10, self.precision)) / (baseAmount / pow(10, 5));
        }
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"amount"]) {
        if (self.precision != 0) {
            _coinPrice = [NSString stringWithFormat:@"%.5f",[value doubleValue] / pow(10.0, self.precision)];
        }else {
            _coinPrice = [NSString stringWithFormat:@"%.5f",[value doubleValue] / pow(10, 5)];
        }
        
        
    }
    
    if ([key isEqualToString:@"symbol"]) {
        _coinName = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        _asset_id = value;
        return;
    }
    
    if ([key isEqualToString:@"options"]) {
        _core_exchange_rate = value[@"core_exchange_rate"];
        return;
    }
    
}

@end
