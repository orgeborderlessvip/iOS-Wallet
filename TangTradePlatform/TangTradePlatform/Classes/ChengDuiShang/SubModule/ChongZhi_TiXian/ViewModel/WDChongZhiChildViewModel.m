//
//  WDChongZhiChildViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChongZhiChildViewModel.h"
#import "WDBaseChengDuiUploadModel.h"
#import "WDAcceptance_CointypeDataModel.h"
#import "WDNetworkManager.h"
#import "WDCoinTypeWayDataModel.h"
@implementation WDChongZhiChildViewModel

- (instancetype)initWithPayId:(NSInteger)payId name:(NSString *)name{
    if (self = [super initWithPayId:payId name:name]) {
        [self modelPrepare];
    }
    return self;
}

- (void)chongZhiActionWithSuccess:(void(^)())success failture:(void(^)())failture{
    
    WDBaseChengDuiUploadModel *model = [WDBaseChengDuiUploadModel modelWithCode:@"api_acceptance_cashin" prm:@[[self getCurrentPayDic]]];
    
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
    [super getPayCurrenyDataWithType:0];
}

- (void)getPayCoinTypeWay {
    [self getPayCoinTypeWayWithType:0];
}

@end
