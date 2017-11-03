//
//  WDBaseResultModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBaseResultModel.h"

NSString *const kWDBaseResultModelData = @"data";
NSString *const kWDBaseResultModelMsg = @"msg";
NSString *const kWDBaseResultModelStatus = @"status";

@interface WDBaseResultModel ()

@property (nonatomic,copy) NSString *className;

@end
@implementation WDBaseResultModel

+ (instancetype)modelToDic:(NSDictionary *)dic withDataModelTransFormName:(NSString *)className{
    return [[self alloc] initWithDic:dic withDataModelTransFormName:className];
}

- (instancetype)initWithDic:(NSDictionary *)dic withDataModelTransFormName:(NSString *)className{
    if (self = [super init]) {
        _className = className;
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) return;
    
    if ([key isEqualToString:kWDBaseResultModelData]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        
        NSArray *item = value;
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dic in item) {
            if (self.className.length) {
                id class = NSClassFromString(self.className);
                
                if ([class respondsToSelector:NSSelectorFromString(@"modelToDic:")]) {
                    [dataArray addObject:[class modelToDic:dic]];
                }else {
                    NSAssert(NO, @"这个类不能执行该方法或者此类不存在");
                }
            }else {
                [dataArray addObject:dic];
            }
        }
        
        _data = dataArray;
        return;
    }
    
    if ([key isEqualToString:kWDBaseResultModelStatus]) {
        _status = [value isEqualToString:@"success"];
        
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}



@end
