//
//  WDInternationalCenter.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/27.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LanguageKind) {
    LanguageKindCNS,
    LanguageKindCNT,
    LanguageKindEN,
};

#define WDLocalizedString(key) [WDInternationalCenter getStringByKey:key]

@interface WDInternationalCenter : NSObject


/// 获取应用当前语言
+ (LanguageKind)userLanguage;
/// 设置当前语言
+ (void)setUserlanguage:(LanguageKind)language;
/// 通过Key获得对应的string
+ (NSString *)getStringByKey:(NSString *)key;
@end
