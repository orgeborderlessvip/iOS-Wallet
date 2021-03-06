//
//  WDSendOutViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WDHomeTableDataModel;
@interface WDSendOutViewModel : NSObject

@property (nonatomic,copy) NSString *account;

@property (nonatomic,assign) CGFloat amount;

@property (nonatomic,assign) CGFloat haveAmount;

@property (nonatomic,copy) NSString *coinKind;

@property (nonatomic,copy) NSString *serviceCharge;

@property (nonatomic,strong) RACSubject *sendSubject;

+ (void)loadCoinDataWithShowBDS:(BOOL)show Success:(void(^)(NSArray <WDHomeTableDataModel *>*dataArray))success;

+ (void)loadCoinDataWithSuccess:(void(^)(NSArray <WDHomeTableDataModel *>*dataArray))success;

+ (void)loadMyDataWithSuccess:(void(^)(NSArray *dataArray))success error:(void(^)())error;

- (void)loadMyAccountData;

- (void)sendPay;

@end
