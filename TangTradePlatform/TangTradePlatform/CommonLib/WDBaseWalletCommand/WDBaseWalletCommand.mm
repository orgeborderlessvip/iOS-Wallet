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

#import "WDThreadWalletDo.h"
#import "NSDate+UTCDate.h"

#define uri @"ws://118.190.159.23:11117"

@interface WDBaseWalletCommand ()
{
    std::shared_ptr<bds::cli::wallet> _object;
}

@property (nonatomic,strong) NSThread *objThread;

@property (nonatomic,strong) NSRunLoop *runloop;

@property (nonatomic,strong) NSMachPort *emptyPort;

@property (nonatomic,assign) BOOL walletCommand;

@property (nonatomic,assign) BOOL wsEnable;

@property (nonatomic,strong) NSThread *thread;

@property (nonatomic,assign) NSInteger backTimes;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) BOOL stauts;

@property (nonatomic,strong) NSDate *quitDate;

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

- (void)backgroundHandler {
    
    NSLog(@"### -->backgroundinghandler");
    
    UIApplication *app = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task
    [self performSelector:@selector(backGroundInfo) onThread:_thread withObject:nil waitUntilDone:NO];
}

- (void)backGroundInfo {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        if (_stauts) {
            _backTimes += 5;
            DLog(@"backgroundTime %ld",_backTimes);
            if (_backTimes >= 2 * 60) {
                
                exit(0);
            }
            
            [self sendPingPong];
            [self backGroundInfo];
        }
        
    });
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToBack) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
        _timer = [NSTimer timerWithTimeInterval:45 target:self selector:@selector(sendPingPong) userInfo:nil repeats:YES];
        
        [_timer fire];
    }
    return self;
}

- (void)sendPingPong {
    [self sendWithApi:YES string:@"info" withSuccess:^(id response) {
        
    } failture:^(NSString *errMSsg) {
        if ([errMSsg rangeOfString:@"time"].location == NSNotFound && _stauts) {
            exit(0);
        }
        
        if (errMSsg) {
            [self performSelector:@selector(creatConnectionWithDo:) onThread:self.thread withObject:^{
                [WDWalletManager loadFileToPath:self.filePath withSuccess:^{
                    [WDWalletManager unlockWithPassword:self.password withSuccess:^(BOOL) {
                        
                    }];
                }];
            } waitUntilDone:YES];
        }
    } showHud:NO hudText:nil];
}


- (void)creatThread {
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [_thread start];
    
    void (^doBlock) () = ^{
//        [WDWalletManager loadFileToPath:self.filePath withSuccess:^{
//            [WDWalletManager unlockWithPassword:self.password withSuccess:^(BOOL) {
//                
//            }];
//        }];
    };
    
    [self performSelector:@selector(creatConnectionWithDo:) onThread:_thread withObject:doBlock waitUntilDone:NO];
}

- (void)run {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"BaseSocketWallet"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        [runLoop run];
    }
}

- (void)sendWithTimeOut:(NSInteger)timeOut {
   
    [[UIViewController currentViewController] showHuDwith:@"连接区块中"];
    
    WDThreadWalletDo *doModel = [WDThreadWalletDo new];
    
    doModel.command = @"info";
    
    doModel.walletApi = YES;
    
    doModel.succssDo = ^(id response){
        [self performSelector:@selector(settimeOut:) onThread:_thread withObject:@10 waitUntilDone:NO];
    };
    
    doModel.errorDo = ^(NSString *msg){
        
            [self performSelector:@selector(quitToServer) onThread:_thread withObject:nil waitUntilDone:NO];
            
            
            [self performSelector:@selector(creatConnectionWithDo:) onThread:_thread withObject:^{
                [WDWalletManager loadFileToPath:self.filePath withSuccess:^{
                    [WDWalletManager unlockWithPassword:self.password withSuccess:^(BOOL) {
                        
                    }];
                }];
            } waitUntilDone:NO];
//        }
    };
    
    doModel.showHud = YES;
    
    [self performSelector:@selector(settimeOut:) onThread:_thread withObject:@1 waitUntilDone:NO];
    
    [self performSelector:@selector(threadDo:) onThread:_thread withObject:doModel waitUntilDone:NO];
}

- (void)pushToBack {
//    exit(0);
    _stauts = YES;
    
    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:60 * 60 * 55 handler:^{
        [self backgroundHandler];
    }];
    
    if (backgroundAccepted) {
        DLog(@"1111");
    }
    
    [self backgroundHandler];
}

- (void)becomeActive {
    _stauts = NO;
    _backTimes = 0;
    [self sendWithTimeOut:1];
}

- (void)quitToServer {
    if (_object.get()) {
        try {
            [NSThread sleepForTimeInterval:1];
//            _object->uninit();
            [NSThread sleepForTimeInterval:1];
            _object.reset();
            [NSThread sleepForTimeInterval:1];
        } catch (...) {
            
        }
    }
}

- (void)setUrl:(NSString *)url {
    _url = url;
    
    [self creatThread];
}

- (void)endActive {
    exit(0);
//    [[WDBaseWalletCommand networkRequestThread] cancel];
}

- (void)settimeOut:(NSInteger)timeOut {
    bds::cli::wallet::set_timeout(timeOut * 100000);
}

