//
//  WDUploadSendModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDUploadSendModel.h"
#import "NSObject+sha256.h"
@implementation WDUploadSendModel

- (instancetype)initWithFrom:(NSString *)from to:(NSString *)to amount:(CGFloat)amount symbol:(NSString *)symbol {
    if (self = [super init]) {
        _from = from;
        _to = to;
        _amount = [NSString stringWithFormat:@"%.5f",amount];
        _broadcast = @"True";
        _memo = @"";
        _symbol = symbol;
        _api_code = @"transfer";
        
        NSString *key = [NSString stringWithFormat:@"%@%@%@%@%@%@",_from,_to,_amount,_symbol,_memo,_broadcast];
        
        NSString *sha256 = [NSObject sha256:key];
        
        NSString *base64 = [NSObject base64StringFromText:sha256];
        _token = base64;
    }
    return self;
}

@end
