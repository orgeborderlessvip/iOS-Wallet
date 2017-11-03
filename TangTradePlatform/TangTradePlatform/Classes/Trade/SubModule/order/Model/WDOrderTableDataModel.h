//
//  WDOrderTableDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,JudgeKind) {
    JudgeKind_UnFound,
    JudgeKind_Buy,
    JudgeKind_Sell
};
@class WDHomeTableDataModel;
@interface WDOrderTableDataModel : NSObject

@property (nonatomic,copy) NSString *identifier;

/**
 价格
 */
@property (nonatomic,copy) NSString *price;

@property (nonatomic,strong) WDHomeTableDataModel *base;

@property (nonatomic,strong) WDHomeTableDataModel *quote;

/**
 图片上BTC
 */
@property (nonatomic,copy) NSString *coinAmount;

/**
 图片上BDSBTC
 */
@property (nonatomic,copy) NSString *coinTotalAmount;

/**
 时间
 */
@property (nonatomic,copy) NSString *riseTime;

/**
 状态
 */
@property (nonatomic,assign) JudgeKind isCurrentKind;



+ (instancetype)modelToDic:(NSDictionary *)dic withBaseId:(WDHomeTableDataModel *)base quetoId:(WDHomeTableDataModel *)quetoId;

@end
