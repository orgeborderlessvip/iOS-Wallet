//
//  WDVipFeeModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDVipFeeModel.h"

@implementation WDVipFeeModel

+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        _membership_annual_fee /= pow(10, 5);
        _membership_lifetime_fee /= pow(10, 5);
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
