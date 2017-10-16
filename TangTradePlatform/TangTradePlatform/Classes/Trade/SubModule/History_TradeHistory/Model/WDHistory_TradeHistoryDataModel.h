//
//  WDHistory_TradeHistoryDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WDHistory_TradeHistoryDataModel : NSObject<ModelProtocol>

/**
 riseTime
 */
@property (nonatomic,copy) NSString *date;

/**
 价格
 */
@property (nonatomic,copy) NSString *price;

/**
 BTC
 */
@property (nonatomic,copy) NSString *amount;

/**
 BDSBTC
 */
@property (nonatomic,copy) NSString *value;

@end
