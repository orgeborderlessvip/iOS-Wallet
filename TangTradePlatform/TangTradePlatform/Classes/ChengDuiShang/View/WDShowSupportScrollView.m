//
//  WDShowSupportScrollView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDShowSupportScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define imageMargin 12

@interface WDShowSupportScrollView ()

@property (nonatomic,strong) NSMutableArray *viewArray;

@end

@implementation WDShowSupportScrollView

- (NSMutableArray *)viewArray {
    if (!_viewArray ) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    
    for (UIView *view in self.viewArray) {
        [view removeFromSuperview];
    }
    
    [self.viewArray removeAllObjects];
    
    for (int i = 0; i < imageArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self addSubview:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]]];
        
        [self.viewArray addObject:imageView];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    
    CGFloat height = self.frame.size.height;
    
    CGFloat totalWidth = self.viewArray.count * (height + imageMargin) > width ? self.viewArray.count * (height + imageMargin):width;
    
    for (int i = 0; i < self.viewArray.count; i ++) {
        UIView *view = self.viewArray[i];
        
        view.frame = CGRectMake(totalWidth - imageMargin - height - i * (height + imageMargin) , 0, height , height);
    }
    
    self.contentSize = CGSizeMake(totalWidth, height);
}

@end
