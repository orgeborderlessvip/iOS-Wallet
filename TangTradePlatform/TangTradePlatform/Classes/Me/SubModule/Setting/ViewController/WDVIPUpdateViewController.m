//
//  WDVIPUpdateViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDVIPUpdateViewController.h"

@interface WDVIPUpdateViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateAccountLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation WDVIPUpdateViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"会员升级");
#warning YuENotComplete
    _amountLabel.text = [NSString stringWithFormat:@"%@:%@ BDS",WDLocalizedString(@"账户余额"),@"88888"];
    _vipLabel.text = WDLocalizedString(@"终身会员");
#warning 终身会员还需更新
    _creatLabel.text = WDLocalizedString(@"可以创建账户,可以推荐他人");
#warning 升级费用
    _updateAccountLabel.text = [NSString stringWithFormat:@"%@:%@ BDS",WDLocalizedString(@"升级费用"),@"10000"];
    
    [_confirmButton setTitle:WDLocalizedString(@"确认升级") forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToView:self.topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width ];
    @weakify(self);
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
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
