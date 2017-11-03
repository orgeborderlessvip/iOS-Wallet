//
//  NSDate+UTCDate.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UTCDate)

+ (NSString *)UTCStringTransToLocal:(NSString *)utcString;

- (NSString *)UTCString;

- (NSString *)localString;

@end
