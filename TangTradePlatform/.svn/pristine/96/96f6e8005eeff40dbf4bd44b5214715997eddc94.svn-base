//
//  WDCreatAccountViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDCreatAccountViewController.h"

@interface WDCreatAccountViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation WDCreatAccountViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"创建账户");
    [_confirmButton setTitle:WDLocalizedString(@"确定") forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToHeadView:self.topbarView];
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
