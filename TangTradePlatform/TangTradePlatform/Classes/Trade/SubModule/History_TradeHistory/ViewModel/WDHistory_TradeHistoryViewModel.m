//
//  WDHistory_TradeHistoryViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHistory_TradeHistoryViewModel.h"
#import "WDBuy_SellBaseResultModel.h"
#import "WDHistory_TradeHistoryDataModel.h"
#import "WDHomeTableDataModel.h"

@interface WDHistory_TradeHistoryViewModel ()

@property (nonatomic,strong) WDHomeTableDataModel *baseModel;

@property (nonatomic,strong) WDHomeTableDataModel *quoteModel;

@end

@implementation WDHistory_TradeHistoryViewModel

- (instancetype)initWithKind:(NSInteger)kind BaseCoin:(NSString *)baseCoin queToCoin:(NSString *)quetoCoin {
    if (self = [super init]) {
        self.baseCoin = baseCoin;
        self.quetoCoin = quetoCoin;
        
        _kind = kind;
    }
    return self;
}

- (void)setQuetoCoin:(NSString *)quetoCoin {
    _quetoCoin = quetoCoin;
    
    [WDWalletManager getAssetInfoWithAsset_idOrName:[NSString stringWithFormat:@"%@,%@",_baseCoin,_quetoCoin] successDo:^(NSArray *array) {
        NSDictionary *base = array.firstObject;
        NSDictionary *second = array.lastObject;
        
        _baseModel = [WDHomeTableDataModel modelToDic:base];
        
        _quoteModel = [WDHomeTableDataModel modelToDic:second];
    }];
}

- (void)getData {
    switch (_kind) {
        case 0:{
            [WDWalletManager getAccountHistoryWithSuccess:^(NSArray *array) {
                NSMutableArray *dataArray = [NSMutableArray array];
                
                for (NSDictionary *dic in array) {
                    if ([dic[@"description"] rangeOfString:@"fill_order_operation"].location != NSNotFound) {
                        WDHistory_TradeHistoryDataModel *data = [WDHistory_TradeHistoryDataModel modelToDic:dic[@"op"] WithBaseModel:self.baseModel quoteModel:self.quoteModel];
                        
                        
                        
                        if (data.isCurrentKind) {
                            [dataArray addObject:data];
                        }
                    }
                }
                
                self.dataArray = dataArray;
            }];
        }
            break;
        case 1:{
            [WDWalletManager getTradeHistoryWithBaseCoinName:self.baseCoin quoteCoin:self.quetoCoin success:^(NSArray *array) {
                NSMutableArray *realArray = [NSMutableArray array];
                
                for (NSDictionary *dic in array) {
                    [realArray addObject:[WDHistory_TradeHistoryDataModel modelToDic:dic]];
                }
                self.dataArray = realArray;
            }];
        }
            break;
        default:
            break;
    }
}

- (void)testGetData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"history_Trade_History" ofType:@"json"]];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = [WDSocketBaseModel modelToDic:dic withDataModelTransFormName:@"WDHistory_TradeHistoryDataModel"].result;
    });
}

@end
