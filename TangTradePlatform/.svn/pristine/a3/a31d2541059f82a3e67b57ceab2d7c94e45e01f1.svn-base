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

@interface WDLogin_RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *logoBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UIView *pocketBackView;
@property (weak, nonatomic) IBOutlet UIView *pocketCornerView;

@property (nonatomic,strong) WDLoginChildViewController *loginVC;
@property (nonatomic,strong) WDRegisterChildViewController *registerChildVC;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *passwordSeeButton;
@property (weak, nonatomic) IBOutlet UIImageView *passwordSeeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *confirmPasswordSeeImageVIew;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmPasswordSeeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic,strong) WDLogin_RegisterViewModel *viewModel;

@end

@implementation WDLogin_RegisterViewController

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
    [[self.passwordTextField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.password = x;
    }];
    [[self.confirmPasswordTextField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.confirmPassword = x;
    }];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        [self.viewModel creatPasswordWithComplete:^{
            self.scrollView.hidden = NO;
            self.pocketBackView.hidden = YES;
        }];
    }];
    
    if ([WDBaseFileControl haveLocal]) {
        self.pocketBackView.hidden = YES;
    }else {
        self.scrollView.hidden = YES;
    }
    
    if ([UIScreen mainScreen].bounds.size.width <360) {
        _topHeight.constant -= 32;
    }
    
    _logoImageView.layer.cornerRadius = 20;
    _logoImageView.layer.masksToBounds = YES;
    _logoBackGroundView.layer.masksToBounds = NO;
    _logoBackGroundView.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.4].CGColor;
    _logoBackGroundView.layer.shadowOffset = CGSizeMake(2.f, 2.0f);
    _logoBackGroundView.layer.shadowOpacity = 0.5f;
    
    
    UIView *superViewLogin = [[UIView alloc] init];
    
    _loginVC = [WDLoginChildViewController new];
    
    [self.scrollView addSubview:superViewLogin];
    
    [self addShadowToView:superViewLogin];
    
    CGFloat margin = 7.5;
    
    [superViewLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(_scrollView).offset(margin);
        make.width.mas_equalTo(_scrollView).offset(-2 * margin);
        make.height.mas_equalTo(264);
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
