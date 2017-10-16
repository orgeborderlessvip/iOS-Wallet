//
//  WDChongZhiTiXianBaseViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/13.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDChongZhiTiXianBaseHeader.h"
@interface WDChongZhiTiXianBaseViewModel : NSObject

@property (nonatomic,assign) CGFloat myMoney;


/**
 承兑商ID
 */
@property (nonatomic,assign) NSInteger accId;

@property (nonatomic,copy) NSString *name;

/**
 货币币种
 */
@property (nonatomic,strong) NSArray *currencyArray;

/**
 内部判断货币币种选择方式
 */
@property (nonatomic,assign) CurrencyKind currencyKind;

/**
 真正货币币种选择
 */
@property (nonatomic,assign) NSInteger selectedCurrencyIndex;

/**
 选择币种下承兑商支持的支付方式
 */
@property (nonatomic,strong,readonly) NSArray *payStyleArray;

/**
 支付方式
 */
@property (nonatomic,assign) SelectedPayKind selectedStyleIndex;

/**
 真正支付方式
 */
@property (nonatomic,assign) NSInteger selectedPayStyleKindIndex;

@property (nonatomic,assign) CGFloat inputMoney;

- (instancetype)initWithPayId:(NSInteger)payId name:(NSString *)name;

/**
 准备Model绑定相关，用于子类调用
 */
- (void)modelPrepare;


- (void)getPayCurrenyDataWithType:(NSInteger)type;

- (void)getPayCoinTypeWayWithType:(NSInteger)type;

- (void)getPayCurrenyData;

- (void)getPayCoinTypeWay;

/**
 获取所有数据
 */
- (NSMutableDictionary *)getCurrentPayDic;

@end
