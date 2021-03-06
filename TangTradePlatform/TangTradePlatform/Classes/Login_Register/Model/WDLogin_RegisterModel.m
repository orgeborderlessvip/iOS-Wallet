//
//  WDLogin_RegisterModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLogin_RegisterModel.h"
#import "WDLoginViewModel.h"
#import "WDRegisterViewModel.h"
#import "HttpCommunicateDefine.h"
@implementation WDLogin_RegisterModel

- (instancetype)initFromViewModel:(id)viewModel {
    if (self = [super init]) {
        if ([viewModel isKindOfClass:[WDLoginViewModel class]]) {
            WDLoginViewModel *model = (WDLoginViewModel *)viewModel;
            
            self.name = model.userName;
            
            self.api_code = [NSString stringWithFormat:@"%s",cHttpMethod[HTTP_COMMAND_LIST_Login]];
        }
        
        if ([viewModel isKindOfClass:[WDRegisterViewModel class]]) {
            WDRegisterViewModel *model = (WDRegisterViewModel *)viewModel;
            
            self.name = model.userName;
//            self.password = model.password;
            
            self.api_code = [NSString stringWithFormat:@"%s",cHttpMethod[HTTP_COMMAND_LIST_Register]];
        }
    }
    return self;
}


@end
