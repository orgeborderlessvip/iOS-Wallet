//
//  WDMeViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMeViewController.h"
#import "WDMeViewModel.h"
#import "WDMeTableViewCell.h"
#import "WDNetworkManager.h"
#import "WDReceptionViewController.h"
#import "WDSendOutViewController.h"
#import "SettingViewController.h"
@interface WDMeViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *receptionBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *receptionButton;
@property (weak, nonatomic) IBOutlet UIView *sendBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quitHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (nonatomic,strong) WDMeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@end

@implementation WDMeViewController

- (void)languageSet {
    NSString *record = WDLocalizedString(@"交易记录");
    NSString *pay = WDLocalizedString(@"付款");
    NSString *recive = WDLocalizedString(@"收款");
    _recordLabel.text = record;
    [_sendButton setTitle:pay forState:(UIControlStateNormal)];
    [_receptionButton setTitle:recive forState:(UIControlStateNormal)];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (CGRectGetWidth([UIScreen mainScreen].bounds) < 360) {
//        _quitHeight.constant = 24;
//        _topHeight.constant -= 8;
//    }
    
    _nameLabel.text = [WDNetworkManager sharedInstance].userName;
    
    _viewModel = [[WDMeViewModel alloc] init];
    
    CGFloat size_width = (CGRectGetWidth([UIScreen mainScreen].bounds) - 80) / 2;
    
    [self addChangeToView:self.receptionBackGroundView withDirection:ChangeDirectionLeft_Right startColor:RGBColor(255, 185, 74,1) endColor:RGBColor(243, 144, 2,1) width:size_width];
    
    self.receptionBackGroundView.layer.cornerRadius = 5;
    self.receptionBackGroundView.layer.masksToBounds = YES;
    
    [self addChangeToView:self.sendBackGroundView withDirection:ChangeDirectionLeft_Right startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(0, 130, 226, 1) width:size_width];
    
    self.sendBackGroundView.layer.cornerRadius = 5;
    self.sendBackGroundView.layer.masksToBounds = YES;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [RACObserve(self.viewModel, dataArray) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WDMeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 60;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    
    self.tableView.tableFooterView.backgroundColor = RGBColor(246, 246, 246, 1);
    
    [self registerButtonAction];
}

- (void)registerButtonAction {
    @weakify(self)
    [[self.receptionButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController pushViewController:[WDReceptionViewController new] animated:YES];
    }];
    [[self.sendButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController pushViewController:[WDSendOutViewController new] animated:YES];
    }];
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController pushViewController:[SettingViewController new] animated:YES];
    }];
    [[self.refreshButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self.viewModel loadData];
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self.viewModel loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.viewModel.dataArray[indexPath.row];
    
    return cell;
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
