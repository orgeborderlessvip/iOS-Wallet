//
//  WDOrderViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDOrderViewModel : NSObject

@property (nonatomic,copy) NSString *baseCoin;
@property (nonatomic,copy) NSString *quetoCoin;


@property (nonatomic,strong) NSArray *dataBuyArray;
@property (nonatomic,strong) NSArray *dataSellArray;

- (instancetype)initWithBaseCoin:(NSString *)baseCoinName quetoCoin:(NSString *)quetoCoinName;

- (void)getData;

- (void)cancleOrderWithSell:(BOOL)sell withIndex:(NSInteger)index;

@end
