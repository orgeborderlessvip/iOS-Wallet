//
//  WDCreatAccountViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDCreatAccountViewController.h"

#import "WDCreatAccountViewModel.h"

#import "NSString+changeTest.h"

@interface WDCreatAccountViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (nonatomic,strong) WDCreatAccountViewModel *viewModel;

@end

@implementation WDCreatAccountViewController

- (WDCreatAccountViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WDCreatAccountViewModel new];
        @weakify(self);
        [RACObserve(_viewModel, userName) subscribeNext:^(id x) {
            @strongify(self);
            self.accountTextField.text = x;
        }];
    }
    return _viewModel;
}

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"创建账户");
    [_confirmButton setTitle:WDLocalizedString(@"确定") forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToHeadView:self.topbarView];
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
    @weakify(self);
    [[self.accountTextField rac_textSignal] subscribeNext:^(NSString *name) {
        self.accountTextField.text = [name changeTest];
        
        if (self.accountTextField.text.length > 20) {
            self.accountTextField.text = [self.accountTextField.text substringToIndex:20];
        }
        
        self.viewModel.userName = self.accountTextField.text;
    }];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel creatAccount];
        
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
