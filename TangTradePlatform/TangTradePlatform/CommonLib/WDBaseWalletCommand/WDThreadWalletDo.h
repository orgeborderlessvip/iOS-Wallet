//
//  WDThreadWalletDo.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/18.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDThreadWalletDo : NSObject

@property (nonatomic,copy) NSString *command;

@property (nonatomic,assign) BOOL walletApi;

@property (nonatomic,assign) BOOL showHud;

@property (nonatomic,copy) void(^succssDo)(id response);

@property (nonatomic,copy) void(^errorDo)(NSString *errMSsg);

@end
