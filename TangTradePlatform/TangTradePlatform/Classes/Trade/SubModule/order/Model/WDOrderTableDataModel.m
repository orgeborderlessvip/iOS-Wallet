//
//  WDOrderTableDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOrderTableDataModel.h"
#import "WDHomeTableDataModel.h"

#import "NSString+changeTest.h"
@implementation WDOrderTableDataModel

+ (instancetype)modelToDic:(NSDictionary *)dic withBaseId:(WDHomeTableDataModel *)base quetoId:(WDHomeTableDataModel *)quetoId{
    return [[self alloc] initWithDic:dic withBaseId:base quetoId:quetoId];
}

- (instancetype)initWithDic:(NSDictionary *)dic withBaseId:(WDHomeTableDataModel *)base quetoId:(WDHomeTableDataModel *)quetoId{
    if (self = [super init]) {
        _base = base;
        _quote = quetoId;
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"expiration"]) {
        _riseTime = value;
        return;
    }
    
    if ([key isEqualToString:@"sell_price"]) {
        NSDictionary *dic = value;
        
        NSDictionary *base = dic[@"base"];
        NSString *base_asset_id = base[@"asset_id"];
        CGFloat base_coinAmount = [base[@"amount"] doubleValue];
        
        NSDictionary *queto = dic[@"quote"];
        NSString *sell_asset_id = queto[@"asset_id"];
        CGFloat coinAmount = [queto[@"amount"] doubleValue];
        
//        base_coinAmount = base_coinAmount / pow(10, _)
        
        BOOL result2 = ([base_asset_id isEqualToString:_base.asset_id]&& [sell_asset_id isEqualToString:_quote.asset_id]);
        BOOL result1 = ([base_asset_id isEqualToString:_quote.asset_id]&& [sell_asset_id isEqualToString:_base.asset_id]);
        
        if (result1 || result2) {
            if (result2) {
                _coinAmount = [[NSString stringWithFormat:@"%f",base_coinAmount / pow(10, _base.precision)] digitalNumberWithMaxLength:_base.precision];
                _coinTotalAmount = [[NSString stringWithFormat:@"%f",coinAmount / pow(10, _quote.precision)] digitalNumberWithMaxLength:_quote.precision];
                _price = [NSString stringWithFormat:@"%.5f",[_coinAmount doubleValue] /[_coinTotalAmount doubleValue]];
                _isCurrentKind = JudgeKind_Buy;
            }else {
                _coinAmount = [[NSString stringWithFormat:@"%f",coinAmount / pow(10, _base.precision)] digitalNumberWithMaxLength:_base.precision];
                _coinTotalAmount = [[NSString stringWithFormat:@"%f",base_coinAmount / pow(10, _quote.precision)] digitalNumberWithMaxLength:_quote.precision];
                _price = [NSString stringWithFormat:@"%.5f",[_coinAmount doubleValue] / [_coinTotalAmount doubleValue]];
                _isCurrentKind = JudgeKind_Sell;
            }
        }else {
            _isCurrentKind = JudgeKind_UnFound;
        }
        
        return;
    }
    
    if ([key isEqualToString:@"id"]) {
        _identifier = value;
        return;
    }
}

@end
