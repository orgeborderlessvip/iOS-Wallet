//
//  WDLoginViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/20.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WDLoginViewModel : NSObject

@property (nonatomic,copy) NSString *userName;



- (void)loginWithSuccess:(void(^)())success failture:(void(^)())failture error:(void(^)())error;

@end
