//
//  WDServiceChargeModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDServiceChargeModel : NSObject<ModelProtocol>

@property (nonatomic,copy) NSString *fee;

@property (nonatomic,copy) NSString *price_per_kbyte;

@end
