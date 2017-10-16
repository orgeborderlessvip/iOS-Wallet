//
//  WDChengDuiRecordViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiRecordViewModel.h"
#import "WDChengDuiRecordDataModel.h"
#import "WDNetworkManager.h"
#import "WDBaseChengDuiUploadModel.h"
@implementation WDChengDuiRecordViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getInData];
        [self getOutData];
    }
    return self;
}

- (void)getInData {
    WDBaseChengDuiUploadModel *result = [WDBaseChengDuiUploadModel modelWithCode:@"api_acceptance_cashinlist" prm:@[@{@"name":@"36"}]];
    
    [WDNetworkManager createWithBaseUrl:URL_ChengDui WithParam:[result dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDChengDuiRecordDataModel"];
        
        if (model.status) {
            self.inArray = model.data;
        }else {
            self.inArray = @[];
        }
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"加载中"];
}

- (void)getOutData {
    WDBaseChengDuiUploadModel *result = [WDBaseChengDuiUploadModel modelWithCode:@"api_acceptance_cashoutlist" prm:@[@{@"name":@"36"}]];
    
    [WDNetworkManager createWithBaseUrl:URL_ChengDui WithParam:[result dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDChengDuiRecordDataModel"];
        
        if (model.status) {
            self.outArray = model.data;
        }else {
            self.outArray = @[];
        }
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:@"加载中"];
}

- (void)testGetData {
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    
    
    for (int i = 0; i < 10; i ++) {
        WDChengDuiRecordDataModel *model = [WDChengDuiRecordDataModel new];
        
        model.paySupportName = @"wang";
        
        model.date = @"2017-08-09";
        
        model.amount = @"100";
        
        model.coinKind = @"BTC";
        
        model.paySupportKind = PaySupportKindComplete;
        
        [array1 addObject:model];
        [array2 addObject:model];
    }
    
    self.inArray = array1;
    self.outArray = array2;
}

@end
