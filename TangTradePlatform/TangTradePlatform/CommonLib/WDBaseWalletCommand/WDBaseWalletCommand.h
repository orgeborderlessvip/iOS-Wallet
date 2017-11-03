//
//  WDBaseWalletCommand.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bds_commands.h"
#import "WDFileModel.h"

@class WDPasswordUserPrivateFileModel;

@interface WDBaseWalletCommand : NSObject

@property (nonatomic,copy) NSString *password;

@property (nonatomic,copy) NSString *url;

@property (nonatomic,copy) NSString *filePath;

@property (nonatomic,assign) BOOL isZhongShen;

@property (nonatomic,strong) WDFileModel *fileModel;

@property (nonatomic,strong) WDPasswordUserPrivateFileModel *passwordModel;

+ (instancetype)shareInstance;

+ (void)resetCommmand;

+ (void)sendWithApi:(BOOL)api string:(NSString *)string withSuccess:(void(^)(id response))success failture:(void(^)(NSString *errMSsg))failture showHud:(BOOL)showHud hudText:(NSString *)hudText;

+ (void)getSuggestKey:(void(^)(WDPasswordUserPrivateFileModel *))key;

+ (void)reconnect;

+ (void)test;

@end
