//
//  WDPrivateKeyViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/24.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDPrivateKeyViewController.h"
#import "UILabel+Copy.h"
@interface WDPrivateKeyViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *pubKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *priKeyLabel;
@property (weak, nonatomic) IBOutlet UITextField *verifyKeyPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *detaiLabel;


@end

@implementation WDPrivateKeyViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"我的秘钥");
    _verifyKeyPasswordTextField.placeholder = WDLocalizedString(@"输入钱包密码");
    [_confirmButton setTitle:WDLocalizedString(@"提交") forState:(UIControlStateNormal)];
    _pubKeyLabel.text = WDLocalizedString(@"公钥:");
    _priKeyLabel.text = WDLocalizedString(@"私钥:");
    _detaiLabel.text = WDLocalizedString(@"请务必保存好你的私钥,否则数据丢失无法查询");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToHeadView:self.topbarView];
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSMutableString *priKey = [NSMutableString stringWithFormat:@"%@:\n",WDLocalizedString(@"私钥")];
    NSMutableString *pubKey = [NSMutableString stringWithFormat:@"%@:\n",WDLocalizedString(@"公钥")];
    
    for (int i = 1001; i < 1006; i ++) {
        [[self class] addCornerRadius:5 toView:[self.view viewWithTag:i]];
    }
    
    for (int i = 0; i < [WDWalletManager selectedModel].pub_key.length; i ++) {
        [pubKey appendString:@"*"];
    }
    
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:pubKey];
//    
//    NSRange rang = [pubKey rangeOfString:WDLocalizedString(@"公钥:")];
//    
//    [AttributedStr addAttribute:NSFontAttributeName
//                          value:_pubKeyLabel.font
//                          range:rang];
//    
//    [AttributedStr addAttribute:NSFontAttributeName
//                          value:[UIFont systemFontOfSize:[_pubKeyLabel.font pointSize] - 2]
//                          range:NSMakeRange(rang.length, AttributedStr.length - rang.length)];
//    
//    _pubKeyLabel.attributedText = AttributedStr;
//    
    for (int i = 0; i < [WDWalletManager selectedModel].wif_priv_key.length; i ++) {
        [priKey appendString:@"*"];
    }
    _pubKeyLabel.text = pubKey;
    _priKeyLabel.text = priKey;
    
    _pubKeyLabel.canCopy = NO;
    _priKeyLabel.canCopy = NO;
    _pubKeyLabel.copyString = [WDWalletManager selectedModel].pub_key;
    _priKeyLabel.copyString = [WDWalletManager selectedModel].wif_priv_key;
//
//    NSRange rang1 = [priKey rangeOfString:WDLocalizedString(@"私钥:")];
//    
//    NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:priKey];
//    
//    [AttributedStr1 addAttribute:NSFontAttributeName
//                          value:_priKeyLabel.font
//                          range:rang1];
//    
//    [AttributedStr1 addAttribute:NSFontAttributeName
//                          value:[UIFont systemFontOfSize:[_priKeyLabel.font pointSize] - 2]
//                          range:NSMakeRange(rang1.length, AttributedStr.length - rang1.location)];
//    
//    _priKeyLabel.attributedText = AttributedStr1;
    
    @weakify(self);
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        if ([self.verifyKeyPasswordTextField.text isEqualToString:[WDWalletManager currentPassword]]) {
            self.pubKeyLabel.text = [NSString stringWithFormat:@"%@:\n%@",WDLocalizedString(@"公钥"),[WDWalletManager selectedModel].pub_key];
            self.priKeyLabel.text = [NSString stringWithFormat:@"%@:\n%@",WDLocalizedString(@"私钥"),[WDWalletManager selectedModel].wif_priv_key];
            
            self.priKeyLabel.canCopy = YES;
            self.pubKeyLabel.canCopy = YES;
        }else {
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"钱包密码不正确" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
