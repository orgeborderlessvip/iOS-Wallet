//
//  WDChengDuiRecordDataModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiRecordDataModel.h"



@implementation WDChengDuiRecordDataModel

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
    if ([key isEqualToString:@"CoinType"]) {
        NSString *string = value;
        
        if ([string isEqualToString:@"Card"]) {
            _selectedKind = SelectedPayKindCNYCard|SelectedPayKindUSDCard;
        }else if ([string isEqualToString:@"AliPay"]){
            _selectedKind = SelectedPayKindCNYAlipay;
        }else if ([string isEqualToString:@"WeChat"]){
            _selectedKind = SelectedPayKindCNYWeChat;
        }else {
            _selectedKind = SelectedPayKindBTCWallet;
        }
        return;
    }
    
    if ([key isEqualToString:@"Type"]) {
        _coinKind = value;
        return;
    }
    
    if ([key isEqualToString:@"Count"]) {
        CGFloat amount = [value doubleValue];
        _amount = [NSString stringWithFormat:@"%.2f",amount];
        return;
    }
    
    if ([key isEqualToString:@"CreateDate"]) {
        _date = value;
        return;
    }
    
    if ([key isEqualToString:@"Status"]) {
        _paySupportKind = [value integerValue];
        return;
    }
    if ([key isEqualToString:@"AcceptanceID"]) {
        _paySupportName = value;
        return;
    }
}

@end
