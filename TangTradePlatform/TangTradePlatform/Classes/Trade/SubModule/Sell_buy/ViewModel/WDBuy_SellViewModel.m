//
//  WDBuy_SellViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBuy_SellViewModel.h"
#import "WDBuy_SellBaseResultModel.h"
#import "WDSendOutViewModel.h"
#import "WDHomeTableDataModel.h"

#import "NSString+changeTest.h"
@interface WDBuy_SellViewModel ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation WDBuy_SellViewModel

- (instancetype)initWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin isBuy:(BOOL)isBuy {
    if (self = [super init]) {
        _baseCoin = baseCoin;
        _quetoCoin = quetoCoin;
        _isBuy = isBuy;
        
        RAC(self,turnOver) = [RACSignal combineLatest:@[RACObserve(self, amount),RACObserve(self, price)] reduce:^id(NSNumber *amount,NSNumber *price){
            return @([amount doubleValue] * [price doubleValue]);
        }];
        
    }
    return self;
}

- (void)getAllData {
    [self getBuyData];
    [self getServiceChargeData];
    [self getMyData];
}

- (void)setQuetoCoin:(NSString *)quetoCoin {
    _quetoCoin = quetoCoin;

//    [self getBuyData];
}

- (void)getBuyData {
    [WDWalletManager getTradeBuy_SellWithTotalNum:50 show:YES ListWithBaseCoin:self.baseCoin quetoCoin:self.quetoCoin withSuccess:^(NSDictionary *dic) {
        WDBuy_SellBaseResultModel *model = [WDBuy_SellBaseResultModel modelToDic:dic];
        
        self.buyArray = model.asks;
        self.sellArray = model.bids;
    }];
}

- (void)getServiceChargeData {
    self.serviceSymbol  = self.isBuy?self.baseCoin:self.quetoCoin;
    
    if ([_serviceSymbol isEqualToString:@"BDS"]) {
        [WDWalletManager getFeeWithKind:limit_order_create success:^(NSDictionary *result) {
            CGFloat fee = [result[@"fee"] doubleValue] / 100000;
            self.serviceCharge = fee;
        }];
    }else {
        [WDWalletManager getAssetInfoWithAsset_idOrName:[NSString stringWithFormat:@"%@",self.serviceSymbol] successDo:^(NSArray *array) {
            WDHomeTableDataModel *table = [WDHomeTableDataModel modelToDic:array.firstObject];
            
            [WDWalletManager getFeeWithKind:limit_order_create success:^(NSDictionary *result) {
                CGFloat fee = [result[@"fee"] doubleValue] / 100000;
                self.serviceCharge = fee * table.rate;
                
                if ([table.coinName isEqualToString:@"BTC"]) {
                    self.serviceCharge += pow(10, -BTCLength);
                }else if (![table.coinName isEqualToString:@"BDS"]){
                    self.serviceCharge += pow(10, -5);
                }
            }];
        }];
    }
}

- (void)getMyData {

        [WDSendOutViewModel loadMyDataWithSuccess:^(NSArray *dataArray) {
            for (WDHomeTableDataModel *data in dataArray) {
                
                NSString *string = self.isBuy?self.baseCoin:self.quetoCoin;
                
                if ([data.coinName isEqualToString:string]) {
                    self.myAount = data.coinPrice.doubleValue;
                }
            }
        } error:^{
            
        }];
    
}

- (void)getBestBids {
    
}

- (void)testGetBuy_SellData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buy_sell_test" ofType:@"json"]];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
    WDBuy_SellBaseResultModel *model = [WDSocketBaseModel modelToDic:dic withDataModelTransFormName:@"WDBuy_SellBaseResultModel"].result;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.buyArray = model.bids;
        self.sellArray = model.asks;
    });
}

- (void)sendPay {
    CGFloat amount = self.isBuy?self.turnOver:self.amount;
    
    BOOL enable = self.myAount > (amount + self.serviceCharge);
    BOOL amountEnable = self.amount > 0;
    BOOL priceAmount = self.price > 0;
    
    if (enable && amountEnable && priceAmount) {
        if (self.isBuy) {
            NSString *fee = [[NSString stringWithFormat:@"%.10f",self.serviceCharge] digitalNumberWithMaxLength:[self.serviceSymbol isEqualToString:@"BTC"]?BTCLength:5];
            
            [WDWalletManager buyCoinWithBaseCoin:self.baseCoin quetoCoin:self.quetoCoin price:[NSString stringWithFormat:@"%.5f",self.price] amount:[NSString stringWithFormat:@"%.5f",self.amount] serviceCharge:fee success:^{
                [self getMyData];
                [self getBuyData];
                
                [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"发布成功" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                    
                }];
            }];
        }else {
            NSString *fee = [[NSString stringWithFormat:@"%.10f",self.serviceCharge] digitalNumberWithMaxLength:[self.serviceSymbol isEqualToString:@"BTC"]?BTCLength:5];
            
            [WDWalletManager sellCoinWithBaseCoin:self.baseCoin quetoCoin:self.quetoCoin price:[NSString stringWithFormat:@"%.5f",self.price] amount:[NSString stringWithFormat:@"%.5f",self.amount] serviceCharge:fee success:^{
                [self getMyData];
                [self getBuyData];
                
                [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"发布成功" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                    
                }];
            }];
            
            
        }
    }else {
        
        NSString *message = nil;
        
        if (!enable) {
            message = @"余额不足";
        }
        
        if (!amountEnable) {
            message = @"数量不能为0";
        }
        
        if (!priceAmount) {
            message = @"价格不能为0";
        }
        
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:message withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }
}

- (void)sell {
    
}
@end
