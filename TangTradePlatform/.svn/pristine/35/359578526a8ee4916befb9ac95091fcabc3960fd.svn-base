//
//  WDTradeDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDTradeDataModel : NSObject<ModelProtocol>

/**
 当前币种
 */
@property (nonatomic,copy) NSString *quote;

/**
 基础币种
 */
@property (nonatomic,copy) NSString *base;

/**
 最新价格
 */
@property (nonatomic,assign) CGFloat latest;

/**
 最低卖出价
 */
@property (nonatomic,assign) CGFloat lowest_ask;

/**
 最高买入价
 */
@property (nonatomic,assign) CGFloat highest_bid;

/**
 基础资产数量
 */
@property (nonatomic,assign) CGFloat base_volume;

/**
 报价资产数量
 */
@property (nonatomic,assign) CGFloat quote_volume;

/**
 涨幅
 */
@property (nonatomic,assign,readonly) CGFloat rose;

/**
 交易金额
 */
@property (nonatomic,assign,readonly) CGFloat jiaoYiE;



@end