- (void)creatConnection {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [[UIViewController currentViewController] showHuDwith:@"连接服务器中"];
    });

    _object = std::make_shared<bds::cli::wallet>();
    
    [self settimeOut:10];
    
    const char *c = _url.UTF8String;
    
    if (_url.length <= 0) return;
    
    try {
        _wsEnable = _object->init((char*)BDS_CHAIN_ID, (char*)c) == 0;
        
        if (_wsEnable) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"URLActive" object:nil];
            });
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[UIViewController currentViewController] hidenHUD];
        });
    } catch (...) {
        
    }
    
    
    
    
}

- (void)creatConnectionWithDo:(void(^)())doBlock {
    [self creatConnection];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        doBlock();
    });
}

- (void)sendWithApi:(BOOL)wallet_api string:(NSString *)string withSuccess:(void(^)(id response))success failture:(void(^)(NSString *errMSsg))failture showHud:(BOOL)showHud hudText:(NSString *)hudText{
    if (showHud) {
        [[UIViewController currentViewController] showHuDwith:WDLocalizedString(hudText)];
    }
    WDThreadWalletDo *doModel = [WDThreadWalletDo new];
    
    doModel.command = string;
    
    doModel.walletApi = wallet_api;
    
    doModel.succssDo = success;
    
    doModel.errorDo = failture;

    doModel.showHud = showHud;
    
    [self performSelector:@selector(threadDo:) onThread:_thread withObject:doModel waitUntilDone:NO];
}

+ (void)run {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"BaseSocketWallet"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

- (void)threadDo:(WDThreadWalletDo *)doModel {
    NSString *string = doModel.command;
    BOOL wallet_api = doModel.walletApi;
    char buffer[512] = {0};
    sprintf(buffer, "%s", string.UTF8String);
    std::string command(buffer);
    std::string line;
    bds::cli::api_t api = wallet_api?bds::cli::wallet_api:bds::cli::database_api;
    DLog(@"test111 %@",string);
    
    if (_wsEnable) {
        int successR = _object->run_command(api, command, line);
        char *cb = (char *)line.c_str();
        NSString *jsonString = [NSString stringWithUTF8String:cb];
        
        //    [_objThread cancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (doModel.showHud) {
                [[UIViewController currentViewController] hidenHUD];
            }
            
            if (successR == ERROR_NONE) {
                NSData *data = [jsonString dataUsingEncoding:4];
                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                doModel.succssDo(object);
            }else {
                doModel.errorDo(jsonString);
            }
            
            
        });
    }else {
        if (self.url) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[UIViewController currentViewController] hidenHUD];
                [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"节点连接失败,点击确定重新连接节点" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                    void (^doBlock)() = ^{
                        [self performSelector:@selector(threadDo:) onThread:_thread withObject:doModel waitUntilDone:NO];
                    };
                    
                    [self performSelector:@selector(creatConnectionWithDo:) onThread:_thread withObject:doBlock waitUntilDone:NO];
                }];
            });
        }
    }

    
}

+ (void)sendWithApi:(BOOL)api string:(NSString *)string withSuccess:(void(^)(id response))success failture:(void(^)(NSString *errMSsg))failture showHud:(BOOL)showHud hudText:(NSString *)hudText {
    [[self shareInstance] sendWithApi:api string:string withSuccess:success failture:failture showHud:showHud hudText:hudText];
}

+ (void)getSuggestKey:(void (^)(WDPasswordUserPrivateFileModel *))key {
    NSString *command = [NSString stringWithUTF8String:CMD_SUGGEST_BRAIN_KEY];
    
    [[self shareInstance] sendWithApi:YES string:command withSuccess:^(id response) {
        WDPasswordUserPrivateFileModel *model = [WDPasswordUserPrivateFileModel modelToDic:response];
        [self sendWithApi:YES string:[NSString stringWithFormat:@CMD_IS_PUBLIC_KEY_REGISTERED,model.pub_key] withSuccess:^(id responseAble) {
            if (![responseAble boolValue]) {
                if (key) {
                    key(model);
                }
            }else {
                [self getSuggestKey:key];
            }
        } failture:^(NSString *errMSsg) {
            
        } showHud:NO hudText:nil];
    } failture:^(NSString *errMSsg) {
        
    } showHud:NO hudText:nil];
}

+ (void)resetCommmand {
    [[self shareInstance] performSelector:@selector(creatConnection) onThread:[WDBaseWalletCommand shareInstance].thread withObject:nil waitUntilDone:NO];
}

+ (void)reconnect {
    [WDBaseWalletCommand shareInstance]->_object->uninit();
//
    const char *c = [WDBaseWalletCommand shareInstance].url.UTF8String;
    [WDBaseWalletCommand shareInstance]->_object->init((char*)BDS_CHAIN_ID, (char*)c);
}

- (void)setPasswordModel:(WDPasswordUserPrivateFileModel *)passwordModel {
    _passwordModel = passwordModel;
    
    [self sendWithApi:YES string:[NSString stringWithFormat:@CMD_GET_ACCOUNT,passwordModel.name] withSuccess:^(id response) {
        [_passwordModel setValuesForKeysWithDictionary:response];
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"加载中"];
}

+ (void)test {
    
    
//    [WDBaseFileControl loadLocalWithName:@"wallet_2017-10-21T21-47-33.bin"];
//    
//    [WDWalletManager getRecentBlockInfoWithBlockId:@"375061" showHud:NO SuccessDo:^(NSDictionary *dic) {
//        
//    }];
//
}

@end
