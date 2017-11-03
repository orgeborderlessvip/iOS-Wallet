//
//  WDOldUserViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/29.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOldUserViewController.h"

#import "WDOldUserViewModel.h"

@interface WDOldUserViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UIButton *passwordButton;
@property (weak, nonatomic) IBOutlet UIImageView *prikeyImageView;
@property (weak, nonatomic) IBOutlet UILabel *prikeyLabel;
@property (weak, nonatomic) IBOutlet UIButton *prikeyButton;

@property (nonatomic,strong) WDOldUserViewModel *viewModel;
@end

@implementation WDOldUserViewController

- (WDOldUserViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WDOldUserViewModel new];
        _viewModel.isPassword = YES;
        
        RAC(self.confirmButton,enabled) = [RACSignal combineLatest:@[RACObserve(_viewModel, password),RACObserve(_viewModel, userName)] reduce:^id(NSString *password,NSString *userName){
            return @(password.length > 0 && userName.length > 0);
        }];
        @weakify(self);
        [RACObserve(_viewModel, isPassword) subscribeNext:^(id x) {
            @strongify(self);
            NSString *passwordText = self.viewModel.isPassword?@"请输入密码":@"请输入秘钥";
            
            self.userPasswordTextField.placeholder = WDLocalizedString(passwordText);
            
            UIImage *selectedImage = [UIImage imageNamed:@"selected_true"];
            UIImage *deselectedImage = [UIImage imageNamed:@"selected_false"];
            
            if (self.viewModel.isPassword) {
                self.passwordImageView.image = selectedImage;
                self.prikeyImageView.image = deselectedImage;
            }else {
                self.passwordImageView.image = deselectedImage;
                self.prikeyImageView.image = selectedImage;
            }
        }];
        
    }
    return _viewModel;
}

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"导入");
    
    _userNameTextField.placeholder = WDLocalizedString(@"用户名");
    _userPasswordTextField.placeholder = WDLocalizedString(@"请输入密码");
    _passwordLabel.text = WDLocalizedString(@"密码导入");
    _prikeyLabel.text = WDLocalizedString(@"私钥导入");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self class] addCornerRadius:20 toView:self.view];
    [_confirmButton setImage:[UIImage imageNamed:@"Login_button_disable"] forState:(UIControlStateDisabled)];
    [_confirmButton setImage:[UIImage imageNamed:@"Login_button_enable"] forState:(UIControlStateNormal)];
    
    @weakify(self);
    [self.userNameTextField.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self);
        self.viewModel.userName = text;
    }];
    [self.userPasswordTextField.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self);
        self.viewModel.password = text;
    }];
    RAC(self.userNameTextField,text) = RACObserve(self.viewModel, userName);
    RAC(self.userPasswordTextField,text) = RACObserve(self.viewModel, password);
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        UIScrollView *scroll = (UIScrollView *)self.view.superview.superview;
        [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.viewModel clear];
    }];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        
        [self.viewModel confirmPasswordWithSuccess:^{
            UIScrollView *scroll = (UIScrollView *)self.view.superview.superview;
            [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
            [self.viewModel clear];
        }];
    }];
    
    [[self.passwordButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.isPassword = YES;
    }];
    [[self.prikeyButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.isPassword = NO;
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
