//
//  WDCircleView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/19.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDCircleView.h"

@implementation WDCircleView


- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.circleColor == nil) return;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [self.circleColor setFill];
    
    [path fill];
}


@end
