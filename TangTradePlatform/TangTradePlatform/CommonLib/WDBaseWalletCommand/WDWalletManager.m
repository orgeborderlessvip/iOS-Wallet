//
//  WDWalletManager.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDWalletManager.h"
#import "WDBaseWalletCommand.h"
@implementation WDWalletManager

+ (void)setPassword:(NSString *)password withSuccess:(void(^)(BOOL success))success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_SET_PASSWORD,password.UTF8String] withSuccess:^(id response) {
        success(YES);
    } failture:^{
        success(NO);
    } showHud:NO hudText:nil];
}

+ (void)saveFileToPath:(NSString *)path withSuccess:(void(^)())success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_SAVE_SALLET_FILE,path.UTF8String] withSuccess:^(id response) {
        success();
    } failture:^{
        
    } showHud:NO hudText:nil];
}

+ (void)loadFileToPath:(NSString *)path withSuccess:(void(^)())success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_LOAD_WALLET_FILE,path.UTF8String] withSuccess:^(id response) {
        success();
    } failture:^{
        
    } showHud:NO hudText:nil];
}

+ (void)unlockWithPassword:(NSString *)password withSuccess:(void(^)(BOOL))success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_UNLOCK,password.UTF8String] withSuccess:^(id response) {
        success(YES);
    } failture:^{
        success(NO);
    } showHud:NO hudText:nil];
}

@end
