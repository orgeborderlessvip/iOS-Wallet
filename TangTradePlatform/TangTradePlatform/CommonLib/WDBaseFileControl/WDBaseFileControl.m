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
#import "WDBaseWalletCommand.h"



@implementation WDBaseFileControl

+ (BOOL)haveLocal {
    NSFileManager *manager=[NSFileManager defaultManager];
    
    NSString *path = [self walletAddress];
    
    if ([manager fileExistsAtPath:[self oldWalletAddress]]) {
        [manager moveItemAtPath:[self oldWalletAddress] toPath:[self walletAddress] error:nil];
    }
    
    if ([manager fileExistsAtPath:path]) {
        NSInteger count = [manager contentsOfDirectoryAtPath:path error:nil].count;
        
        if (count == 0) return NO;
        
        return YES;
    }else {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
        return NO;
    }
    
//    NSString *localPath = [path stringByAppendingPathComponent:baseFileName];
//    
//    return [manager fileExistsAtPath:localPath];
}

+ (void)creatLocalWithPassword:(NSString *)password {
    NSString *path = [self walletAddress];
    
    NSString *localPath = [path stringByAppendingPathComponent:baseFileName];
    
    [WDWalletManager setPassword:password withSuccess:^(BOOL success) {
        if (success) {
            [WDWalletManager saveFileToPath:localPath withSuccess:^{
                [WDWalletManager loadFileToPath:localPath withSuccess:^{
                    [WDWalletManager unlockWithPassword:password withSuccess:^(BOOL result) {
                        
                    }];
                }];
            }];
        }
    }];
}

+ (void)loadLocalWithName:(NSString *)name {
    NSString *path = [self walletAddress];
    
    NSString *localPath = [path stringByAppendingPathComponent:name];
    
    BOOL result = [WDWalletManager loadFileToPath:localPath withSuccess:^{
        
    }];
    
    if (!result) {
        [[NSFileManager defaultManager] removeItemAtPath:localPath error:nil];
        
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"文件无效" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }
}

+ (void)loadBakUpFromName:(NSString *)fileName withSuccess:(void(^)())success {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    path = [path stringByAppendingPathComponent:fileName];
    
    BOOL result = [WDWalletManager loadFileToPath:path withSuccess:^{
        
    }];
    
    if (!result) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"文件无效" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }else {
        [self saveBakUpWithPath:path fileName:fileName withSuccess:success];
    }
}

+ (void)creatBakUpWithFileName:(NSString *)fileName password:(NSString *)password withSuccess:(void(^)())success {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    path = [path stringByAppendingPathComponent:fileName];
    
    [WDWalletManager setPassword:password withSuccess:^(BOOL result) {
        [WDWalletManager saveFileToPath:path withSuccess:^{
            [WDWalletManager loadFileToPath:[WDBaseWalletCommand shareInstance].filePath withSuccess:^{
                [WDWalletManager unlockWithPassword:[WDBaseWalletCommand shareInstance].password withSuccess:^(BOOL result) {
                    success();
                }];
            }];
        }];
    }];
}

+ (void)saveBakUpWithPath:(NSString *)contentPath fileName:(NSString *)fileName withSuccess:(void(^)())success{
    NSString *walletAddress = [[self walletAddress] stringByAppendingPathComponent:fileName];

    NSString *string = [fileName stringByReplacingOccurrencesOfString:@"[0-9a-zA-Z.\\-\\_]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, fileName.length)];

    BOOL walletExist = [[NSFileManager defaultManager] fileExistsAtPath:walletAddress];
    BOOL walletDisable = string.length != 0;
    
    if (walletExist || walletDisable) {
        NSString *attention = WDLocalizedString(@"提示");
        NSString *msg = WDLocalizedString(walletDisable?@"钱包名不合法,请重新输入钱包名":@"该钱包名已存在,请重新输入钱包名");
        UIAlertController *alert =  [UIAlertController alertControllerWithTitle:attention message:msg preferredStyle:(UIAlertControllerStyleAlert)];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = WDLocalizedString(@"请输入钱包名");
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            [[textField rac_textSignal] subscribeNext:^(NSString *text) {
                textField.text = [text stringByReplacingOccurrencesOfString:@"[^0-9a-zA-Z]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, text.length)];
            }];
        }];
        
        [alert addAction:[UIAlertAction actionWithTitle:WDLocalizedString(@"取消") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self loadLocalWithName:baseFileName];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:WDLocalizedString(@"确定") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSString *string = alert.textFields.firstObject.text;
            
            [self saveBakUpWithPath:contentPath fileName:[NSString stringWithFormat:@"%@.bin",string] withSuccess:success];
        }]];
        
        [[UIViewController currentViewController] presentViewController:alert animated:YES completion:nil];
    }else {
        [[NSFileManager defaultManager] moveItemAtPath:contentPath toPath:walletAddress error:nil];
        
        success();
    }
}

+ (NSArray *)getLocalWalletArray {
    NSFileManager *manager=[NSFileManager defaultManager];
    
    NSString *localPath = [self walletAddress];
    
    NSArray* tempArray = [manager contentsOfDirectoryAtPath:localPath error:nil];
    
    NSMutableArray *realArray = [NSMutableArray array];
    
    for (NSString* fileName in tempArray) {
        if ([fileName hasSuffix:@".bin"]) {
            [realArray addObject:fileName];
        }else {
            [manager removeItemAtPath:[localPath stringByAppendingPathComponent:fileName] error:nil];
        }
    }
    
    return realArray;
}

+ (void)deleteLocalWithName:(NSString *)name {
    NSString *path = [self walletAddress];
    
    NSString *localPath = [path stringByAppendingPathComponent:name];
    
    [[NSFileManager defaultManager] removeItemAtPath:localPath error:nil];
    
    [WDWalletManager resetCommand];
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

+ (NSString *)walletAddress {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    path = [path stringByAppendingPathComponent:@"wallet"];
    
    return path;
}

+ (NSString *)oldWalletAddress {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    path = [path stringByAppendingPathComponent:@"wallet"];
    
    return path;
}
@end
