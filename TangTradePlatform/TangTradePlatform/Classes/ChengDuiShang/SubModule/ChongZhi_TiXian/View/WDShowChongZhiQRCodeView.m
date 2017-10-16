//
//  WDShowChongZhiQRCodeView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDShowChongZhiQRCodeView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+QRCode.h"
#import "WDNetworkManager.h"
@interface WDShowChongZhiQRCodeView ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *backCornerView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UIView *cornerLabelView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UIButton *clicpButton;


@property (nonatomic,copy) void (^clickClose)();

@property (nonatomic,strong) id model;

@end

@implementation WDShowChongZhiQRCodeView

- (void)languageSet {
    [_clicpButton setTitle:WDLocalizedString(@"点击复制") forState:(UIControlStateNormal)];
}

+ (void)showWithTitleName:(NSString *)titleName QRCodeKind:(QRCodeKind)kind imageUrl:(NSString *)imgUrl nameLabelText:(NSString *)text clickClose:(void (^)())clickClose {
    WDShowChongZhiQRCodeView *view = [self creatXib];
    view.clickClose = clickClose;
    switch (kind) {
        case QRCodeKindWallet:
            view.qrCodeImageView.image = [UIImage qrcodeFromString:text withSize:view.qrCodeImageView.frame.size.width];
            view.titleLabel.text = titleName;
            break;
        case QRCodeKindAlipay:
            [view.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            view.titleLabel.text = WDLocalizedString(@"支付宝");
            break;
        case QRCodeKindWechat:
            [view.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            view.titleLabel.text = WDLocalizedString(@"微信");
            view.clicpButton.hidden = YES;
            break;
    }
    view.accountLabel.text = text;
    view.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].delegate.window addSubview:view];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    [UIViewController addCornerRadius:15 toView:_backCornerView];
    [UIViewController addCornerRadius:9 toView:self.clicpButton];
    [UIViewController addCornerRadius:6 toView:self.cornerLabelView];
    
    @weakify(self);
    [[self.closeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self removeFromSuperview];
        if (self.clickClose) {
            self.clickClose();
        }
    }];
    [[self.clicpButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {

        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.accountLabel.text];
        
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"已经复制到剪切板" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }];
}

@end
