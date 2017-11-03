//
//  WDRegisterCardView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginCardView.h"
#import "NSString+changeTest.h"
@interface WDLoginCardView ()<UserLanguageChange>



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *registerLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldUserLabel;

@end

@implementation WDLoginCardView

- (void)languageSet {
    NSString *string = WDLocalizedString(@"选择账户");
    _titleLabel.text = string;
    [_changeWalletButton setTitle:WDLocalizedString(@"切换钱包") forState:(UIControlStateNormal)];
    _oldUserLabel.text = WDLocalizedString(@"导入");
    _registerLabel.text = WDLocalizedString(@"注册");
    [_chooseServerButton setTitle:WDLocalizedString(@"选择节点") forState:(UIControlStateNormal)];
    _userNameLabel.text = WDLocalizedString(@"选择账户");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    [_loginButton setImage:[UIImage imageNamed:@"Login_button_disable"] forState:(UIControlStateDisabled)];
    [_loginButton setImage:[UIImage imageNamed:@"Login_button_disable"] forState:(UIControlStateNormal)];
    
}

@end
