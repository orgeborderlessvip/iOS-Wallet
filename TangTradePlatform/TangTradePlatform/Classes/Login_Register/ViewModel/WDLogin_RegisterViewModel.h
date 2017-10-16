//
//  WDLogin_RegisterViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDLogin_RegisterViewModel : NSObject

@property (nonatomic,copy) NSString *password;

@property (nonatomic,copy) NSString *confirmPassword;

- (void)creatPasswordWithComplete:(void(^)())complete;

@end
