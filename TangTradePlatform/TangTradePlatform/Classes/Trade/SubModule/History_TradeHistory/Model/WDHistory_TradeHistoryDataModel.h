//
//  WDHistory_TradeHistoryDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WDHomeTableDataModel.h"

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

@property (nonatomic,assign) BOOL isSell;

@property (nonatomic,assign) BOOL isCurrentKind;


@property (nonatomic,strong) WDHomeTableDataModel *baseModel;
@property (nonatomic,strong) WDHomeTableDataModel *quoteModel;

+ (instancetype)modelToDic:(NSDictionary *)dic WithBaseModel:(WDHomeTableDataModel *)baseModel quoteModel:(WDHomeTableDataModel *)quoteModel;

@end
