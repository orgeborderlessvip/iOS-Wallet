//
//  WDVipFeeModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDVipFeeModel : NSObject<ModelProtocol>

@property (nonatomic,assign) CGFloat membership_lifetime_fee;

@property (nonatomic,assign) CGFloat membership_annual_fee;

@end
