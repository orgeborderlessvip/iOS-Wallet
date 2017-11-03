//
//  WDBaseFileControl.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

#define baseFileName @"Default.bin"
@class WDFileModel;
@interface WDBaseFileControl : NSObject

+(BOOL)haveLocal;

+ (void)creatLocalWithPassword:(NSString *)password;

+ (void)deleteLocalWithName:(NSString *)name;

+ (void)loadLocalWithName:(NSString *)name;

+ (void)loadBakUpFromName:(NSString *)fileName withSuccess:(void(^)())success;

+ (void)creatBakUpWithFileName:(NSString *)fileName password:(NSString *)password withSuccess:(void(^)())success;

+ (NSArray *)getLocalWalletArray;

+ (void)judgeWithPassword:(NSString *)password withReturn:(void(^)(BOOL result))returnS;

+ (NSArray *)getBakUpDataName;

@end
