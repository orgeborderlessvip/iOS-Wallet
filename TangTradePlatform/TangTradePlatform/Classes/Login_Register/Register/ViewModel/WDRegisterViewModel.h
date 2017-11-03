//
//  WDRegisterViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDRegisterViewModel : NSObject

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *tuijianRen;

- (void)registerWithSuccess:(void (^)())success failture:(void (^)(NSString *msg))failture error:(void (^)())error;

- (void)clear;

@end
