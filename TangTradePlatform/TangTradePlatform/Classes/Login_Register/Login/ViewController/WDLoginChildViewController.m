//
//  WDLoginChildViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginChildViewController.h"
#import "WDLoginCardView.h"
#import "BaseTabBarViewController.h"
#import "SetInViewController.h"
#import "WDPingViewController.h"
#import "WDLoginAppViewController.h"
@interface WDLoginChildViewController ()
@property (nonatomic,strong) WDLoginCardView *loginView;

@property (nonatomic,strong) WDLoginViewModel *loginViewModel;
@end

@implementation WDLoginChildViewController

- (void)loadView {
    [super loadView];
    
    _loginView = [WDLoginCardView creatXib];
    
    self.view = _loginView;
}

- (WDLoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [WDLoginViewModel new];
        
        RAC(_loginViewModel,userName) = RACObserve(_loginView.userNameLabel, text);
        
        @weakify(self);
        
        [RACObserve(_loginViewModel, userName) subscribeNext:^(NSString *x) {
            @strongify(self);
            self.loginView.loginButton.enabled = ![x isEqualToString:WDLocalizedString(@"选择账户")];
        }];
    }
    return _loginViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 20;
    
    self.view.layer.masksToBounds = YES;

    [self loginViewModel];
    
    @weakify(self);
    
    [[self.loginView.registerButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self clearKeyBoard];
        
        [self show];
        
        UIScrollView *scroll =(UIScrollView *) self.view.superview.superview;
        
        [scroll setContentOffset:CGPointMake(CGRectGetWidth(scroll.frame), 0) animated:YES];
    }];
    
    [[self.loginView.importButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [[UIViewController currentViewController].navigationController pushViewController:[SetInViewController new] animated:YES];
    }];
    
    [[self.loginView.oldUserButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self clearKeyBoard];
        
        UIScrollView *scroll =(UIScrollView *) self.view.superview.superview;
        
        [scroll setContentOffset:CGPointMake(-CGRectGetWidth(scroll.frame), 0) animated:YES];
    }];
    
    [[self.loginView.chooseServerButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [[UIViewController currentViewController].navigationController pushViewController:[WDPingViewController new] animated:YES];
    }];
    
    [[self.loginView.chooseButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *array = [NSMutableArray array];
        NSArray *realArray = [WDWalletManager showSelectedWalletDetail];
        
        if (realArray.count == 0) {
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"该钱包中无账户" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
            
            return;
        }
        
        for (WDPasswordUserPrivateFileModel *passwordModel in realArray) {
            [array addObject:passwordModel.name];
        }
        [[UIViewController currentViewController] showPickerIndexViewWithUseLanguage:NO arr:array andSelectStr:@"" selectBolck:^(NSString *selectedString, NSInteger index) {
            self.loginView.userNameLabel.text = selectedString;
            
            [WDWalletManager setSelectedUserModel:realArray[index]];
        }];
        
    }];
    
    [[self.loginView.changeWalletButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WDLoginAppViewController new]];
    }];
    
    [[self.loginView.loginButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [UIViewController jumpToMainWithName:self.loginView.userNameLabel.text password:@""];
    }];
}

- (void)show {
//    self.loginView.walletNameLabel.text = baseFileName;
//    
//    self.loginView.userNameLabel.text = WDLocalizedString(@"选择账户");
//    
//    [WDBaseFileControl loadLocalWithName:baseFileName];
//    
//    [WDWalletManager setSelectedUserModel:nil];
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
