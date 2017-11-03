//
//  WDUploadServiceChargeModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDUploadServiceChargeModel.h"
#import "HttpCommunicateDefine.h"
@implementation WDUploadServiceChargeModel

- (instancetype)init {
    if (self = [super init]) {
        self.api_code = [NSString stringWithUTF8String:cHttpMethod[HTTP_COMMAND_LIST_Service_Charge]];
        
        self.feeid = @"0";
    }
    return self;
}

@end
