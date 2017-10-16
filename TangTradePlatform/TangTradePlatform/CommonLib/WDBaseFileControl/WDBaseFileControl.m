//
//  WDBaseFileControl.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBaseFileControl.h"
#import "WDFileModel.h"

#import "WDWalletManager.h"

#define baseFileName @"local.bin"
#define baseFileJson @"local.json"

@implementation WDBaseFileControl

+ (BOOL)haveLocal {
    NSFileManager *manager=[NSFileManager defaultManager];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *localPath = [path stringByAppendingPathComponent:baseFileName];
    
    return [manager fileExistsAtPath:localPath];
}

+ (void)creatLocalWithPassword:(NSString *)password {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *localPath = [path stringByAppendingPathComponent:baseFileName];
    
    [WDWalletManager setPassword:password withSuccess:^(BOOL success) {
        if (success) {
            [WDWalletManager saveFileToPath:localPath withSuccess:^{
                
            }];
        }
    }];
}

+ (void)loadLocal {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *localPath = [path stringByAppendingPathComponent:baseFileName];
    
    localPath = [[NSBundle mainBundle] pathForResource:@"wudis" ofType:@"json"];
    
    [WDWalletManager loadFileToPath:localPath withSuccess:^{
        
    }];
}

+ (void)deleteLocal {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *localPath = [path stringByAppendingPathComponent:baseFileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:localPath error:nil];
    
    exit(0);
}

+ (void)judgeWithPassword:(NSString *)password withReturn:(void(^)(BOOL))returnS{
    [WDWalletManager unlockWithPassword:password withSuccess:returnS];
}

+ (WDFileModel *)loadFileModelWithData:(NSData *)data {
    return [WDFileModel new];
}

+ (NSArray *)getBakUpDataName {
    NSFileManager *manager=[NSFileManager defaultManager];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray* tempArray = [manager contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray *realArray = [NSMutableArray array];
    
    for (NSString* fileName in tempArray) {
        if ([fileName hasSuffix:@".bin"]) {
            [realArray addObject:fileName];
        }else {
            [manager removeItemAtPath:[path stringByAppendingPathComponent:fileName] error:nil];
        }
    }
    
    return realArray;
}

+ (void)

//+ (void)addDataToLocalWithBakUpName:(NSString *)name andPassword:(NSString *)password withSuccess:(void (^)(BOOL))success{
//    NSString *string = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
//    
//    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_LOAD_WALLET_FILE,string.UTF8String] withSuccess:^(id response) {
//        [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_UNLOCK,password.UTF8String] withSuccess:^(id response) {
//            [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:] withSuccess:<#^(id response)success#> failture:<#^(void)failture#> showHud:<#(BOOL)#> hudText:<#(NSString *)#>]
//        } failture:^{
//            
//        } showHud:NO hudText:nil];
//    } failture:^{
//        
//    } showHud:NO hudText:nil];
//    
//    
//    
////    [[NSFileManager defaultManager] removeItemAtPath:string error:nil];
//}

@end
