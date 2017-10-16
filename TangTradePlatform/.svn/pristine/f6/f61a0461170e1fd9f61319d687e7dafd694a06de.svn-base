//
//  WDSocketBaseModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDSocketBaseModel.h"

@interface WDSocketBaseModel ()

@property (nonatomic,copy) NSString *className;

@end

@implementation WDSocketBaseModel

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
    
    if ([key isEqualToString:@"result"]) {
        if ([value isKindOfClass:[NSArray class]]) {
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
            
            _result = dataArray;
            return;
        }else if ([value isKindOfClass:[NSString class]]) {
            _result = value;
        }else {
            if (self.className.length) {
                id class = NSClassFromString(self.className);
                
                if ([class respondsToSelector:NSSelectorFromString(@"modelToDic:")]) {
                    _result = [class modelToDic:value];
                }else {
                    NSAssert(NO, @"这个类不能执行该方法或者此类不存在");
                }
            }else {
                _result = value;
            }
            return;
        }
    
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
