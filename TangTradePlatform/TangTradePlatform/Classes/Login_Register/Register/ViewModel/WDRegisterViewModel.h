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

@property (nonatomic,copy) NSString *password;

@property (nonatomic,copy) NSString *confirmPassword;

@property (nonatomic,strong) RACSubject *userNameSubject;

@property (nonatomic,strong) RACSubject *passwordSubject;

@property (nonatomic,strong) RACSubject *confirmPasswordSubject;

@property (nonatomic,strong) RACSubject *registerSubject;

@property (nonatomic,strong) RACSubject *backSubject;

@property (nonatomic,assign) BOOL hiddenLabel;

- (void)registerWithSuccess:(void(^)())success failture:(void(^)())failture error:(void(^)())error;

- (void)clear;

@end
