//
//  WDSendOutViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDSendOutViewModel.h"
#import "WDNetworkManager.h"
#import "WDUploadGetHistoryModel.h"
#import "WDHomeTableDataModel.h"
#import "WDUploadSendModel.h"
#import "WDUploadServiceChargeModel.h"
#import "WDServiceChargeModel.h"
@implementation WDSendOutViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self loadServiceCharge];
    }
    return self;
}

+ (void)loadCoinDataWithSuccess:(void (^)(NSArray<WDHomeTableDataModel *> *))success {
    [self loadCoinDataWithShowBDS:YES Success:success];
}

+ (void)loadCoinDataWithShowBDS:(BOOL)show Success:(void(^)(NSArray <WDHomeTableDataModel *>*dataArray))success {
    [WDWalletManager getAllCoinKindWithSuccess:^(NSArray *result) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSInteger index = 1000;
        //        @"BDS",@"CNY",@"USD",@"EUR",@"BTC",@"ETH"
        for (NSDictionary *dic in result) {
            WDHomeTableDataModel *dataModel = [WDHomeTableDataModel modelToDic:dic];
            
            if ([dataModel.coinName rangeOfString:@"BDS"].location != NSNotFound) {
                dataModel.index = 0;
                if (!show) {
                    continue;
                }
//                continue;
            }else if ([dataModel.coinName rangeOfString:@"USD"].location != NSNotFound) {
                dataModel.index = 1;
            }else if ([dataModel.coinName rangeOfString:@"CNY"].location != NSNotFound) {
                dataModel.index = 3;
            }else if ([dataModel.coinName rangeOfString:@"EUR"].location != NSNotFound) {
                dataModel.index = 4;
            }else if ([dataModel.coinName isEqualToString:@"BTC"]) {
                dataModel.index = 5;
                dataModel.isSmart = YES;
            }else if ([dataModel.coinName rangeOfString:@"ETH"].location != NSNotFound) {
                dataModel.index = 6;
                continue;
            }else {
                dataModel.index = index;
                index ++;
                continue;
            }
            
            if (dataModel.isSmart || [dataModel.coinName isEqualToString:@"BDS"]) {
                [array addObject:dataModel];
            }
        }
        
        for (int i = 0; i < array.count; i++)
        {
            for (int j = i; j < array.count; j++)
            {
                
                WDHomeTableDataModel *data1 = array[i];
                WDHomeTableDataModel *data2 = array[j];
                if (data1.index > data2.index)
                {
                    
                    array[i] = array[j];
                    array[j] = data1;
                }
            }
        }
        
//        for (int i = 0; i < array.count - 1; i ++) {
//            for (int j = i; j < array.count - 1 - i; j ++) {
//                WDHomeTableDataModel *data1 = array[j];
//                WDHomeTableDataModel *data2 = array[j + 1];
//                
//                if (data1.index > data2.index) {
//                    array[j] = array[j + 1];
//                    array[j + 1] = data1;
//                }
//            }
//        }
        success(array);
    }];
}

+ (void)loadMyDataWithSuccess:(void(^)(NSArray *dataArray))success error:(void(^)())error {
    
    [self loadCoinDataWithSuccess:^(NSArray<WDHomeTableDataModel *> *dataArray) {
        [WDWalletManager getMyAccountInfoWithSuccessDo:^(NSArray *array1) {
            for (NSDictionary *dic in array1) {
                for (WDHomeTableDataModel *data in dataArray) {
                    if ([data.asset_id isEqualToString:dic[@"asset_id"]]) {
                        [data setValuesForKeysWithDictionary:dic];
                        break;
                    }
                }
            }
            
            success(dataArray);
        }];
    }];
    
    /*WDUploadGetHistoryModel *model = [[WDUploadGetHistoryModel alloc] init];
    
    model.api_code = @"list_account_balances";
    
    model.name = [WDNetworkManager sharedInstance].userName;
    
    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *resultModel = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDHomeTableDataModel"];
        
        if (resultModel.status) {
            if (resultModel.data.count) {
                success(((WDHomeTableDataModel *)resultModel.data.firstObject).coinPrice.doubleValue / 100000.f,@"BDS");
            }else {
                success(0,@"BDS");
            }
        }else {
            
        }
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"加载中"];*/
}

