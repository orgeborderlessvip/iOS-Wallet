//
//  WDAttentionView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDAttentionView.h"
#import "WDRegisterViewModel.h"
@interface WDAttentionView ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WDAttentionView

- (void)languageSet {
    NSString *title = WDLocalizedString(@"提示");
    NSString *detail = WDLocalizedString(@"密码设置后不可更改!请牢记您的密码,并将其记在其他安全的地方\n你的密码:");
    _titleLabel.text = title;
    _detailLabel.text = detail;
}

- (void)bindModel:(WDRegisterViewModel *)viewModel {
    RAC(self.passwordLabel,text) = RACObserve(viewModel, password);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    
    NSString *textStr = _detailLabel.text;
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    _detailLabel.attributedText = attributedString;
    
    
}

@end
