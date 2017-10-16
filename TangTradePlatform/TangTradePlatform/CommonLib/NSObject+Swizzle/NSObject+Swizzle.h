//
//  NSObject+Swizzle.h
//  FlbCartercoin
//
//  Created by ctcios2 on 2017/7/24.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector;

- (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end
