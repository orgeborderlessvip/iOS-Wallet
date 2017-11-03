//
//  WDBlockTableDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

/*{
    "previous": "000304e7d34f826b2c10880e951477a00a0a1e70",
    "timestamp": "2017-10-17T05:51:00",
    "witness": "1.6.1",
    "transaction_merkle_root": "0000000000000000000000000000000000000000",
    "extensions": [],
    "witness_signature": "204df32c11148ca8be99cd472d1af76a4983ee4eea0f8809b2e9b93a118103417e03d0ffa11e3773a31a3cef2acc5bfb10fddc3d7741182fd28b53f8200064470c",
    "transactions": [],
    "block_id": "000304e886e91d60ac5303e353b9853838e77743",
    "signing_key": "BDS6XeN9F9fMjUDLu3VQXaou7t9BtZNrA6DANBWwVu8P6SAY9TYG6",
    "transaction_ids": []
}*/

#import "WDBlockTableDataModel.h"

@implementation WDBlockTableDataModel

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
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"transactions"]) {
        NSArray *array = value;
        _exchangecount = [NSString stringWithFormat:@"%ld",array.count];
        return;
    }
    if ([key isEqualToString:@"timestamp"]) {
        _time = value;
        return;
    }
}

@end
