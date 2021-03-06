//
//  WDHomeViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHomeViewController.h"
#import "WDHomeHeadView.h"
#import "WDHomeTableViewCell.h"
#import "WDHomeTableViewModel.h"
#import "WDHomeTableDataModel.h"
#import "WDBlockViewController.h"
@interface WDHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) WDHomeHeadView *homeHeadView;

@property (nonatomic,strong) WDHomeTableViewModel *viewModel;

@end

@implementation WDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[WDHomeTableViewModel alloc] init];
    
    @weakify(self);
    
    [self.viewModel.dataSubject subscribeNext:^(NSArray *array) {
        @strongify(self);
        WDHomeTableDataModel *model = array.firstObject;
        
        self.homeHeadView.amountLabel.text = model.coinPrice;
        
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _homeHeadView = [WDHomeHeadView creatXib];
    
    [self.view addSubview:_homeHeadView];
    
    [[self.homeHeadView.blockButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController pushViewController:[WDBlockViewController new] animated:YES];
    }];
    
    [_homeHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.4);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_homeHeadView.mas_bottom);
        
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WDHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
        
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [_viewModel loadMoreData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.section == self.viewModel.dataArray.count - 1) {
            return 80;
        }
        return 85;
    }else {
        if (indexPath.section == self.viewModel.dataArray.count - 1) {
            return 85;
        }else {
            return 90;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.viewModel.dataArray[indexPath.row];
    
    if (indexPath.section == 0) {
        cell.headLineView.hidden = YES;
        
        if (indexPath.section == self.viewModel.dataArray.count - 1) {
            cell.bottomLineView.hidden = YES;
        }
    }else {
        if (indexPath.section == self.viewModel.dataArray.count - 1) {
            cell.bottomLineView.hidden = YES;
        }else {
            cell.headLineView.hidden = NO;
            cell.bottomLineView.hidden = NO;
        }
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
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
