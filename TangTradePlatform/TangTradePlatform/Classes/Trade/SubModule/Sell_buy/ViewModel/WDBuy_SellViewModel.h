//
//  WDBuy_SellViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBuy_SellViewModel : NSObject

@property (nonatomic,copy) NSString *baseCoin;

@property (nonatomic,copy) NSString *quetoCoin;

@property (nonatomic,strong) NSArray *buyArray;
@property (nonatomic,strong) NSArray *sellArray;

@property (nonatomic,assign) CGFloat myAount;
@property (nonatomic,assign) CGFloat lowestBuy;

@property (nonatomic,assign) CGFloat price;
@property (nonatomic,assign) CGFloat amount;

@property (nonatomic,assign) CGFloat turnOver;

@property (nonatomic,assign) CGFloat serviceCharge;
@property (nonatomic,copy) NSString *serviceSymbol;

@property (nonatomic,assign) BOOL isBuy;

- (instancetype)initWithBaseCoin:(NSString *)baseCoin quetoCoin:(NSString *)quetoCoin isBuy:(BOOL)isBuy;

- (void)getAllData;

- (void)getMyData;

- (void)getBuyData;

- (void)sendPay;

- (void)sell;

@end
