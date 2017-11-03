//
//  WDPasswordUserPrivateFileModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDPasswordUserPrivateFileModel.h"

@interface WDPasswordUserPrivateFileModel ()

@property (nonatomic,copy) NSString *lifetime_referrer;

@end

@implementation WDPasswordUserPrivateFileModel

+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        _isLifeTime = [_lifetime_referrer isEqualToString:_idnentifier];
    }
    return self;
}

- (BOOL)isIsLifeTime {
    return [_lifetime_referrer isEqualToString:_idnentifier];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idnentifier = value;
        return;
    }
    
    if ([key isEqualToString:@"options"]) {
        _pub_key = value[@"memo_key"];
        return;
    }
}

@end
