//
//  NSString+changeTest.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (changeTest)

- (NSString *)changeTest;

- (BOOL)availableTest;

/**
 限制小数点后几位小数

 @param length 小数点后长度
 @return 限制后字符
 */
- (NSString *)digitalNumberWithMaxLength:(NSUInteger)length;

@end
