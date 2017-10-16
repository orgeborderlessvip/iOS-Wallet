//
//  WDChengDuiViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiViewController.h"
#import "WDChengDuiViewModel.h"
#import "WDChengDuiShangTableViewCell.h"
#import "WDChengDuiRecordViewController.h"
#import "WDChongZhi_TiXianViewController.h"
@interface WDChengDuiViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cashOutButton;

@property (nonatomic,strong) WDChengDuiViewModel *viewModel;

@end

@implementation WDChengDuiViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"承兑商");
}

- (WDChengDuiViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WDChengDuiViewModel new];
        
        @weakify(self);
        
        [RACObserve(_viewModel, dataArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChangeToView:self.topBarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width ];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 120;
    [_tableView registerNib:[UINib nibWithNibName:@"WDChengDuiShangTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    @weakify(self);
    [[self.cashOutButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController pushViewController:[WDChengDuiRecordViewController new] animated:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDChengDuiShangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.viewModel.dataArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.viewModel.dataArray.count) {
        return 0.01;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WDChongZhi_TiXianViewController *vc = [WDChongZhi_TiXianViewController new];
    
    vc.dataModel = self.viewModel.dataArray[indexPath.section];
    
    [self.navigationController pushViewController:vc animated:YES];
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
