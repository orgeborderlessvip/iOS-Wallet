//
//  WDCheckUpdateModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/25.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDCheckUpdateModel.h"

@implementation WDCheckUpdateModel

+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _needUpdate = YES;
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _appVersion = app_Version;
        
        [self setValuesForKeysWithDictionary:dic];
        
        if ([_appVersion isEqualToString:_iosversion]) {
            _needUpdate = NO;
        }
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:@"status"]) {
        _status = [value isEqualToString:@"true"];
        return;
    }
    
    if ([key isEqualToString:@"iosurl"]) {
        NSArray *array = value;
        
        NSInteger random = arc4random() % array.count;
        
        _iosurl = array[random];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
