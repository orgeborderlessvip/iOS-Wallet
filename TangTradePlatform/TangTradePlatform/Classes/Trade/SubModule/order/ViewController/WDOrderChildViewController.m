//
//  WDOrderChildViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOrderChildViewController.h"
#import "WDOrderSelectionView.h"
#import "WDOrderTableViewCell.h"
#import "WDOrderViewModel.h"
@interface WDOrderChildViewController ()<UITableViewDataSource,UITableViewDelegate,UserLanguageChange>

@property (nonatomic,strong) WDOrderSelectionView *secView;

@property (nonatomic,strong) WDOrderViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *coinAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinTotalAmountLabel;

/**
 国际化Label
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;

@end

@implementation WDOrderChildViewController

- (void)languageSet {
    _priceLabel.text = WDLocalizedString(@"价格");
    _riseTimeLabel.text = WDLocalizedString(@"交易时间");
    _operationLabel.text = WDLocalizedString(@"操作");
}

- (WDOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WDOrderViewModel alloc] initWithBaseCoin:_baseCoin quetoCoin:_quetoCoin];
        @weakify(self);
        [RACObserve(_viewModel, dataSellArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        
        [RACObserve(_viewModel, dataBuyArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        
        [RACObserve(_viewModel, quetoCoin) subscribeNext:^(id x) {
            @strongify(self);
            [[self class] setWithCoin:self.viewModel.quetoCoin toLabel:self.coinAmountLabel withFont:[UIFont systemFontOfSize:13] toFont:[UIFont systemFontOfSize:8]];
        }];
        [RACObserve(_viewModel, baseCoin) subscribeNext:^(id x) {
            @strongify(self);
            [[self class] setWithCoin:self.viewModel.baseCoin toLabel:self.coinTotalAmountLabel withFont:[UIFont systemFontOfSize:13] toFont:[UIFont systemFontOfSize:8]];
        }];
    }
    return _viewModel;
}

- (void)getAllData {
    [self.viewModel getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _secView = [WDOrderSelectionView creatXib];
    [self.view addSubview:_secView];
    [_secView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 40;
    [_tableView registerNib:[UINib nibWithNibName:@"WDOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    [RACObserve(self.secView, selectedView) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.secView.selectedView == 0?self.viewModel.dataBuyArray:self.viewModel.dataSellArray;
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    NSArray *array = self.secView.selectedView == 0?self.viewModel.dataBuyArray:self.viewModel.dataSellArray;
    
    cell.model = array[indexPath.row];
    
    cell.redColor = self.secView.selectedView == 0;
    
    cell.clickBlock = ^{
        [self.viewModel cancleOrderWithSell:self.secView.selectedView == 1 withIndex:indexPath.row];
    };
    
    return cell;
}

@end
