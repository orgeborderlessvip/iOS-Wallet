//
//  WDRegisterCardView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDRegisterCardView.h"
#import "NSString+changeTest.h"

@interface WDRegisterCardView ()<UserLanguageChange>


@property (nonatomic,strong) WDRegisterViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation WDRegisterCardView

- (void)languageSet {
    NSString *title = WDLocalizedString(@"注册");
    NSString *userName = WDLocalizedString(@"用户名");
    NSString *tuiJian = WDLocalizedString(@"推荐人(非必输)");
    _titleLabel.text = title;
    _userNameTextField.placeholder = userName;
    _tuiJianRenTextField.placeholder = tuiJian;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"Login_button_enable"] forState:(UIControlStateNormal)];
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"Login_button_disable"] forState:(UIControlStateDisabled)];
}

- (void)bindViewModel:(WDRegisterViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self modelChanged];
    @weakify(self);
    [self.userNameTextField.rac_textSignal subscribeNext:^(NSString *name) {
        @strongify(self);
        self.userNameTextField.text = [self.userNameTextField.text changeTest];
        if (self.userNameTextField.text.length > 20) {
            self.userNameTextField.text = [self.userNameTextField.text substringToIndex:20];
        }
        viewModel.userName = self.userNameTextField.text;
    }];
    
    [self.tuiJianRenTextField.rac_textSignal subscribeNext:^(NSString *name) {
        @strongify(self);
        
        self.tuiJianRenTextField.text = [name changeTest];
        
        if (self.tuiJianRenTextField.text.length > 20) {
            self.tuiJianRenTextField.text = [self.tuiJianRenTextField.text substringToIndex:20];
        }
        
        viewModel.tuijianRen = self.tuiJianRenTextField.text;
    }];
    
    RAC(self.registerButton,enabled) = [RACSignal combineLatest:@[RACObserve(self.viewModel,userName)] reduce:^id(NSString *userName){
        return @(userName.length > 5);
    }];
    
}

- (void)modelChanged {
    @weakify(self);
    [RACObserve(_viewModel, userName) subscribeNext:^(NSString *text) {
        @strongify(self);
        self.userNameTextField.text = text;
        
//        if (text.length >0 && text.length < 6) {
//            self.showLabel.text = WDLocalizedString(@"");
//        }
    }];
    [RACObserve(_viewModel, tuijianRen) subscribeNext:^(NSString *text) {
        @strongify(self);
        self.tuiJianRenTextField.text = text;
    }];
}



@end
