//
//  WDBaseWalletCommand.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBaseWalletCommand.h"
#include "bds_commands.h"
#include "cli.h"
#include "bds_defines.h"

#import "WDPasswordUserPrivateFileModel.h"

@interface WDBaseWalletCommand ()
{
    std::shared_ptr<bds::cli::wallet> _object;
}

@end

@implementation WDBaseWalletCommand

+ (instancetype)shareInstance {
    static WDBaseWalletCommand *command = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        command = [WDBaseWalletCommand new];
    });
    return command;
}

- (instancetype)init {
    if (self = [super init]) {
        [self creatConnection];
    }
    return self;
}

- (void)creatConnection {
    _object = std::make_shared<bds::cli::wallet>();
    const char *c = "ws://118.190.159.23:22227";
    _object->init((char*)BDS_CHAIN_ID, (char*)c);
}

- (void)sendWithApi:(BOOL)wallet_api string:(NSString *)string withSuccess:(void(^)(id response))success failture:(void(^)())failture showHud:(BOOL)showHud hudText:(NSString *)hudText{
    if (showHud) {
        [[UIViewController currentViewController] showHuDwith:WDLocalizedString(hudText)];
    }
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            char buffer[512] = {0};
            sprintf(buffer, "%s", string.UTF8String);
            std::string command(buffer);
            std::string line;
            bds::cli::api_t api = wallet_api?bds::cli::wallet_api:bds::cli::database_api;
            int successR = _object->run_command(api, command, line);
            char *cb = (char *)line.c_str();
            NSString *jsonString = [NSString stringWithUTF8String:cb];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIViewController currentViewController] hidenHUD];
                if (successR == ERROR_NONE) {
                    NSData *data = [jsonString dataUsingEncoding:4];
                    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    success(object);
                }else {
                    failture();
                }
            });
        }
    });
}

+ (void)sendWithApi:(BOOL)api string:(NSString *)string withSuccess:(void(^)(id response))success failture:(void(^)())failture showHud:(BOOL)showHud hudText:(NSString *)hudText {
    [[self shareInstance] sendWithApi:api string:string withSuccess:success failture:failture showHud:showHud hudText:hudText];
}

+ (void)getSuggestKey:(void (^)(WDPasswordUserPrivateFileModel *))key {
    NSString *command = [NSString stringWithUTF8String:CMD_SUGGEST_BRAIN_KEY];
    
    [[self shareInstance] sendWithApi:YES string:command withSuccess:^(id response) {
        WDPasswordUserPrivateFileModel *model = [WDPasswordUserPrivateFileModel modelToDic:response];
    
        
        if (key) {
            key(model);
        }
    } failture:^{
        
    } showHud:NO hudText:nil];
}

+ (void)reconnect {
    [WDBaseWalletCommand shareInstance]->_object->uninit();
    const char *c = "ws://118.190.159.23:22227";
    [WDBaseWalletCommand shareInstance]->_object->init((char*)BDS_CHAIN_ID, (char*)c);
}

+ (void)test {
    NSString *command = [NSString stringWithFormat:@CMD_IMPORT_KEY,"wudi","5JG9vA1mKFZviMFqmGVGmy5S3smPXCGBJbmM55WSgf2p7fdH3zy"];
    [[self shareInstance] sendWithApi:YES string:command withSuccess:^(id response) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *localPath = [path stringByAppendingPathComponent:@"local.json"];
        
        NSString *content = [NSString stringWithFormat:@CMD_SAVE_SALLET_FILE,localPath.UTF8String];
        
        [[self shareInstance] sendWithApi:YES string:content withSuccess:^(id response) {
            DLog(@"%@",response);
        } failture:^{
            
        } showHud:NO hudText:nil];
    } failture:^{
        
    } showHud:NO hudText:nil];
}

@end
