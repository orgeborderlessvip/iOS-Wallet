//
//  WDOldUserViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/29.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDOldUserViewModel : NSObject

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *password;

@property (nonatomic,assign) BOOL isPassword;

- (void)clear;

- (void)confirmPasswordWithSuccess:(void(^)())success;

@end
