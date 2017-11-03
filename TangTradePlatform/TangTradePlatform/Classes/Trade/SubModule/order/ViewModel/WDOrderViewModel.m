//
//  WDOrderViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOrderViewModel.h"
#import "WDOrderTableDataModel.h"

#import "WDHomeTableDataModel.h"

@interface WDOrderViewModel ()

@property (nonatomic,strong) WDHomeTableDataModel *baseModel;

@property (nonatomic,strong) WDHomeTableDataModel *quetoModel;

@end


@implementation WDOrderViewModel

- (instancetype)initWithBaseCoin:(NSString *)baseCoinName quetoCoin:(NSString *)quetoCoinName {
    if (self = [super init]) {
        self.baseCoin = baseCoinName;
        self.quetoCoin = quetoCoinName;
    }
    return self;
}

- (void)setBaseCoin:(NSString *)baseCoin {
    _baseCoin = baseCoin;
}

- (void)setQuetoCoin:(NSString *)quetoCoin {
    _quetoCoin = quetoCoin;
    
    [WDWalletManager getAssetInfoWithAsset_idOrName:[NSString stringWithFormat:@"%@,%@",_baseCoin,_quetoCoin] successDo:^(NSArray *array) {
        NSDictionary *base = array.firstObject;
        NSDictionary *second = array.lastObject;
        
        _baseModel = [WDHomeTableDataModel modelToDic:base];
        
        _quetoModel = [WDHomeTableDataModel modelToDic:second];
        
//        [self getData];
    }];
}

- (void)getData {
    [[UIViewController currentViewController] showHuDwith:@"请求委托信息中"];
    
    [WDWalletManager getAllAccountInfoWithName:[WDWalletManager selectedModel].name withSuccess:^(id response) {
        [[UIViewController currentViewController] hidenHUD];
        
        NSMutableArray *buyArray = [NSMutableArray array];
        NSMutableArray *sellArray = [NSMutableArray array];
        for (NSDictionary *dic in response[@"limit_orders"]) {
            WDOrderTableDataModel *order = [WDOrderTableDataModel modelToDic:dic withBaseId:_baseModel quetoId:_quetoModel];
            
            switch (order.isCurrentKind) {
                case JudgeKind_Sell: {
                    [sellArray addObject:order];
                }
                    break;
                case JudgeKind_Buy:{
                    [buyArray addObject:order];
                }
                    break;
                
                default:
                    break;
            }
        }
        self.dataBuyArray = buyArray;
        self.dataSellArray = sellArray;
    } errorInfo:^{
        [[UIViewController currentViewController] hidenHUD];
    }];
}

- (void)testGetData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++) {
        WDOrderTableDataModel *mdoel = [WDOrderTableDataModel new];
        
        mdoel.price = @"4388.6842";
        mdoel.coinAmount = @"0.08M";
        mdoel.coinTotalAmount = @"30.1k";
        mdoel.riseTime = @"2017/12/27 11:29:01";
        
        
        [array addObject:mdoel];
    }
    
    self.dataBuyArray = array;
    self.dataSellArray = array;
}

- (void)cancleOrderWithSell:(BOOL)sell withIndex:(NSInteger)index {
    NSArray *array = sell?self.dataSellArray:self.dataBuyArray;
    
    WDOrderTableDataModel *model = array[index];
    
    [WDWalletManager cancleOrderWithOrderId:model.identifier success:^{
        [self getData];
    } error:^{
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"取消失败" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }];
}

@end
