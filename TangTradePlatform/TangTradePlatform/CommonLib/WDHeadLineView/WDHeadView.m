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

@property (nonatomic,strong) NSMutableArray *labelArray;

@property (nonatomic,assign) CGFloat centerPercent;

@property (nonatomic,assign) BOOL firstSetup;

@end

@implementation WDHeadView

- (void)setShowSymbol:(BOOL)showSymbol {
    _showSymbol = showSymbol;
    
    if (showSymbol) {
        for (NSInteger i = 0; i < self.viewArray.count; i ++) {
            UILabel *button = self.labelArray[i];
            
            NSString *string = self.dataArray[i];
            
            [UIViewController setWithCoin:string toLabel:button withFont:self.titleFont toFont:[UIFont systemFontOfSize:10]];
        }
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    for (NSInteger i = 0; i < self.labelArray.count; i ++) {
        UILabel *label = self.labelArray[i];
        
        NSString *string = self.dataArray[i];
        
        if (self.showSymbol) {
            [UIViewController setWithCoin:string toLabel:label withFont:self.titleFont toFont:[UIFont systemFontOfSize:10]];
        }else{
            label.font = _titleFont;
        }
    }
}

- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (NSMutableArray *)labelArray {
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
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
    
    for (int i = 0; i < self.labelArray.count; i ++) {
        UILabel *label = self.labelArray[i];
        
        if (i == selectedIndex) {
            label.textColor = self.lineColor;
        }else {
            label.textColor = [UIColor blackColor];
//            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
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
    for (UIView *item in self.labelArray) {
        [item removeFromSuperview];
    }
    [self.labelArray removeAllObjects];
    self.lineView.number = dataArray.count;
    
    NSInteger maxNumber = dataArray.count > maxNumberInScreen ? maxNumberInScreen : dataArray.count;
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) / maxNumber;
    
    for (int i = 0; i < dataArray.count; i ++) {
        UIView *lastView = self.labelArray.count > 0?self.labelArray.lastObject:self.scrollView;
        
        UILabel *label = [[UILabel alloc] init];
        
        label.numberOfLines = 0;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [_scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
        [_scrollView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.mas_equalTo(label);
            
        }];
        
        if (_showSymbol) {
            [UIViewController setWithCoin:dataArray[i] toLabel:label withFont:self.titleFont toFont:[UIFont systemFontOfSize:10]];
        }else {
            label.text = dataArray[i];
        }
        
        
        
        @weakify(self);
        
        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            @strongify(self);
            
            if (self.touchBlock) {
                self.touchBlock(i);
            }
        
            for (UILabel *item in self.labelArray) {
                item.textColor = [UIColor blackColor];
            }
            label.textColor = self.lineColor;

        }];
        
        [self.viewArray addObject:button];
        [self.labelArray addObject:label];
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
