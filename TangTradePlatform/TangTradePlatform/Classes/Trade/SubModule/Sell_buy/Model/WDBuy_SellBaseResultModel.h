//
//  WDBuy_SellBaseResultModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBuy_SellBaseResultModel : NSObject<ModelProtocol>

@property (nonatomic,copy) NSString *base;

@property (nonatomic,copy) NSString *quote;

/**
 买单
 */
@property (nonatomic,strong) NSArray *bids;

/**
 卖单
 */
@property (nonatomic,strong) NSArray *asks;

@end
