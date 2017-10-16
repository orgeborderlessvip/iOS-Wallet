//
//  WDCoinTypeWayDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/13.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDCoinTypeWayDataModel.h"

@implementation WDCoinTypeWayDataModel

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
    
    if ([key isEqualToString:@"cointypeway"]) {
        NSString *string = value;
        if ([string isEqualToString:@"Card"]) {
            _cointypeway = SelectedPayKindCNYCard|SelectedPayKindUSDCard;
        }else if ([string isEqualToString:@"AliPay"]){
            _cointypeway = SelectedPayKindCNYAlipay;
        }else if ([string isEqualToString:@"WeChat"]){
            _cointypeway = SelectedPayKindCNYWeChat;
        }else {
            _cointypeway = SelectedPayKindBTCWallet;
        }
        _type = value;
        
        return;
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
