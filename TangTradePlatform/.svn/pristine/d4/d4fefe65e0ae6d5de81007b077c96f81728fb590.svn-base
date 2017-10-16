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
@implementation WDRegisterViewModel

- (instancetype)init {
    if (self = [super init]) {
        _hiddenLabel = YES;
    }
    return self;
}

- (RACSubject *)registerSubject {
    if (!_registerSubject) {
        _registerSubject = [RACSubject subject];
    }
    return _registerSubject;
}

- (RACSubject *)backSubject {
    if (!_backSubject) {
        _backSubject = [RACSubject subject];
    }
    return _backSubject;
}

- (void)registerWithSuccess:(void (^)())success failture:(void (^)())failture error:(void (^)())error {
    WDLogin_RegisterModel *model = [[WDLogin_RegisterModel alloc] initFromViewModel:self];
    
    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *resultModel = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@""];
        if (resultModel.status) {
            success();
        }else {
            failture();
        }
        
    } failure:^(NSError *erro) {
        error();
    } showHUD:YES showText:@"加载中"];
}

- (void)clear {
    self.hiddenLabel = YES;
    self.userName = @"";
    self.password = @"";
    self.confirmPassword = @"";
    
}

@end
