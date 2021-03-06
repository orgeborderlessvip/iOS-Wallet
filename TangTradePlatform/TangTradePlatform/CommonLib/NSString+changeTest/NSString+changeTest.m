///Users/ctc/Desktop/TangTradePlatform/TangTradePlatform.xcodeproj
//  NSString+changeTest.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "NSString+changeTest.h"

@implementation NSString (changeTest)

- (NSString *)changeTest {
    NSString *subString = [self stringByReplacingOccurrencesOfString:@"[^0-9a-z]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    
    while (subString.length > 0) {
        char c = [subString characterAtIndex:0];
        if (c >= '0' && c <= '9') {
            subString = [subString substringFromIndex:1];
        }else {
            break;
        }
    }
    
    return subString;
}

- (NSString *)passwordTextLimit {
    NSString *subString = [self stringByReplacingOccurrencesOfString:@"[^0-9a-zA-Z]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    
    return subString;
}

- (BOOL)availableTest {
    BOOL haveNumber = NO;
    BOOL haveZimu = NO;
    
    for (int i = 0; i < self.length; i ++) {
        char c = [self characterAtIndex:i];
        
        if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
            haveZimu = YES;
            continue;
        }
        if (c >= '0' && c <= '9') {
            haveNumber = YES;
            continue;
        }
    }
    
    return haveZimu && haveNumber && self.length > 7;
}

- (NSString *)digitalNumberWithMaxLength:(NSUInteger)length {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"[^0-9.]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    
    if (array.count < 2) return string;
    
    NSString *first = array[0];
    NSString *second = array[1];
    
    if (length < 1) return first;
    
    if (second.length > length) {
        second = [second substringToIndex:length];
    }
    NSArray *realArray = @[first,second];
    
    return [realArray componentsJoinedByString:@"."];
}

+ (NSString *)generateRandom {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    for (int i = 0; i < 26; i ++) {
        char c = 'a';
        
        [array addObject:[NSString stringWithFormat:@"%c",c + i]];
    }
    
    for (int i = 0; i < 26; i ++) {
        char c = 'A';
        
        [array addObject:[NSString stringWithFormat:@"%c",c + i]];
    }
    
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < 6; i ++) {
        [string appendFormat:@"%@",array[arc4random()%array.count]];
    }
    return string;
}

@end
