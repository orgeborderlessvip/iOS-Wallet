//
//  WDMeViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMeViewModel.h"
#import "WDUploadGetHistoryModel.h"
#import "WDMeTransactionModel.h"
#import "WDNetworkManager.h"
@implementation WDMeViewModel

- (void)loadData {    
    WDUploadGetHistoryModel *model = [[WDUploadGetHistoryModel alloc] init];
    
    model.name = [WDNetworkManager sharedInstance].userName;
    
    model.api_code = [NSString stringWithFormat:@"%s",cHttpMethod[HTTP_COMMAND_LIST_History]];
    
    [WDNetworkManager createRequestWithParam:[model dictionaryFromModel] withMethod:POST success:^(id result) {
        WDBaseResultModel *resultModel = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDMeTransactionModel"];
        
        if (resultModel.status) {
            self.dataArray = resultModel.data;
            
            [self.dataSubject sendNext:self.dataArray];
        }else {
            NSError *error = [NSError errorWithDomain:@"System Error" code:10000 userInfo:nil];
            
            [self.dataSubject sendError:error];
        }
    } failure:^(NSError *erro) {
        [self.dataSubject sendError:erro];
    } showHUD:YES showText:@"加载中"];
}

- (void)loadTestData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"]];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    WDBaseResultModel *model = [WDBaseResultModel modelToDic:dic withDataModelTransFormName:@"WDMeTransactionModel"];
    
    if (model.status) {
        self.dataArray = model.data;
        
        [self.dataSubject sendNext:self.dataArray];
    }else {
        NSError *error = [NSError errorWithDomain:@"System Error" code:10000 userInfo:nil];
        
        [self.dataSubject sendError:error];
    }
}

- (RACSubject *)dataSubject {
    if (!_dataSubject) {
        _dataSubject = [RACSubject subject];
    }
    return _dataSubject;
}

@end
