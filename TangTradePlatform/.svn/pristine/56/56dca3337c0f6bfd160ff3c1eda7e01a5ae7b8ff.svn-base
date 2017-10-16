//
//  WDCustomButton.m
//  FlbCartercoin
//
//  Created by ctcios2 on 2017/7/14.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import "WDCustomButton.h"

@interface WDCustomButton ()

@property (nonatomic,strong) UIColor *backColor;

@end

@implementation WDCustomButton

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backColor = backgroundColor;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width -  _lineWidth;
    
    CGFloat height = rect.size.height - _lineWidth;
    
    if (self.backColor) {
        UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(_lineWidth / 2, _lineWidth / 2, width, height) byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(_cornerdius, _cornerdius)];
        
        [_backColor setFill];
        
        [bezierPath1 fill];
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(_lineWidth / 2, _lineWidth / 2, width, height) byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(_cornerdius, _cornerdius)];
    bezierPath.lineWidth = _lineWidth;
    
    [_lineColor setStroke];
    
    [bezierPath stroke];
}


@end
