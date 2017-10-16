//
//  WDReceptionViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDReceptionViewController.h"
#import "WDNetworkManager.h"
#import "UIImage+QRCode.h"
@interface WDReceptionViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *qrBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImageView;
@property (weak, nonatomic) IBOutlet UIButton *copButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation WDReceptionViewController

- (void)languageSet {
    NSString *copt= WDLocalizedString(@"点击复制");
    [_copButton setTitle:copt forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qrBackgroundView.layer.cornerRadius = 5;
    self.qrBackgroundView.layer.masksToBounds = YES;
    self.copButton.layer.cornerRadius = 5;
    self.copButton.layer.masksToBounds = YES;
    
    self.view.bounds = [UIScreen mainScreen].bounds;
    
    self.nameLabel.text = [WDNetworkManager sharedInstance].userName;
    
    self.qrcodeImageView.image = [UIImage qrcodeFromString:[WDNetworkManager sharedInstance].userName withSize:CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5 - 16];
    @weakify(self);
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.copButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:[WDNetworkManager sharedInstance].userName];
        
        [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"已经复制到剪切板" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }];
}



@end
