//
//  WDChongZhinContainerView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChongZhinContainerView.h"
#import "WDTiXianChildViewModel.h"
@interface WDChongZhinContainerView ()<UserLanguageChange>

@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UIView *styleBackView;
@property (weak, nonatomic) IBOutlet UILabel *styleChoiceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelHeight;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UILabel *bankNameTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *bankNameBackGroundView;

@property (weak, nonatomic) IBOutlet UILabel *cardAccountTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *cardBackView;

@end

@implementation WDChongZhinContainerView

- (void)clearText {
    _nameTextField.text = @"";
    _bankTextField.text = @"";
    _cardTextField.text = @"";
}

- (void)languageSet {
    _styleLabel.text = WDLocalizedString(@"提现方式");
    _bankNameTitleLabel.text = WDLocalizedString(@"开户银行");
    _cardAccountTitleLabel.text = WDLocalizedString(@"银行卡号");
}

- (void)setSelectedKind:(SelectedPayKind)selectedKind {
    NSString *text = [NSString stringWithUTF8String:payStyleNameArray[selectedKind]];
    
    _styleChoiceLabel.text = WDLocalizedString(text);
    
    switch (selectedKind) {
        case SelectedPayKindBTCWallet:
            _styleLabel.hidden = YES;
            _styleBackView.hidden = YES;
            _topLabelHeight.constant = 0;
            _bankNameTitleLabel.hidden = YES;
            _bankNameBackGroundView.hidden = YES;
            _cardBackView.hidden = YES;
            _cardAccountTitleLabel.hidden = YES;
            _topLabel.text = WDLocalizedString(@"钱包地址");
            break;
        case SelectedPayKindUSDCard:
            _styleLabel.hidden = YES;
            _styleBackView.hidden = YES;
            _topLabelHeight.constant = 0;
            _bankNameTitleLabel.hidden = NO;
            _bankNameBackGroundView.hidden = NO;
            _cardBackView.hidden = NO;
            _cardAccountTitleLabel.hidden = NO;
            _topLabel.text = WDLocalizedString(@"姓名");
            break;
        case SelectedPayKindCNYCard:
            _styleLabel.hidden = NO;
            _styleBackView.hidden = NO;
            _topLabelHeight.constant = 76;
            _bankNameTitleLabel.hidden = NO;
            _bankNameBackGroundView.hidden = NO;
            _cardBackView.hidden = NO;
            _cardAccountTitleLabel.hidden = NO;
            _topLabel.text = WDLocalizedString(@"姓名");
            break;
        case SelectedPayKindCNYAlipay:
            _styleLabel.hidden = NO;
            _styleBackView.hidden = NO;
            _topLabelHeight.constant = 76;
            _bankNameTitleLabel.hidden = YES;
            _bankNameBackGroundView.hidden = YES;
            _cardBackView.hidden = YES;
            _cardAccountTitleLabel.hidden = YES;
            _topLabel.text = WDLocalizedString(@"支付宝");
            break;
        case SelectedPayKindCNYWeChat:
            
            break;
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    
    [UIViewController addCornerRadius:5 toView:self.styleBackView];
    [UIViewController addCornerRadius:5 toView:self.topBackView];
    [UIViewController addCornerRadius:5 toView:self.bankNameBackGroundView];
    [UIViewController addCornerRadius:5 toView:self.cardBackView];
}

@end