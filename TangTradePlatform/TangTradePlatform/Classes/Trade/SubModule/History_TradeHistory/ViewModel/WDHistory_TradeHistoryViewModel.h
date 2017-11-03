//
//  WDHistory_TradeHistoryViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDHistory_TradeHistoryViewModel : NSObject

@property (nonatomic,copy) NSString *baseCoin;
@property (nonatomic,copy) NSString *quetoCoin;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,assign) NSInteger kind;

- (void)getData;

- (instancetype)initWithKind:(NSInteger)kind BaseCoin:(NSString *)baseCoin queToCoin:(NSString *)quetoCoin;

@end
