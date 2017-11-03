//
//  WDLogin_RegisterViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLogin_RegisterViewController.h"

#import "WDLoginChildViewController.h"
#import "WDRegisterChildViewController.h"

#import "WDLogin_RegisterViewModel.h"

#import "WDBaseFileControl.h"
#import "WDOldUserViewController.h"

#import "NSString+changeTest.h"
@interface WDLogin_RegisterViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *logoBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UIView *pocketBackView;
@property (weak, nonatomic) IBOutlet UIView *pocketCornerView;

@property (nonatomic,strong) WDLoginChildViewController *loginVC;
@property (nonatomic,strong) WDRegisterChildViewController *registerChildVC;
@property (nonatomic,strong) WDOldUserViewController *oldUserVC;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *passwordSeeButton;
@property (weak, nonatomic) IBOutlet UIImageView *passwordSeeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *confirmPasswordSeeImageVIew;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmPasswordSeeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic,strong) WDLogin_RegisterViewModel *viewModel;

@end

@implementation WDLogin_RegisterViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"设置钱包密码");
    _passwordTextField.placeholder = WDLocalizedString(@"密码");
    _confirmPasswordTextField.placeholder = WDLocalizedString(@"确认密码");
    [_confirmButton setTitle:WDLocalizedString(@"确认") forState:(UIControlStateNormal)];
    _detailLabel.text = WDLocalizedString(@"密码设置后不可更改!忘记密码将无法找回,请牢记你的密码,并将其记在其他安全的地方。");
}

- (WDLogin_RegisterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WDLogin_RegisterViewModel new];
    }
    return _viewModel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addShadowToView:self.pocketBackView];
    [[self class] addCornerRadius:20 toView:self.pocketCornerView];
    @weakify(self);
    [[self.passwordTextField rac_textSignal] subscribeNext:^(NSString *text) {
        @strongify(self);
        
        self.viewModel.password = [text passwordTextLimit];
        self.passwordTextField.text = self.viewModel.password;
    }];
    [[self.confirmPasswordTextField rac_textSignal] subscribeNext:^(NSString *text) {
        @strongify(self);
        self.viewModel.confirmPassword = [text passwordTextLimit];
        self.confirmPasswordTextField.text = self.viewModel.confirmPassword;
    }];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        BOOL passwordEnable = self.viewModel.password.length > 5;
        BOOL confirmEnable = [self.viewModel.confirmPassword isEqualToString:self.viewModel.password];
        
        if (passwordEnable && confirmEnable) {
            [self.viewModel creatPasswordWithComplete:^{
                self.scrollView.hidden = NO;
                self.pocketBackView.hidden = YES;
                [self.loginVC show];
            }];
        }else {
            NSString *msg = nil;
            
            if (!passwordEnable) {
                msg = @"密码不能少于6位";
            }
            
            if (!confirmEnable) {
                msg = @"密码和确认密码不一致";
            }
            
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:msg withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }
    }];
    
    [[self.passwordSeeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        [self setWithTextField:self.passwordTextField toImageView:self.passwordSeeImageView];
    }];
    
    [[self.confirmPasswordSeeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        [self setWithTextField:self.confirmPasswordTextField toImageView:self.confirmPasswordSeeImageVIew];
    }];
    
    if ([UIScreen mainScreen].bounds.size.width <360) {
        _topHeight.constant -= 32;
    }
    
    _logoImageView.layer.cornerRadius = 20;
    _logoImageView.layer.masksToBounds = YES;
    _logoBackGroundView.layer.masksToBounds = NO;
    _logoBackGroundView.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.4].CGColor;
    _logoBackGroundView.layer.shadowOffset = CGSizeMake(2.f, 2.0f);
    _logoBackGroundView.layer.shadowOpacity = 0.5f;
    
    UIView *superViewOldUser = [[UIView alloc] init];
    
    _oldUserVC = [[WDOldUserViewController alloc] init];
    
    [self.scrollView addSubview:superViewOldUser];
    
    [self addShadowToView:superViewOldUser];
    
    CGFloat margin = 7.5;
    
    [superViewOldUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView).offset(margin);
        make.right.mas_equalTo(_scrollView.mas_left).offset(-margin);
        make.width.mas_equalTo(_scrollView).offset(-2 * margin);
        make.height.mas_equalTo(304);
    }];
    [superViewOldUser addSubview:_oldUserVC.view];
    [_oldUserVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(superViewOldUser);
    }];
    
    UIView *superViewLogin = [[UIView alloc] init];
    
    _loginVC = [WDLoginChildViewController new];
    
    [self.scrollView addSubview:superViewLogin];
    
    [self addShadowToView:superViewLogin];
    
    
    
    [superViewLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(_scrollView).offset(margin);
        make.width.mas_equalTo(_scrollView).offset(-2 * margin);
        make.height.mas_equalTo(253);
    }];
    
    [superViewLogin addSubview:_loginVC.view];
    
    [_loginVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(superViewLogin);
    }];
    
    UIView *superViewRegister = [[UIView alloc] init];
    
    _registerChildVC = [WDRegisterChildViewController new];
    
    [self.scrollView addSubview:superViewRegister];
    
    [self addShadowToView:superViewRegister];
    
    [superViewRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_loginVC.view.mas_right).offset(2 * margin);
        make.top.mas_equalTo(_scrollView).offset(margin);
        
        if ([UIScreen mainScreen].bounds.size.width <360) {
            make.height.mas_equalTo(297 + 36 + 16);
        }else {
            make.height.mas_equalTo(330);
        }
    
        make.width.mas_equalTo(_scrollView).offset(-2 * margin);
    }];
    
    [superViewRegister addSubview:_registerChildVC.view];
    
    [_registerChildVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(superViewRegister);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearKeyBoard)];
    
    [self.view addGestureRecognizer:tap];
    
    if ([WDBaseFileControl haveLocal]) {
        self.pocketBackView.hidden = YES;
        [self.loginVC show];
    }else {
        self.scrollView.hidden = YES;
    }
}

- (void)registerFunction {
    
}

- (void)addShadowToView:(UIView *)view {
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.4].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 0.5f;
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
