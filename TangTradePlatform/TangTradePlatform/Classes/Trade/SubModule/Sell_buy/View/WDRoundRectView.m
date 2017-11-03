//
//  WDRoundRectView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDRoundRectView.h"

@implementation WDRoundRectView

- (void)drawRect:(CGRect)rect {
    CGRect frame = self.bounds;
    
    frame.origin.x = 0.5;
    frame.origin.y = 0.5;
    frame.size.width -= 1;
    frame.size.height -= 1;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5];
    
    path.lineWidth = 1;
    [RGBColor(226, 226, 226, 1) setStroke];
    [path stroke];
}

@end
