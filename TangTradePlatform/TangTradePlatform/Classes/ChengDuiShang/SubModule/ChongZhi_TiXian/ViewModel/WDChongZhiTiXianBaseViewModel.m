//
//  WDChongZhiTiXianBaseViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/13.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChongZhiTiXianBaseViewModel.h"
#import "WDBaseChengDuiUploadModel.h"
#import "WDAcceptance_CointypeDataModel.h"
#import "WDNetworkManager.h"
#import "WDCoinTypeWayDataModel.h"
@implementation WDChongZhiTiXianBaseViewModel

- (instancetype)initWithPayId:(NSInteger)payId name:(NSString *)name{
    if (self = [super init]) {
        _accId = payId;
        _name = name;
    }
    return self;
}

- (void)modelPrepare {
    @weakify(self);
    
    [RACObserve(self, selectedCurrencyIndex) subscribeNext:^(id x) {
        @strongify(self);
        [self getPayCoinTypeWay];
    }];
    
    [RACObserve(self, payStyleArray) subscribeNext:^(id x) {
        for (WDCoinTypeWayDataModel *item in self.payStyleArray) {
            if (item.cointypeway != SelectedPayKindUSDCard) continue;
            
            if (self.currencyKind == CurrencyKindCNY) {
                item.cointypeway = SelectedPayKindCNYCard;
            }else {
                item.cointypeway = SelectedPayKindUSDCard;
            }
            break;
        }
        WDCoinTypeWayDataModel *data = self.payStyleArray[0];
        
        SelectedPayKind kind = data.cointypeway;
        self.selectedPayStyleKindIndex = 0;
        self.selectedStyleIndex = kind;
    }];
    
    [self getPayCurrenyData];
}

- (void)getPayCurrenyDataWithType:(NSInteger)type {
    WDBaseChengDuiUploadModel *result = [WDBaseChengDuiUploadModel modelWithCode:@"api_acceptance_cointype" prm:@[@{@"accid":[NSString stringWithFormat:@"%ld",self.accId],@"type":[NSString stringWithFormat:@"%ld",type]}]];
    
    [WDNetworkManager createWithBaseUrl:URL_ChengDui WithParam:[result dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDAcceptance_CointypeDataModel"];
        
        self.currencyArray = model.data;
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"加载中"];
}

- (void)getPayCoinTypeWayWithType:(NSInteger)type {
    if (!self.currencyArray.count) return;
    
    WDAcceptance_CointypeDataModel *model = self.currencyArray[self.selectedCurrencyIndex];
    
    WDBaseChengDuiUploadModel *result = [WDBaseChengDuiUploadModel modelWithCode:@"api_acceptance_cointypeway" prm:@[@{@"accid":[NSString stringWithFormat:@"%ld",self.accId],@"type":[NSString stringWithFormat:@"%ld",type],@"payid":model.PayTypeID}]];
    
    [WDNetworkManager createWithBaseUrl:URL_ChengDui WithParam:[result dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDCoinTypeWayDataModel"];
        
        [self setValue:model.data forKey:@"payStyleArray"];
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"加载中"];
}

- (NSMutableDictionary *)getCurrentPayDic {
    WDCoinTypeWayDataModel *wayModel = self.payStyleArray[self.selectedPayStyleKindIndex];
    WDAcceptance_CointypeDataModel *typeModel = self.currencyArray[self.selectedCurrencyIndex];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"accid"] = self.name;
    dic[@"type"] = typeModel.cointyp;
    dic[@"cointypeway"] = wayModel.type;
#warning 户名未完成
    dic[@"name"] = @"36";
    dic[@"count"] = [NSString stringWithFormat:@"%.2f",self.inputMoney];
    return dic;
}

- (void)getPayCoinTypeWay {
    
}
- (void)getPayCurrenyData {
    
}
@end
