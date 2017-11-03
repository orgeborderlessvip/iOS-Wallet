//
//  WDLoginAppDeleteView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginAppDeleteView.h"

@interface WDLoginAppDeleteView ()<UserLanguageChange>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation WDLoginAppDeleteView

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"重要");
    _detailLabel.text = WDLocalizedString(@"清除后,本钱包以及钱包下的所有账户都会被清除,确定删除吗?");
    [_confirmButton setTitle:WDLocalizedString(@"确定") forState:(UIControlStateNormal)];
    [_cancleButton setTitle:WDLocalizedString(@"取消") forState:(UIControlStateNormal)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    [UIViewController addCornerRadius:15 toView:self];
    [UIViewController addCornerRadius:5 toView:_confirmButton];
    [UIViewController addCornerRadius:5 toView:_cancleButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
