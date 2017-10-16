//
//  WDMeTransactionModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDMeTransactionModel : NSObject<ModelProtocol>

@property (nonatomic,copy) NSString *symbol;

@property (nonatomic,copy) NSString *from;

@property (nonatomic,copy) NSString *to;

@property (nonatomic,copy) NSString *amount;

@end
