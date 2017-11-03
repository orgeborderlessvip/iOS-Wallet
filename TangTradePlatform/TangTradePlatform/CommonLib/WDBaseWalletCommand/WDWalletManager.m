//
//  WDWalletManager.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDWalletManager.h"
#import "WDBaseWalletCommand.h"
#import "NSDate+UTCDate.h"

@implementation WDWalletManager

+ (NSString *)currecntConnectUrl {
    return [WDBaseWalletCommand shareInstance].url;
}

+ (NSString *)currentPassword {
    return [WDBaseWalletCommand shareInstance].password;
}

+ (void)setConnectUrl:(NSString *)url {
    [WDBaseWalletCommand shareInstance].url = url;
}

+ (void)resetCommand {
    [WDBaseWalletCommand resetCommmand];
}

+ (void)setPassword:(NSString *)password withSuccess:(void(^)(BOOL success))success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_SET_PASSWORD,password] withSuccess:^(id response) {
        
        
        success(YES);
    } failture:^(NSString *errMSsg) {
        
    } showHud:NO hudText:nil];
}

+ (void)saveCurrentWithSuccess:(void(^)())success {
    [self saveFileToPath:[WDBaseWalletCommand shareInstance].filePath withSuccess:^{
        
    }];
}

+ (void)saveFileToPath:(NSString *)path withSuccess:(void(^)())success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_SAVE_SALLET_FILE,path] withSuccess:^(id response) {
        success();
    } failture:^(NSString *errMSsg) {
        
    } showHud:NO hudText:nil];
}

+ (BOOL)loadFileToPath:(NSString *)path withSuccess:(void(^)())success {
    if (![self loadModelToPath:path]) return NO;

    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_LOAD_WALLET_FILE,path] withSuccess:^(id response) {
        [WDBaseWalletCommand shareInstance].filePath = path;
        
        success();
        
        
    } failture:^(NSString *errMSsg) {
        
    } showHud:NO hudText:nil];
    
    return YES;
}

+ (BOOL)loadModelToPath:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data.length) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        WDFileModel *model = [WDFileModel modelToDic:dic];
        
        if (model == nil) {
            return NO;
        }
        
        [WDBaseWalletCommand shareInstance].fileModel = model;
    }
    return YES;
}

+ (void)addWithUserName:(NSString *)userName priKey:(NSString *)prikey success:(void(^)())success failture:(void(^)(NSString *msg))failture {
    [[UIViewController currentViewController] showHuDwith:WDLocalizedString(@"将账户导入钱包中")];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_IMPORT_KEY,userName,prikey] withSuccess:^(id response) {
            [[UIViewController currentViewController] hidenHUD];
            if ([response boolValue]) {
                
                
                [self saveFileToPath:[WDBaseWalletCommand shareInstance].filePath withSuccess:^{
                    [self loadModelToPath:[WDBaseWalletCommand shareInstance].filePath];
                    
                    success();
                }];
            }else {
                failture(@"msg");
            }
            
            
        } failture:^(NSString *errMSsg) {
            [[UIViewController currentViewController] hidenHUD];
            failture(errMSsg);
        } showHud:NO hudText:nil];
    });
    
    
}

+ (void)setSelectedUserModel:(WDPasswordUserPrivateFileModel *)model {
    [WDBaseWalletCommand shareInstance].passwordModel = model;
}

+ (WDPasswordUserPrivateFileModel *)selectedModel {
    return [WDBaseWalletCommand shareInstance].passwordModel;
}

+ (NSArray <WDPasswordUserPrivateFileModel *>*)showSelectedWalletDetail {
    return [WDBaseWalletCommand shareInstance].fileModel.my_accounts;
}

+ (void)unlockWithPassword:(NSString *)password withSuccess:(void(^)(BOOL))success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_UNLOCK,password] withSuccess:^(id response) {
        [WDBaseWalletCommand shareInstance].password = password;
        
        success(YES);
    } failture:^(NSString *errMSsg) {
        success(NO);
    } showHud:NO hudText:nil];
}

+ (void)getSuggestKey:(void (^)(WDPasswordUserPrivateFileModel *))key {
    [WDBaseWalletCommand getSuggestKey:key];
}

+ (void)getAllKeys:(void (^)(NSArray *))success {
    NSString *command = [NSString stringWithFormat:@CMD_DUMP_PRIVATE_KEYS];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@""];
}

