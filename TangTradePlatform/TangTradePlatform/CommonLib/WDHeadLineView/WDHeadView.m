//
//  WDHeadView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHeadView.h"
#import "WDMyLineView.h"

#define maxNumberInScreen _numberOfItemInScreen

@interface WDHeadView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) WDMyLineView *lineView;

@property (nonatomic,strong) NSMutableArray *viewArray;

@property (nonatomic,assign) CGFloat centerPercent;

@property (nonatomic,assign) BOOL firstSetup;

@end

@implementation WDHeadView



- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    for (UIButton *button in self.viewArray) {
        button.titleLabel.font = titleFont;
    }
}

- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfItemInScreen = 5;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        
        _lineHeight = 1;
    
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _lineView = [[WDMyLineView alloc] init];
        
        _lineView.backgroundColor = [UIColor whiteColor];
        
        [_scrollView addSubview:_lineView];
        
        _firstSetup = YES;
        
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    _lineHeight = 1;
    
    if (!_scrollView) {
        _numberOfItemInScreen = 5;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        _lineView = [[WDMyLineView alloc] init];
        
        _lineView.backgroundColor = [UIColor whiteColor];
        
        [_scrollView addSubview:_lineView];
        
        _firstSetup = YES;
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    for (int i = 0; i < self.viewArray.count; i ++) {
        UIButton *button = self.viewArray[i];
        
        if (i == selectedIndex) {
            [button setTitleColor:self.lineColor forState:(UIControlStateNormal)];
        }else {
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
    }
    
    NSInteger maxNumber = _dataArray.count > maxNumberInScreen ? maxNumberInScreen : _dataArray.count;
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / maxNumber;
    
    if (_firstSetup) {
        self.lineView.centerPercent = width * selectedIndex;
        _firstSetup = NO;
    }
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    
    _lineView.fillColor = lineColor;
}

- (void)setCenterPercent:(CGFloat)centerPercent withUsrSelected:(BOOL)usrSelected{
    _centerPercent = centerPercent;
    
    NSInteger maxNumber = _dataArray.count > maxNumberInScreen ? maxNumberInScreen : _dataArray.count;
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / maxNumber;
    
    CGFloat totalWidth = _centerPercent * width * _dataArray.count;
    
    self.lineView.centerPercent = centerPercent;
    
    if (usrSelected) return;
    
    if (totalWidth + width - self.scrollView.contentOffset.x >= CGRectGetWidth([UIScreen mainScreen].bounds)) {
        CGFloat x = _centerPercent * width * _dataArray.count - CGRectGetWidth([UIScreen mainScreen].bounds) +width;
        
        CGPoint point = self.scrollView.contentOffset;
        
        point.x = x;
        
        self.scrollView.contentOffset = point;
    }else if (totalWidth - self.scrollView.contentOffset.x <= 0) {
        CGFloat x = totalWidth;
        
        CGPoint point = self.scrollView.contentOffset;
        
        point.x = x;
        
        self.scrollView.contentOffset = point;
    }
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray {
    _dataArray = dataArray;
    
    if (dataArray.count == 0) return;
    
    for (UIView *item in self.viewArray) {
        [item removeFromSuperview];
    }
    [self.viewArray removeAllObjects];
    
    self.lineView.number = dataArray.count;
    
    NSInteger maxNumber = dataArray.count > maxNumberInScreen ? maxNumberInScreen : dataArray.count;
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / maxNumber;
    
    for (int i = 0; i < dataArray.count; i ++) {
        UIView *lastView = self.viewArray.count > 0?self.viewArray.lastObject:self.scrollView;
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
        [_scrollView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(lastView);
            }else {
                make.left.mas_equalTo(lastView.mas_right);
            }
            
            make.top.mas_equalTo(lastView);
            make.height.mas_equalTo(_scrollView).offset(-1);
            make.width.mas_equalTo(width);
            
            if (i == dataArray.count - 1) {
                make.right.mas_equalTo(_scrollView);
            }
            
        }];
        
        [button setTitle:dataArray[i] forState:(UIControlStateNormal)];
        
        @weakify(self);
        
        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            @strongify(self);
            
            if (self.touchBlock) {
                self.touchBlock(i);
            }
        
            for (UIButton *item in self.viewArray) {
                [item setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            }
            
            [button setTitleColor:self.lineColor forState:(UIControlStateNormal)];
        }];
        
        [self.viewArray addObject:button];
    }
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(((UIView *)self.viewArray.lastObject).mas_bottom);
        make.left.mas_equalTo(_scrollView);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(width * dataArray.count);
    }];
    
    self.selectedIndex = 0;
}

@end
