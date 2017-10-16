//
//  WDWalletManager.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDWalletManager : NSObject

+ (void)setPassword:(NSString *)password withSuccess:(void(^)(BOOL success))success;

+ (void)saveFileToPath:(NSString *)path withSuccess:(void(^)())success;

+ (void)loadFileToPath:(NSString *)path withSuccess:(void(^)())success;

/**
 解锁
 */
+ (void)unlockWithPassword:(NSString *)password withSuccess:(void(^)(BOOL))success;

@end
