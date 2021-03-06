//
//  WDHistory_TradeHistoryViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHistory_TradeHistoryViewController.h"
#import "WDHistory_TradeTableViewCell.h"
#import "WDHistory_TradeHistoryViewModel.h"
@interface WDHistory_TradeHistoryViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *btcLabel;
@property (weak, nonatomic) IBOutlet UILabel *bdsBTCLabel;
@property (nonatomic,strong) WDHistory_TradeHistoryViewModel *viewModel;
@end

@implementation WDHistory_TradeHistoryViewController

- (void)languageSet {
    _priceLabel.text = WDLocalizedString(@"价格");
    
    _riseTimeLabel.text = self.historyKind == HistoryKindHistory? WDLocalizedString(@"区块"):WDLocalizedString(@"交易时间");
}

- (WDHistory_TradeHistoryViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WDHistory_TradeHistoryViewModel alloc]  initWithKind:_historyKind BaseCoin:self.baseCoin queToCoin:self.quetoCoin];
        @weakify(self);
        [RACObserve(_viewModel, dataArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        
        [RACObserve(_viewModel, baseCoin) subscribeNext:^(id x) {
            @strongify(self);
            [[self class] setWithCoin:x toLabel:self.bdsBTCLabel withFont:[UIFont systemFontOfSize:13] toFont:[UIFont systemFontOfSize:9]];
        }];
        [RACObserve(_viewModel, quetoCoin) subscribeNext:^(id x) {
            @strongify(self);
            [[self class] setWithCoin:x toLabel:self.btcLabel withFont:[UIFont systemFontOfSize:13] toFont:[UIFont systemFontOfSize:9]];
        }];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 32;
    [_tableView registerNib:[UINib nibWithNibName:@"WDHistory_TradeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
}

- (void)getAllData {
    [self.viewModel getData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDHistory_TradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.viewModel.dataArray[indexPath.row];
    
    if (self.historyKind == HistoryKindTradeHistory) {
        cell.textColor = [UIColor blackColor];
    }
    
    return cell;
}

@end
