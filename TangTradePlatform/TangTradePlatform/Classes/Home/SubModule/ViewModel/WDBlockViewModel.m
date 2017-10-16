//
//  WDBlockViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBlockViewModel.h"
#import "WDBlockDataModel.h"
#import "WDNetworkManager.h"
@implementation WDBlockViewModel

- (void)loadHeadData {
    [self loadHeadDataWithShow:YES];
}

- (void)loadHeadDataWithShow:(BOOL)show {
    NSDictionary *dic = @{@"api_code":@"get_blockchain_infor"};
    
    [WDNetworkManager createRequestWithParam:dic withMethod:POST success:^(id result) {
        WDBaseResultModel *resultModel = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDBlockDataModel"];
        
        if (resultModel.status) {
            if ([[UIViewController currentViewController] isKindOfClass:NSClassFromString(@"WDBlockViewController")]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self loadHeadDataWithShow:NO];
                });
            }
            if (resultModel.data.count) {
                [self updateFromModel:resultModel.data.firstObject];
            }
        }else {
            
        }
    } failure:^(NSError *erro) {
        
        if ([[UIViewController currentViewController] isKindOfClass:NSClassFromString(@"WDBlockViewController")]) {
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"网络连接失败,请稍后再试" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }
        
    } showHUD:show showText:@"加载中"];
 }
- (void)updateFromModel:(WDBlockDataModel *)model {
    self.currentBlock = model.head_block_num;
    
    self.headBlockAge = model.head_block_age;
    
    self.activeWitness = [NSString stringWithFormat:@"%ld",model.active_witnesses.count];
    
    self.nextMainTime = model.next_maintenance_time;
    
    self.activeCommitteeMember = [NSString stringWithFormat:@"%ld",model.active_committee_members.count];
    
    [self loadDetailDataWithPage:[[model.head_block_num substringFromIndex:1] integerValue]];
}

- (void)loadDetailDataWithPage:(NSInteger)page showHud:(BOOL)show success:(void(^)(NSArray *data))success failture:(void(^)())failture error:(void(^)())error{
    NSDictionary *dic = @{@"api_code":@"get_block_infor",@"blocknumber":[NSString stringWithFormat:@"%ld",page]};
    
    [WDNetworkManager createRequestWithParam:dic withMethod:POST success:^(id result) {
        WDBaseResultModel *model = [WDBaseResultModel modelToDic:result withDataModelTransFormName:@"WDBlockTableDataModel"];
        
        if (model.status) {
            success(model.data);
        }else {
            failture();
        }
        
    } failure:^(NSError *erro) {
        error();
    } showHUD:NO showText:@"加载中"];
}

- (void)loadDetailDataWithPage:(NSInteger)page {
    [self loadDetailDataWithPage:page showHud:NO success:^(NSArray *data) {
        [self.clearSubject sendNext:nil];
        
        [self.dataSubject sendNext:data];
    } failture:^{
        [self.dataSubject sendError:nil];
    } error:^{
        [self.dataSubject sendError:[NSError errorWithDomain:@"111" code:0 userInfo:nil]];
    }];
}
- (RACSubject *)dataSubject {
    if (!_dataSubject) {
        _dataSubject = [RACSubject subject];
    }
    return _dataSubject;
}
- (RACSubject *)clearSubject {
    if (!_clearSubject) {
        _clearSubject = [RACSubject subject];
    }
    return _clearSubject;
}
@end
