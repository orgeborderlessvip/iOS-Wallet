//
//  WDHistory_TradeHistoryDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHistory_TradeHistoryDataModel.h"
#import "NSDate+UTCDate.h"
@implementation WDHistory_TradeHistoryDataModel

+ (instancetype)modelToDic:(NSDictionary *)dic WithBaseModel:(WDHomeTableDataModel *)baseModel quoteModel:(WDHomeTableDataModel *)quoteModel {
    return [[self alloc] initWithDic:dic WithBaseModel:baseModel quoteModel:quoteModel];
}

+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic WithBaseModel:(WDHomeTableDataModel *)baseModel quoteModel:(WDHomeTableDataModel *)quoteModel {
    if (self = [super init]) {
        _baseModel = baseModel;
        _quoteModel = quoteModel;
        [self setValuesForKeysWithDictionary:dic];
        CGFloat amount = [_amount doubleValue];
        CGFloat price = [_price doubleValue];
        CGFloat value = [_value doubleValue];
        _amount = [NSString stringWithFormat:@"%.5f",amount];
        _price = [NSString stringWithFormat:@"%.5f",price];
        _value = [NSString stringWithFormat:@"%.5f",value];
        
        
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        CGFloat amount = [_amount doubleValue];
        CGFloat price = [_price doubleValue];
        CGFloat value = [_value doubleValue];
        _amount = [NSString stringWithFormat:@"%.5f",value];
        _price = [NSString stringWithFormat:@"%.5f",price];
        _value = [NSString stringWithFormat:@"%.5f",amount];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:@"date"]) {
        NSString *date = value;
        _date = [NSDate UTCStringTransToLocal:date];
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"op"]) {
        NSArray *baseArray = value;
        
        NSDictionary *topDic = baseArray.lastObject;
        
        NSDictionary *pays = topDic[@"pays"];
        NSString *pay_Id = pays[@"asset_id"];
        CGFloat payAmount = [pays[@"amount"] doubleValue];
        NSDictionary *receives = topDic[@"receives"];
        NSString *receive_id = receives[@"asset_id"];
        CGFloat receiveAmount = [receives[@"amount"] doubleValue];
        
        BOOL sell = [pay_Id isEqualToString:_baseModel.asset_id] && [receive_id isEqualToString:_quoteModel.asset_id];
        BOOL buy = [pay_Id isEqualToString:_quoteModel.asset_id] && [receive_id isEqualToString:_baseModel.asset_id];
        
        if (sell || buy) {
            _isCurrentKind = YES;
            _isSell = sell;
            
            if (sell) {
                payAmount = payAmount / pow(10, _baseModel.precision);
                receiveAmount = receiveAmount / pow(10, _quoteModel.precision);
                _price = [NSString stringWithFormat:@"%f",payAmount / receiveAmount];
                _amount = [NSString stringWithFormat:@"%f",payAmount];
                _value = [NSString stringWithFormat:@"%f",receiveAmount];
            }else {
                payAmount = payAmount / pow(10, _quoteModel.precision);
                receiveAmount = receiveAmount / pow(10, _quoteModel.precision);
                _price = [NSString stringWithFormat:@"%f",receiveAmount / payAmount];
                _amount = [NSString stringWithFormat:@"%f",receiveAmount];
                _value = [NSString stringWithFormat:@"%f",payAmount];
            }
        }
        
        
        return;
    }
    
    if ([key isEqualToString:@"block_num"]) {
        _date = [NSString stringWithFormat:@"#%@",value];
        return;
    }
}

@end
