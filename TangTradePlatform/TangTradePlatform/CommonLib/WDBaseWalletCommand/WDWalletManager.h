//
//  WDWalletManager.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WDPasswordUserPrivateFileModel.h"

#import "WDFeeDefine.h"



@interface WDWalletManager : NSObject

+ (NSString *)currecntConnectUrl;

+ (NSString *)currentPassword;

+ (void)setConnectUrl:(NSString *)url;

+ (void)resetCommand;

+ (void)setPassword:(NSString *)password withSuccess:(void(^)(BOOL success))success;

+ (void)saveFileToPath:(NSString *)path withSuccess:(void(^)())success;

+ (void)saveCurrentWithSuccess:(void(^)())success;

+ (BOOL)loadFileToPath:(NSString *)path withSuccess:(void(^)())success;

+ (void)addWithUserName:(NSString *)userName priKey:(NSString *)prikey success:(void(^)())success failture:(void(^)(NSString *msg))failture00;

+ (NSArray <WDPasswordUserPrivateFileModel *>*)showSelectedWalletDetail;

+ (void)setSelectedUserModel:(WDPasswordUserPrivateFileModel *)model;

+ (WDPasswordUserPrivateFileModel *)selectedModel;

+ (void)getSuggestKey:(void(^)(WDPasswordUserPrivateFileModel *))key;

+ (void)getAllKeys:(void(^)(NSArray *keyArray))success;

+ (void)registerUserWithName:(NSString *)name success:(void(^)())success error:(void(^)(NSString *msg))error;
/**
 解锁
 */
+ (void)unlockWithPassword:(NSString *)password withSuccess:(void(^)(BOOL))success;

/**
 获取账户余额
 */
+ (void)getMyAccountInfoWithSuccessDo:(void(^)(NSArray *array))success;

+ (void)getAccountInfoWithName:(NSString *)name withSuccess:(void(^)(id response))success errorInfo:(void(^)())errorInfo;

+ (void)getAllAccountInfoWithName:(NSString *)name withSuccess:(void(^)(id response))success errorInfo:(void(^)())errorInfo;

+ (void)getAssetInfoWithAsset_idOrName:(NSString *)id_name successDo:(void(^)(NSArray *array))success;

/**
 获取区块信息
 */
+ (void)getBlockInfoWithShowHud:(BOOL)show SuccessDo:(void (^)(NSDictionary *result))success;

+ (void)getRecentBlockInfoWithBlockId:(NSString *)blockId showHud:(BOOL)show SuccessDo:(void (^)(NSDictionary *))success;

+ (void)getAccountHistoryWithSuccess:(void (^)(NSArray *array))success;

+ (void)sendTransferToUser:(NSString *)userName amount:(NSString *)amount symbol:(NSString *)symbol memo:(NSString *)memo feePrice:(NSString *)feePrice feeSymbol:(NSString *)feeSymbol success:(void(^)(NSDictionary *result))success failture:(void(^)(NSString *msg))failture;

/**
 获取费率
 */
+ (void)getFeeWithKind:(ChainTypes_operations)kind success:(void(^)(NSDictionary *result))success;

+ (void)getAllCoinKindWithSuccess:(void(^)(NSArray *result))success;

+ (void)getPriceFromBaseCoin:(NSString *)baseCoinName quoteCoin:(NSString *)quoteCoin withSuccess:(void(^)(NSDictionary *dic))success;

+ (void)getTradeBuy_SellWithTotalNum:(NSInteger)totalNum show:(BOOL)show ListWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin withSuccess:(void(^)(NSDictionary *dic))success;

+ (void)buyCoinWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin price:(NSString *)price amount:(NSString *)amount serviceCharge:(NSString *)serviceCharge success:(void (^)())success;

+ (void)sellCoinWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin price:(NSString *)price amount:(NSString *)amount serviceCharge:(NSString *)serviceCharge success:(void (^)())success;

+ (void)cancleOrderWithOrderId:(NSString *)orderId success:(void(^)())success error:(void(^)())error;

+ (void)getTradeHistoryWithBaseCoinName:(NSString *)baseCoinName quoteCoin:(NSString *)quoteCoin success:(void(^)(NSArray *array))success;

+ (void)getKLineWithBaseCoin:(NSString *)baseCoin quoteCoin:(NSString *)quoteCoin bucket:(NSInteger)bucket start:(NSString *)start end:(NSString *)end withSuccess:(void(^)(NSArray *))success;

+ (void)updateVipWithsuccess:(void(^)())success error:(void(^)(NSString *msg))error;

+ (void)getKeyFromPassword:(NSString *)password success:(void(^)(NSDictionary *dic))success;

@end
