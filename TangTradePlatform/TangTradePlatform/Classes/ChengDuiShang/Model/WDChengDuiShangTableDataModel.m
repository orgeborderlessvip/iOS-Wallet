//
//  WDChengDuiShangTableDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiShangTableDataModel.h"

@implementation WDChengDuiShangTableDataModel

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
    if ([key isEqualToString:@"Name"]) {
        _paySupportName = value;
        return;
    }
    
    NSString *payIntroduction = nil;
    
    switch ([WDInternationalCenter userLanguage]) {
        case LanguageKindEN:
            payIntroduction = @"IntroduceEnglish";
            break;
        case LanguageKindCNS:
        case LanguageKindCNT:
            payIntroduction = @"Introduce";
            break;
        default:
            break;
    }
    if ([key isEqualToString:payIntroduction]) {
        _paySupportDetail = value;
        return;
    }
    if ([key isEqualToString:@"Evaluate"]) {
        _paySupportRanking = [value integerValue];
        return;
    }
    if ([key isEqualToString:@"way"]) {
        NSString *string = value;
        NSArray *array = [string componentsSeparatedByString:@","];
        NSMutableArray *realArray = [NSMutableArray array];
        for (NSString *item in array) {
            if ([item hasPrefix:@"http"]) {
                [realArray addObject:item];
                continue;
            }
            
            [realArray addObject:[NSString stringWithFormat:@"http://%@",item]];
        }
        
        _paySupportArray = realArray;
        return;
    }
}

@end
