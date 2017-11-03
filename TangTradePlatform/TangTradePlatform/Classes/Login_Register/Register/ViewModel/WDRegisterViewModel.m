//
//  WDRegisterViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDRegisterViewModel.h"
#import "WDNetworkManager.h"
#import "WDLogin_RegisterModel.h"
#import "WDBaseChengDuiUploadModel.h"
@implementation WDRegisterViewModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)registerWithSuccess:(void (^)())success failture:(void (^)(NSString *msg))failture error:(void (^)())error {
    [WDWalletManager getSuggestKey:^(WDPasswordUserPrivateFileModel *key) {
        key.name = self.userName;
        
        WDBaseChengDuiUploadModel *model = [WDBaseChengDuiUploadModel modelWithCode:@"register_account" prm:@[({
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"accountname"] = key.name;
            dic[@"publickey"] = key.pub_key;
            dic[@"referreraccount"] = self.tuijianRen == nil?@"":self.tuijianRen;
            dic;
        })]];
        
        NSMutableDictionary *dic = [[model dictionaryFromModel] mutableCopy];
        
        switch ([WDInternationalCenter userLanguage]) {
            case LanguageKindCNS:
                dic[@"lang"] = @"zh_cn";
                break;
            case LanguageKindEN:
                dic[@"lang"] = @"en";
                break;
            case LanguageKindCNT:
                dic[@"lang"] = @"zh_hk";
                break;
        }
        
        [WDNetworkManager createWithBaseUrl:URL_Register WithParam:dic withMethod:POST success:^(id result) {
            WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@""];
            
            if (model.status) {
                [WDWalletManager addWithUserName:key.name priKey:key.wif_priv_key success:^{
                    success();
                } failture:^(NSString *msg) {
                    
                }];
            }else {
                failture(model.msg);
            }
            
            
            
            
            
        } failure:^(NSError *erro) {
            
        } showHUD:YES showText:@"加载中"];
    }];
    
//    WDLogin_RegisterModel *model = [[WDLogin_RegisterModel alloc] initFromViewModel:self];
//    
//    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
//        WDBaseResultModel *resultModel = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@""];
//        if (resultModel.status) {
//            success();
//        }else {
//            failture();
//        }
//        
//    } failure:^(NSError *erro) {
//        error();
//    } showHUD:YES showText:@"加载中"];
}

- (void)clear {
    
    self.userName = @"";
    
}

@end
