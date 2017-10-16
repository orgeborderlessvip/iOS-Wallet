//
//  WDLoginAppLoginView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginAppLoginView.h"
#import "WDCustomButton.h"

@interface WDLoginAppLoginView ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end

@implementation WDLoginAppLoginView

- (void)languageSet {
    _hintLabel.text = WDLocalizedString(@"校验");
    _passwordTextField.placeholder = WDLocalizedString(@"请输入密码");
    [_confirmButton setTitle:WDLocalizedString(@"请输入密码") forState:(UIControlStateNormal)];
    [_removeButton setTitle:WDLocalizedString(@"删除") forState:(UIControlStateNormal)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    _removeButton.lineColor = _removeButton.titleLabel.textColor;
    _removeButton.lineWidth = 1;
    _removeButton.cornerdius = 5;
    for (int i = 1001; i < 1003; i ++) {
        [UIViewController addCornerRadius:5 toView:[self viewWithTag:i]];
    }
    
    [UIViewController addCornerRadius:15 toView:self];
}

@end
