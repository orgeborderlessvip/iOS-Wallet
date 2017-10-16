//
//  WDChongZhi_TiXianViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChongZhi_TiXianViewController.h"
#import "WDChongZhiChildViewController.h"
#import "WDTiXianChildViewController.h"
@interface WDChongZhi_TiXianViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic,strong) WDChongZhiChildViewController *chongzhiVC;
@property (nonatomic,strong) WDTiXianChildViewController *tixianVC;

@end

@implementation WDChongZhi_TiXianViewController

- (void)languageSet {
    [self.segControl setTitle:WDLocalizedString(@"充值") forSegmentAtIndex:0];
    [self.segControl setTitle:WDLocalizedString(@"提现") forSegmentAtIndex:1];
    self.titleLabel.text = [self.segControl titleForSegmentAtIndex:self.segControl.selectedSegmentIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChangeToView:self.topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width];

    _chongzhiVC = [WDChongZhiChildViewController new];
    _chongzhiVC.dataModel = _dataModel;
    [self addChildViewController:_chongzhiVC];
    [self.bottomView addSubview:_chongzhiVC.view];
    [_chongzhiVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.bottomView);
    }];
    
    _tixianVC = [WDTiXianChildViewController new];
    _tixianVC.dataModel = _dataModel;
    [self addChildViewController:_tixianVC];
    [self.bottomView addSubview:_tixianVC.view];
    _tixianVC.view.hidden = YES;
    [_tixianVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.bottomView);
    }];
    @weakify(self);
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.segControl rac_signalForControlEvents:(UIControlEventValueChanged)] subscribeNext:^(id x) {
        @strongify(self);
        self.titleLabel.text = [self.segControl titleForSegmentAtIndex:self.segControl.selectedSegmentIndex];
        
        self.chongzhiVC.view.hidden = !self.chongzhiVC.view.hidden;
        self.tixianVC.view.hidden = !self.tixianVC.view.hidden;
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
