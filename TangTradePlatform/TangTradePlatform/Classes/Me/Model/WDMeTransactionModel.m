//
//  WDMeTransactionModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMeTransactionModel.h"

@implementation WDMeTransactionModel
+ (instancetype)modelToString:(NSString *)string {
    return [[self alloc] initWithString:string];
}

- (instancetype)initWithString:(NSString *)string {
    if (self = [super init]) {
        NSArray *array = [string componentsSeparatedByString:@" "];
        
        if (array.count > 6) {
            _amount = [NSString stringWithFormat:@"%.5f",[array[1] doubleValue]];
            
            _symbol = array[2];
            
            _from = array[4];
            
            _to = array[6];
        }
    }
    return self;
}
@end
