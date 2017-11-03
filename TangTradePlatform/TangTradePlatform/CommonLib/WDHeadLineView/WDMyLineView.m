//
//  WDMyLineView.m
//  FlbCartercoin
//
//  Created by ctcios2 on 2017/8/2.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import "WDMyLineView.h"

@implementation WDMyLineView
- (void)setCenterPercent:(CGFloat)centerPercent {
    _centerPercent = centerPercent;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = self.frame.size.width / _number;
    
    CGFloat x = self.frame.size.width * _centerPercent;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, 0, width, CGRectGetHeight(self.frame))];
    
    [_fillColor setFill];
    
    [path fill];
}

@end
