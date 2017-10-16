//
//  WDBakUpViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/13.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBakUpViewController.h"

@interface WDBakUpViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation WDBakUpViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"备份");
    _detailLabel.text = WDLocalizedString(@"提交点击按钮将生成一个后缀名为 .bin 的备份文件。这个备份文件使用你的钱包密码进行加密。其中包含该钱包中的所有私钥。通过它可以恢复钱包，或者在不同浏览器或者计算机间进行钱包迁移");
    [_confirmButton setTitle:WDLocalizedString(@"提交") forState:(UIControlStateNormal)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addChangeToView:self.topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width ];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
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
