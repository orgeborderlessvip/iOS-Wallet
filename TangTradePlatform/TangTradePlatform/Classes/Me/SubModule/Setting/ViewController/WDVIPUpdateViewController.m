//
//  WDVIPUpdateViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDVIPUpdateViewController.h"
#import "WDVipUpdateViewModel.h"
@interface WDVIPUpdateViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateAccountLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic,strong) WDVipUpdateViewModel *viewModel;

@end

@implementation WDVIPUpdateViewController

- (WDVipUpdateViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WDVipUpdateViewModel alloc] init];
        @weakify(self);
        [RACObserve(_viewModel, updateFee) subscribeNext:^(id x) {
            @strongify(self);
            self.amountLabel.text = [NSString stringWithFormat:@"%@:%.5f BDS",WDLocalizedString(@"升级费用"),_viewModel.updateFee];
        }];
        
        [RACObserve(_viewModel, myAmount) subscribeNext:^(id x) {
            @strongify(self);
            self.updateAccountLabel.text = [NSString stringWithFormat:@"%@:%.5f BDS",WDLocalizedString(@"账户余额"),_viewModel.myAmount];
            
        }];
        
        [RACObserve(_viewModel, isVip) subscribeNext:^(id x) {
            @strongify(self);
            self.confirmButton.hidden = self.viewModel.isVip;
        }];
    }
    return _viewModel;
}

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"会员升级");
    _amountLabel.text = [NSString stringWithFormat:@"%@:%@ BDS",WDLocalizedString(@"账户余额"),@"0.00000"];
    _vipLabel.text = WDLocalizedString(@"终身会员");
    _creatLabel.text = WDLocalizedString(@"可以创建账户,可以推荐他人");
    _updateAccountLabel.text = [NSString stringWithFormat:@"%@:%@ BDS",WDLocalizedString(@"升级费用"),@"0.00000"];
    
    [_confirmButton setTitle:WDLocalizedString(@"确认升级") forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewModel];
    
    [self addChangeToView:self.topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width ];
    @weakify(self);
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"确定升级成为终身会员么" withButtonTitle:@[@"确定",@"取消"] clickAction:^(NSInteger index, NSString *title) {
            if (index == 0) {
                [self.viewModel clickUpdate];
            }
        }];
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
