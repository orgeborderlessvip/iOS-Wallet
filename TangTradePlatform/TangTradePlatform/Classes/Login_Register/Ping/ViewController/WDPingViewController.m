//
//  WDPingViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/19.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDPingViewController.h"
#import "WDPingTableViewCell.h"
#import "WDPingModel.h"
#import "WDNetworkManager.h"
@interface WDPingViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *serverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yanChiLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuurentChooseLabel;

@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation WDPingViewController

- (void)languageSet {
    _serverNameLabel.text = WDLocalizedString(@"节点名称");
    _yanChiLabel.text = WDLocalizedString(@"延迟");
    _statusLabel.text = WDLocalizedString(@"状态");
    _cuurentChooseLabel.text = WDLocalizedString(@"当前选择");
    _titleLabel.text = WDLocalizedString(@"节点名称");
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToHeadView:self.topbarView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = <#UITableViewCellSeparatorStyleNone#>;
//    _tableView.rowHeight = <#25#>;
    [_tableView registerNib:[UINib nibWithNibName:@"WDPingTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    _tableView.tableFooterView = [[UIView alloc] init];
    
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
    
//    @weakify(self);
    [self.refreshButton addTarget:self action:@selector(getPing) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    for (NSString *item in [WDNetworkManager sharedInstance].urlArray) {
        WDPingModel *model = [WDPingModel modelWithBaseUrl:item];
        
        [self.dataArray addObject:model];
        
    }
    
//    __block NSInteger j = 0;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        WDPingModel *model = self.dataArray[i];
        
        @weakify(self);
        
        [RACObserve(model, ping) subscribeNext:^(id x) {
            @strongify(self);
        
//            j ++;
//            if (j == self.dataArray.count) {
                [self sortArray];
                
//                j = 0;
//            }
        }];
    }
    
    [self getPing];
}

- (void)getPing {
    for (WDPingModel *data in self.dataArray) {
        [data startPing];
    }
}

- (void)sortArray {
    for (int i = 0; i < self.dataArray.count; i++)
    {
        for (int j = i; j < self.dataArray.count; j++)
        {
            
            WDPingModel *data1 = self.dataArray[i];
            WDPingModel *data2 = self.dataArray[j];
            if (data1.ping > data2.ping)
            {
                
                self.dataArray[i] = self.dataArray[j];
                self.dataArray[j] = data1;
            }
        }
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDPingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WDPingModel *model = self.dataArray[indexPath.row];
    
    [WDWalletManager setConnectUrl:model.baseSockUrl];
    
    if (model.ping < CGFLOAT_MAX) {
        [WDWalletManager setConnectUrl:model.baseSockUrl];
        
        for(int i = 0; i < self.dataArray.count;i ++) {
            WDPingModel *model = self.dataArray[i];
            
            if (indexPath.row == i) {
                model.selected = YES;
            }else {
                model.selected = NO;
            }
        }
        
        
        [self.tableView reloadData];
    }
    
    
}

@end
