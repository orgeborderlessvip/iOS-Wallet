//
//  NSDate+UTCDate.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "NSDate+UTCDate.h"

@implementation NSDate (UTCDate)

+ (NSString *)UTCStringTransToLocal:(NSString *)utcString {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    
    matter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];;
    
    matter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
    NSDate *date = [matter dateFromString:utcString];
    
    return [date localString];
}

- (NSString *)UTCString {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    
    matter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];;
    
    matter.dateFormat = @"yyyyMMdd'T'HHmmss";
    
    NSString *date = [matter stringFromDate:self];
    
    return date;
}

- (NSString *)localString {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    
    matter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    NSString *date = [matter stringFromDate:self];
    
    return date;
}

@end
