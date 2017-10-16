//
//  WDBaseFileControl.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WDFileModel;
@interface WDBaseFileControl : NSObject

+(BOOL)haveLocal;

+ (void)creatLocalWithPassword:(NSString *)password;

+ (void)deleteLocal;

+ (void)loadLocal;

+ (void)judgeWithPassword:(NSString *)password withReturn:(void(^)(BOOL result))returnS;

+ (NSArray *)getBakUpDataName;

@end
