//
//  WDServiceChargeModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDServiceChargeModel.h"

@implementation WDServiceChargeModel

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
    
    if ([key isEqualToString:@"fee"]) {
        _fee = [NSString stringWithFormat:@"%.5f",[value integerValue] / 100000.f];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
