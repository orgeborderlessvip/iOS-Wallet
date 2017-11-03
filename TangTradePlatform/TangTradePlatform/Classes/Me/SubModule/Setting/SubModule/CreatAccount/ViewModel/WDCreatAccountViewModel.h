//
//  WDCreatAccountViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCreatAccountViewModel : NSObject

@property (nonatomic,strong) NSString *userName;

@property (nonatomic,strong) NSString *showString;

- (void)creatAccount;

@end