+ (void)loadDataAddToArray:(NSMutableArray *)addArray fromArray:(NSArray *)dataArray successDo:(void(^)(NSArray *dataArray))successDo{
    if (addArray.count >= dataArray.count) {
        successDo(addArray);
        return;
    }
    
    NSDictionary *dic = dataArray[addArray.count];
    
    WDHomeTableDataModel *model = [WDHomeTableDataModel modelToDic:dic];
    
    [WDWalletManager getAssetInfoWithAsset_idOrName:model.asset_id successDo:^(NSArray *array) {
        WDHomeTableDataModel *realModel = [WDHomeTableDataModel modelToDic:array.firstObject];
        
        realModel.coinPrice = model.coinPrice;
        
        [addArray addObject:realModel];
        
        [self loadDataAddToArray:addArray fromArray:dataArray successDo:successDo];
    }];
}

- (void)loadMyAccountData {
    [WDSendOutViewModel loadMyDataWithSuccess:^(NSArray *dataArray) {
        for (WDHomeTableDataModel *model in dataArray) {
            if ([model.coinName isEqualToString:@"BDS"]) {
                self.coinKind = model.coinName;
                self.haveAmount = model.coinPrice.doubleValue;
            }
        }
    } error:^{
        
    }];
    
   /* [WDSendOutViewModel loadMyDataWithSuccess:^(CGFloat haveAmount, NSString *coinKind) {
        self.coinKind = coinKind;
        self.haveAmount = haveAmount;
    } error:^{
        
    }];*/
}

- (RACSubject *)sendSubject {
    if (!_sendSubject) {
        _sendSubject = [RACSubject subject];
    }
    return _sendSubject;
}

- (void)sendPay {
    [WDWalletManager sendTransferToUser:self.account amount:[NSString stringWithFormat:@"%.5f",self.amount] symbol:@"BDS" memo:@"" feePrice:self.serviceCharge feeSymbol:@"BDS" success:^(NSDictionary *result) {
        [self.sendSubject sendNext:@[@(YES),@(NO)]];
    } failture:^(NSString *msg) {
        if ([msg rangeOfString:@"insufficient_balance"].location != NSNotFound) {
            [self.sendSubject sendNext:@[@(NO),@(YES)]];
        }else {
            [self.sendSubject sendNext:@[@(NO),@(NO)]];
        }
    }];

//    WDUploadSendModel *model = [[WDUploadSendModel alloc] initWithFrom:[WDNetworkManager sharedInstance].userName to:self.account amount:self.amount symbol:@"BDS"];
//    [[UIViewController currentViewController] showHuDwith:WDLocalizedString(@"提交中")];
//    
//    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
//        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:nil];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [[UIViewController currentViewController] hidenHUD];
//            [self.sendSubject sendNext:@[@(model.status),@([model.msg isEqualToString:@"request rpc data fail"])]];
//        });
//    } failure:^(NSError *erro) {
//        [self.sendSubject sendError:erro];
//    } showHUD:NO showText:@"提交中"];
}

- (void)loadServiceCharge {
    [WDWalletManager getFeeWithKind:transfer success:^(NSDictionary *result) {
        WDServiceChargeModel *model = [WDServiceChargeModel modelToDic:result];
        
        self.serviceCharge = model.fee;
    }];
    
    /*WDUploadServiceChargeModel *model = [[WDUploadServiceChargeModel alloc] init];
    
    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *resultModel = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDServiceChargeModel"];
        
        if (resultModel.status) {
            self.serviceCharge = ((WDServiceChargeModel *)resultModel.data.firstObject).fee;
        }
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"加载中"];*/
}

@end
