//
//  WDTradeChildViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTradeChildViewController.h"
#import "WDTradeChildViewModel.h"
#import "WDTradeBaseTableViewCell.h"

#import "WDBuy_SellBaseViewController.h"
@interface WDTradeChildViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) WDTradeChildViewModel *viewModel;

@end

@implementation WDTradeChildViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (WDTradeChildViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WDTradeChildViewModel alloc] init];
        
        @weakify(self);
        
        [_viewModel.dataSubject subscribeNext:^(id x) {
            @strongify(self);
            [self.dataArray addObject:x];
        }];
        
        [_viewModel.dataSubject subscribeCompleted:^{
            @strongify(self);
            
            DLog(@"数据加载完成");
            
            [self.tableView reloadData];
        }];
    }
    return _viewModel;
}

- (void)setDataArray:(NSArray *)totalDataArray index:(NSInteger)index {
    self.viewModel.dataArray = totalDataArray;
    self.viewModel.index = index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectNull style:(UITableViewStyleGrouped)];
    
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"WDTradeBaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.view);
    }];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.rowHeight = 150;
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    self.view.backgroundColor = RGBColor(246, 246, 246, 1);
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDTradeBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.dataArray.count - 1) {
        return 0.01;
    }else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else {
        return 5;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[WDBuy_SellBaseViewController new] animated:YES];
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
