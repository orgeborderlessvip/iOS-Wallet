//
//  WDTiXianChildViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTiXianChildViewModel.h"
#import "WDBaseChengDuiUploadModel.h"
#import "WDAcceptance_CointypeDataModel.h"
#import "WDNetworkManager.h"
#import "WDCoinTypeWayDataModel.h"
@implementation WDTiXianChildViewModel

- (instancetype)initWithPayId:(NSInteger)payId name:(NSString *)name{
    if (self = [super initWithPayId:payId name:name]) {
        [self modelPrepare];
    }
    return self;
}

- (void)tiXianActionWithSuccess:(void(^)())success failture:(void(^)())failture{
    NSMutableDictionary *dic = [self getCurrentPayDic];
    NSString *realAccount = @"";
    NSString *holder = @"";
    switch (self.selectedStyleIndex) {
        case SelectedPayKindCNYCard:
        case SelectedPayKindUSDCard:
            realAccount = self.accountText;
            holder = self.cardName;
            break;
        case SelectedPayKindBTCWallet:
        case SelectedPayKindCNYAlipay:
        case SelectedPayKindCNYWeChat:
            realAccount = self.cardName;
            break;
    }
    dic[@"holeder"] = holder;
    dic[@"bankname"] = self.bankText;
    dic[@"account"] = realAccount;
    WDBaseChengDuiUploadModel *model = [WDBaseChengDuiUploadModel modelWithCode:@"api_acceptance_cashout" prm:@[dic]];
    
    [WDNetworkManager createWithBaseUrl:URL_ChengDui WithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:nil];
        
        if (model.status) {
            success();
        }else {
            failture();
        }
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"提交中"];
}

- (void)getPayCurrenyData {
    [self getPayCurrenyDataWithType:1];
}

- (void)getPayCoinTypeWay {
    [self getPayCoinTypeWayWithType:1];
}
@end
