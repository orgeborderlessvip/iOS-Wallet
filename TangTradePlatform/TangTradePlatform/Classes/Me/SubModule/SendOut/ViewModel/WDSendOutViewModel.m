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

+ (void)loadMyDataWithSuccess:(void(^)(CGFloat haveAmount,NSString *coinKind))success error:(void(^)())error {
    WDUploadGetHistoryModel *model = [[WDUploadGetHistoryModel alloc] init];
    
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
        
    } showHUD:YES showText:@"加载中"];
}

- (void)loadMyAccountData {
    [WDSendOutViewModel loadMyDataWithSuccess:^(CGFloat haveAmount, NSString *coinKind) {
        self.coinKind = coinKind;
        self.haveAmount = haveAmount;
    } error:^{
        
    }];
}

- (RACSubject *)sendSubject {
    if (!_sendSubject) {
        _sendSubject = [RACSubject subject];
    }
    return _sendSubject;
}

- (void)sendPay {
    WDUploadSendModel *model = [[WDUploadSendModel alloc] initWithFrom:[WDNetworkManager sharedInstance].userName to:self.account amount:self.amount symbol:@"BDS"];
    [[UIViewController currentViewController] showHuDwith:WDLocalizedString(@"提交中")];
    
    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIViewController currentViewController] hidenHUD];
            [self.sendSubject sendNext:@[@(model.status),@([model.msg isEqualToString:@"request rpc data fail"])]];
        });
    } failure:^(NSError *erro) {
        [self.sendSubject sendError:erro];
    } showHUD:NO showText:@"提交中"];
}

- (void)loadServiceCharge {
    WDUploadServiceChargeModel *model = [[WDUploadServiceChargeModel alloc] init];
    
    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *resultModel = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDServiceChargeModel"];
        
        if (resultModel.status) {
            self.serviceCharge = ((WDServiceChargeModel *)resultModel.data.firstObject).fee;
        }
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"加载中"];
}

@end
