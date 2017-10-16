//
//  WDOrderTableDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDOrderTableDataModel : NSObject<ModelProtocol>

/**
 价格
 */
@property (nonatomic,copy) NSString *price;

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
@property (nonatomic,assign) NSInteger operationState;



@end
