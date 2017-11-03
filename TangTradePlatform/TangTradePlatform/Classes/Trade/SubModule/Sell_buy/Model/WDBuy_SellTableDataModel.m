//
//  WDBuy_SellTableDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBuy_SellTableDataModel.h"

@interface WDBuy_SellTableDataModel ()



@end


@implementation WDBuy_SellTableDataModel
+ (instancetype)modelToDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        CGFloat amount = [_amount doubleValue];
        
        CGFloat price = [_price doubleValue];
        
        CGFloat gmv = amount * price;
        
        _amount = [NSString stringWithFormat:@"%.5f",amount];
        _price = [NSString stringWithFormat:@"%.5f",price];
        _GMV = [NSString stringWithFormat:@"%.5f",gmv];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"quote"]) {
        _amount = value;
    }
}
@end