+ (void)registerUserWithName:(NSString *)name success:(void(^)())success error:(void(^)(NSString *msg))error{
    [WDWalletManager getSuggestKey:^(WDPasswordUserPrivateFileModel *keyModel) {
        NSString *userName = [WDBaseWalletCommand shareInstance].passwordModel.name;
        
//        userName = @"w123456";
        
        NSString *command = [NSString stringWithFormat:@CMD_REGISTER_ACCOUNT,name,keyModel.pub_key,keyModel.pub_key,userName,userName];
        
        [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
            [WDWalletManager addWithUserName:name priKey:keyModel.wif_priv_key success:^{
                success();
            } failture:^(NSString *msg) {
                
            }];
        } failture:^(NSString *errMSsg) {
            error(errMSsg);
        } showHud:YES hudText:@"注册中"];
    }];
    
    
}

+ (void)getMyAccountInfoWithSuccessDo:(void(^)(NSArray *array))success {
    [self getAccountInfoWithName:[WDBaseWalletCommand shareInstance].passwordModel.name withSuccess:^(id response) {
        success(response);
    } errorInfo:^{
        
    }];
}

+ (void)getAccountInfoWithName:(NSString *)name withSuccess:(void(^)(id response))success errorInfo:(void(^)())errorInfo{
    NSString *string = name;
    
    NSString *commmand = [NSString stringWithFormat:@CMD_LIST_ACCOUNT_BALANCES,string];
    
    [WDBaseWalletCommand sendWithApi:YES string:commmand withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        if ([errMSsg rangeOfString:@"rec->name == account_name_or_id"].location != NSNotFound) {
            errorInfo();
        }
    } showHud:YES hudText:@"加载中"];
}

+ (void)getAllAccountInfoWithName:(NSString *)name withSuccess:(void(^)(id response))success errorInfo:(void(^)())errorInfo {
    NSString *command = [NSString stringWithFormat:@CMD_GET_FULL_ACCOUNT,name];
    
    [WDBaseWalletCommand sendWithApi:NO string:command withSuccess:^(id response) {
        NSArray *array = response;
        
        NSArray *firstArray = array.firstObject;
        
        success(firstArray.lastObject);
    } failture:^(NSString *errMSsg) {
        
    } showHud:NO hudText:@""];
}

+ (void)getAssetInfoWithAsset_idOrName:(NSString *)id_name successDo:(void(^)(NSArray *array))success {
    NSString *command = [NSString stringWithFormat:@CMD_LOOKUP_ASSET_SYMBOLS,id_name];
    
    [WDBaseWalletCommand sendWithApi:NO string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"加载中"];
}

+ (void)getBlockInfoWithShowHud:(BOOL)show SuccessDo:(void (^)(NSDictionary *))success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@"%s",CMD_INFO] withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:show hudText:@"加载中"];
}

+ (void)getRecentBlockInfoWithBlockId:(NSString *)blockId showHud:(BOOL)show SuccessDo:(void (^)(NSDictionary *))success {
    [WDBaseWalletCommand sendWithApi:YES string:[NSString stringWithFormat:@CMD_GET_BLOCK,blockId] withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:show hudText:@"加载中"];
}

+ (void)getAccountHistoryWithSuccess:(void (^)(NSArray *array))success {
    NSString *name = [WDBaseWalletCommand shareInstance].passwordModel.name;
    
//    name = @"w123456";
    
    NSString *command = [NSString stringWithFormat:@CMD_GET_ACCOUNT_HISTORY,name,100];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"区块信息加载中"];
}

+ (void)sendTransferToUser:(NSString *)userName amount:(NSString *)amount symbol:(NSString *)symbol memo:(NSString *)memo feePrice:(NSString *)feePrice feeSymbol:(NSString *)feeSymbol success:(void(^)(NSDictionary *result))success failture:(void(^)(NSString *msg))failture {
    if (memo.length == 0) {
        memo = @"\"\"";
    }
//    amount = @"100";
//    userName = @"w123456";
    NSString *name = [WDBaseWalletCommand shareInstance].passwordModel.name;
//    name = @"w123456";
    NSString *command = [NSString stringWithFormat:@CMD_TRANSFER,name,userName,amount,symbol,memo,@"true",feePrice,feeSymbol];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        failture(errMSsg);
    } showHud:YES hudText:@"转账中"];
}

+ (void)getFeeWithKind:(ChainTypes_operations)kind success:(void(^)(NSDictionary *result))success {
    NSString *command = [NSString stringWithFormat:@CMD_GET_OBJECT];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        NSArray *array = response;
        NSDictionary *baseDic = array.firstObject;
        NSArray *baseTargetArray = baseDic[@"parameters"][@"current_fees"][@"parameters"];
        if (baseTargetArray.count > kind) {
            NSArray *targetArray = baseTargetArray[kind];
            
            NSDictionary *targetResult = targetArray[1];
            
            success(targetResult);
        }
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"加载中"];
}

+ (void)getAllCoinKindWithSuccess:(void(^)(NSArray *result))success {
    NSString *command = [NSString stringWithFormat:@CMD_LIST_ASSETS,100];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"加载中"];
}

