//
//  WDMyTradeRecordViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/29.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMyTradeRecordViewController.h"

#import "WDMeTableViewCell.h"

#import "WDMyTradeRecordViewModel.h"

@interface WDMyTradeRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (nonatomic,strong) WDMyTradeRecordViewModel *viewModel;

@end

@implementation WDMyTradeRecordViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"转账记录");
}

- (WDMyTradeRecordViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WDMyTradeRecordViewModel new];
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
    [self addChangeToHeadView:self.topbarView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 60;
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"WDMeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    @weakify(self);
    [[self.refreshButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel loadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.viewModel.dataArray[indexPath.row];
    
    return cell;
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
