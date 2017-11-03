//
//  WDFileModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDFileModel.h"

@implementation WDFileModel

+ (instancetype)modelToDic:(NSDictionary *)dic {
    if (![dic isKindOfClass:[NSDictionary class]]) return nil;
    if (![dic[@"my_accounts"] isKindOfClass:[NSArray class]]) return nil;
    
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
    
    if ([key isEqualToString:@"my_accounts"]) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            [array addObject:[WDPasswordUserPrivateFileModel modelToDic:dic]];
        }
        _my_accounts = array;
        
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
