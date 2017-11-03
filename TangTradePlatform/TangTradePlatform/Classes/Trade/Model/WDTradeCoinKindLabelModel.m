//
//  WDTradeCoinKindLabel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTradeCoinKindLabelModel.h"

@implementation WDTradeCoinKindLabelModel

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
    if ([key isEqualToString:@"id"]) {
        _identifier = value;
    }
}

@end
