//
//  WDChengDuiViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiViewModel.h"
#import "WDChengDuiShangTableDataModel.h"
#import "WDNetworkManager.h"
#import "WDBaseChengDuiUploadModel.h"
@implementation WDChengDuiViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self getData];
        
//        [self testGetData];
    }
    return self;
}

- (void)getData{
    WDBaseChengDuiUploadModel *result = [WDBaseChengDuiUploadModel modelWithCode:@"api_acceptance_list" prm:nil];
    
    [WDNetworkManager createWithBaseUrl:URL_ChengDui WithParam:[result dictionaryFromModel] withMethod:GET success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDChengDuiShangTableDataModel"];
        
        self.dataArray = model.data;
    
    } failure:^(NSError *erro) {
        
    } showHUD:YES showText:nil];
}

- (void)testGetData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 9; i ++) {
        NSInteger rank = arc4random()%11;
        
        WDChengDuiShangTableDataModel *dataModel = [WDChengDuiShangTableDataModel new];
        
        dataModel.paySupportName = @"JSD";
        
        dataModel.paySupportDetail = @"WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW";
        
        dataModel.paySupportRanking = rank;
        
        dataModel.paySupportArray = @[@"Alipay",@"Alipay",@"Alipay",@"Alipay",@"Alipay",@"Alipay",@"Alipay",@"Alipay",@"Alipay"];
        
        [array addObject:dataModel];
    }
    
    self.dataArray = array;
}

@end