+ (void)getPriceFromBaseCoin:(NSString *)baseCoinName quoteCoin:(NSString *)quoteCoin withSuccess:(void(^)(NSDictionary *dic))success {
    NSString *command = [NSString stringWithFormat:@CMD_GET_TRADE,baseCoinName,quoteCoin];
    
    [WDBaseWalletCommand sendWithApi:NO string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"加载中"];
}

+ (void)getTradeBuy_SellWithTotalNum:(NSInteger)totalNum show:(BOOL)show ListWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin withSuccess:(void(^)(NSDictionary *dic))success {
    NSString *command = [NSString stringWithFormat:@CMD_GET_ORDER_BOOK,baseCoin,quetoCoin,(int)totalNum];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:show hudText:@"加载中"];
}

+ (void)sellCoinWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin price:(NSString *)price amount:(NSString *)amount serviceCharge:(NSString *)serviceCharge success:(void (^)())success {
    CGFloat total = [price doubleValue] * [amount doubleValue];
    
    NSString *buyer = baseCoin;
    NSString *buyAmount = [NSString stringWithFormat:@"%.5f",total];
    NSString *seller = quetoCoin;
    NSString *sellAmount = amount;
    
    NSString *command = [NSString stringWithFormat:@CMD_SELL_ASSET,[WDBaseWalletCommand shareInstance].passwordModel.name,sellAmount,seller,buyAmount,buyer,serviceCharge,seller];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success();
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"加载中"];
}

+ (void)buyCoinWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin price:(NSString *)price amount:(NSString *)amount serviceCharge:(NSString *)serviceCharge success:(void (^)())success {
    
    CGFloat total = [price doubleValue] * [amount doubleValue];
    
    NSString *buyer = quetoCoin;
    NSString *buyAmount = amount;
    NSString *seller = baseCoin;
    NSString *sellAmount = [NSString stringWithFormat:@"%.5f",total];
    
    
    NSString *command = [NSString stringWithFormat:@CMD_SELL_ASSET,[WDBaseWalletCommand shareInstance].passwordModel.name,sellAmount,seller,buyAmount,buyer,serviceCharge,seller];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success();
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:@"加载中"];
}

+ (void)cancleOrderWithOrderId:(NSString *)orderId success:(void(^)())success error:(void(^)())error{
    NSString *command = [NSString stringWithFormat:@CMD_CANCAL,orderId];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success();
    } failture:^(NSString *errMSsg) {
        error();
    } showHud:YES hudText:@"提交中"];
}

+ (void)getTradeHistoryWithBaseCoinName:(NSString *)baseCoinName quoteCoin:(NSString *)quoteCoin success:(void(^)(NSArray *))success {
    NSString *command = [NSString stringWithFormat:@CMD_GET_TRADE_HISTORY,baseCoinName,quoteCoin,[[NSDate date] UTCString],[[NSDate dateWithTimeInterval:(-60 * 60 * 24 * 365) sinceDate:[NSDate date]] UTCString],100];
    
    [WDBaseWalletCommand sendWithApi:NO string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:YES hudText:nil];
}

+ (void)getKLineWithBaseCoin:(NSString *)baseCoin quoteCoin:(NSString *)quoteCoin bucket:(NSInteger)bucket start:(NSString *)start end:(NSString *)end withSuccess:(void(^)(NSArray *))success {
    NSString *command = [NSString stringWithFormat:@CMD_GET_MARKET_HISTORY,baseCoin,quoteCoin,bucket,start,end];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        success(response);
    } failture:^(NSString *errMSsg) {
        
    } showHud:NO hudText:@""];
}

+ (void)updateVipWithsuccess:(void(^)())success error:(void(^)(NSString *msg))error{
    NSString *command = [NSString stringWithFormat:@CMD_UPGRADE_ACCOUNT,[WDBaseWalletCommand shareInstance].passwordModel.name];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        [WDBaseWalletCommand shareInstance].passwordModel.isLifeTime = YES;
        [self saveFileToPath:[WDBaseWalletCommand shareInstance].filePath withSuccess:^{
            success();
        }];
    } failture:^(NSString *errMSsg) {
        error(errMSsg);
    } showHud:YES hudText:@"提交中"];
}

+ (void)getKeyFromPassword:(NSString *)password success:(void(^)(NSDictionary *dic))success {
    NSString *command = [NSString stringWithFormat:@CMD_DRIVE_OWNER_KEY,password];
    
    [WDBaseWalletCommand sendWithApi:YES string:command withSuccess:^(id response) {
        NSArray *array = response;
        success(array.firstObject);
    } failture:^(NSString *errMSsg) {
        
    } showHud:NO hudText:@""];
}

@end
