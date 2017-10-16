//
//  WDShowChongZhiBankCardView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDShowChongZhiBankCardView.h"

@interface WDShowChongZhiBankCardView ()<UserLanguageChange>

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIView *nameBackView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *bankBackView;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *bankCardBackView;
@property (weak, nonatomic) IBOutlet UILabel *bankCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankCardTitleLabel;

@property (nonatomic,copy) void (^clickClose)();
@property (nonatomic,copy) void (^clickConfirm)();
@end

@implementation WDShowChongZhiBankCardView

+ (void)showWithName:(NSString *)name bankName:(NSString *)bankName cardAccount:(NSString *)cardAccount clickClose:(void (^)())clickClose clickConfirm:(void (^)())clickConfirm {
    WDShowChongZhiBankCardView *view = [self creatXib];
    view.clickClose = clickClose;
    view.nameLabel.text = name;
    view.bankLabel.text = bankName;
    view.bankCardLabel.text = cardAccount;
    view.clickConfirm = clickConfirm;
    view.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].delegate.window addSubview:view];
}

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"银行卡");
    _nameTitleLabel.text = WDLocalizedString(@"姓名");
    _bankTitleLabel.text = WDLocalizedString(@"开户银行");
    _bankCardTitleLabel.text = WDLocalizedString(@"银行卡号");
    [_confirmButton setTitle:WDLocalizedString(@"确定") forState:(UIControlStateNormal)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    [UIViewController addCornerRadius:6 toView:self.nameBackView];
    [UIViewController addCornerRadius:6 toView:self.bankCardLabel];
    [UIViewController addCornerRadius:6 toView:self.bankBackView];
    [UIViewController addCornerRadius:15 toView:self.backView];
    [UIViewController addCornerRadius:9 toView:self.confirmButton];
    
    @weakify(self);
    [[self.closeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self removeFromSuperview];
        if (self.clickClose) {
            self.clickClose();
        }
    }];
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self removeFromSuperview];
        if (self.clickConfirm) {
            self.clickConfirm();
        }
    }];
}

@end
