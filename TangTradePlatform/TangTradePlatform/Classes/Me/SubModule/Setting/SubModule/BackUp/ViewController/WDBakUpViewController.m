//
//  WDBakUpViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/13.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBakUpViewController.h"

#import "NSString+changeTest.h"

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
    _detailLabel.text = WDLocalizedString(@"点击提交按钮将生成一个后缀名为.bin的备份文件。这个备份文件使用你的钱包密码进行加密。其中包含该钱包中的所有私钥。通过它可以恢复钱包，或者在不同浏览器或者计算机间进行钱包迁移。");
    [_confirmButton setTitle:WDLocalizedString(@"提交") forState:(UIControlStateNormal)];
    _passwordLabel.text = [NSString stringWithFormat:@"%@:",WDLocalizedString(@"密码")];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addChangeToView:self.topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width ];
    
    [[self class] addCornerRadius:15 toView:[self.view viewWithTag:1001]];
    
    for (int i = 1002; i < 1004; i ++) {
        [[self class] addCornerRadius:5 toView:[self.view viewWithTag:i]];
    }
    
    @weakify(self);
    
    [[self.passwordTextField rac_textSignal] subscribeNext:^(NSString *text) {
        text = [text changeTest];
        
        self.passwordTextField.text = text;
    }];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
        
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        
        dateString = [dateString stringByReplacingOccurrencesOfString:@" " withString:@"T"];
        
        NSString *string = [NSString stringWithFormat:@"wallet_%@.bin",dateString];
        
        [WDBaseFileControl creatBakUpWithFileName:string password:self.passwordTextField.text withSuccess:^{
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"备份成功" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }];
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
