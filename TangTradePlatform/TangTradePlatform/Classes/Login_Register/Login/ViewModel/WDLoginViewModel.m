//
//  WDLoginViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/20.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginViewModel.h"
#import "WDLogin_RegisterModel.h"
#import "WDNetworkManager.h"

@implementation WDLoginViewModel


- (void)loginWithSuccess:(void (^)())success failture:(void (^)())failture error:(void (^)())error {
    WDLogin_RegisterModel *model = [[WDLogin_RegisterModel alloc] initFromViewModel:self];
    
    DLog(@"%@",[model dictionaryFromModel]);
    
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

@end
