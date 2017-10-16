//
//  WDChengDuiRecordViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiRecordViewController.h"

#import "WDChengDuiRecordViewModel.h"
#import "WDChengDuiRecordTableViewCell.h"

@interface WDChengDuiRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *paySupportNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinKindLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (nonatomic,strong) WDChengDuiRecordViewModel *viewModel;

@end

@implementation WDChengDuiRecordViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"记录");
    _paySupportNameLabel.text = WDLocalizedString(@"承兑商");
    _dateLabel.text = WDLocalizedString(@"时间");
    _amountLabel.text = WDLocalizedString(@"数量");
    _coinKindLabel.text = WDLocalizedString(@"币种");
    _stateLabel.text = WDLocalizedString(@"状态");
    
    [_changeControl setTitle:WDLocalizedString(@"充值记录") forSegmentAtIndex:0];
    [_changeControl setTitle:WDLocalizedString(@"提现记录") forSegmentAtIndex:1];
}

- (WDChengDuiRecordViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WDChengDuiRecordViewModel new];
        
        [RACObserve(_viewModel, outArray) subscribeNext:^(id x) {
            [self.tableView reloadData];
        }];
        [RACObserve(_viewModel, selectedKind) subscribeNext:^(id x) {
            [self.tableView reloadData];
        }];
        [RACObserve(_viewModel, inArray) subscribeNext:^(id x) {
            [self.tableView reloadData];
        }];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToView:self.topBarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width ];
    
    @weakify(self);
    [[_changeControl rac_signalForControlEvents:(UIControlEventValueChanged)] subscribeNext:^(id x) {
        @strongify(self);
        
        self.viewModel.selectedKind = self.changeControl.selectedSegmentIndex;
        
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 25;
    [_tableView registerNib:[UINib nibWithNibName:@"WDChengDuiRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.viewModel.selectedKind) {
        case SelectedKindIn:
            return self.viewModel.inArray.count;
            break;
        case SelectedKindOut:
            return self.viewModel.outArray.count;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDChengDuiRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    NSArray *array = nil;
    
    switch (self.viewModel.selectedKind) {
        case SelectedKindIn:
            array = self.viewModel.inArray;
            break;
        case SelectedKindOut:
            array = self.viewModel.outArray;
            break;
    }
    
    cell.model = array[indexPath.row];
    
    return cell;
}

@end