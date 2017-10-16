//
//  WDBlockViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBlockViewController.h"
#import "WDBlockViewModel.h"
#import "WDBlockTableViewCell.h"
@interface WDBlockViewController ()<UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *logoBackGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *topInfoBackGroundView;
@property (weak, nonatomic) IBOutlet UIView *topInfoShadowView;
@property (weak, nonatomic) IBOutlet UILabel *currentBlockLabel;
@property (weak, nonatomic) IBOutlet UILabel *headBlockAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeWitnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *membersLabel;
@property (weak, nonatomic) IBOutlet UIView *tableShadowBackGroundView;
@property (weak, nonatomic) IBOutlet UIView *tableBackGroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) WDBlockViewModel *viewModel;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UILabel *currentBlockTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *headBlockAgeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeWitnessesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextMaintenanceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeMembersTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *blockIdTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *generateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *witnessesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionsTitleLabel;



@end

@implementation WDBlockViewController

- (void)languageSet {
    NSString *currentText = WDLocalizedString(@"当前区块");
    NSString *lastText = WDLocalizedString(@"上一个区块");
    NSString *huoYueText = WDLocalizedString(@"活跃见证人");
    NSString *nextText = WDLocalizedString(@"下个区块生成时间");
    NSString *lishiText = WDLocalizedString(@"活跃理事会成员");
    NSString *blockIdText = WDLocalizedString(@"区块 ID");
    NSString *blockTime = WDLocalizedString(@"区块生成时间");
    NSString *jianzhengRen = WDLocalizedString(@"见证人");
    NSString *jiaoyiShu = WDLocalizedString(@"交易数");
    _currentBlockTitleLabel.text = currentText;
    _headBlockAgeTitleLabel.text = lastText;
    _activeWitnessesTitleLabel.text = huoYueText;
    _nextMaintenanceTimeLabel.text = nextText;
    _activeMembersTitleLabel.text = lishiText;
    _blockIdTitleLabel.text = blockIdText;
    _generateTitleLabel.text = blockTime;
    _witnessesTitleLabel.text = jianzhengRen;
    _transactionsTitleLabel.text = jiaoyiShu;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clicpFunction];
    
    self.tableView.dataSource = self;
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WDBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    self.viewModel = [[WDBlockViewModel alloc] init];
//绑定VM的属性和view上的属性
    RAC(self.currentBlockLabel,text) = RACObserve(self.viewModel, currentBlock);
    RAC(self.headBlockAgeLabel,text) = RACObserve(self.viewModel, headBlockAge);
    RAC(self.activeWitnessLabel,text) = RACObserve(self.viewModel, activeWitness);
    RAC(self.nextTimeLabel,text) = RACObserve(self.viewModel, nextMainTime);
    RAC(self.membersLabel,text) = RACObserve(self.viewModel, activeCommitteeMember);
    @weakify(self)
    [self.viewModel.dataSubject subscribeNext:^(NSArray *data) {
        @strongify(self);
        [self.dataArray addObjectsFromArray:data];
        [self.tableView reloadData];
    }error:^(NSError *error) {
        
    }];
    
    [self.viewModel.clearSubject subscribeNext:^(id x) {
        [self.dataArray removeAllObjects];
    }];
}

- (void)generateStrings {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel loadHeadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDBlockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    [cell setDataModel:self.dataArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

/**
 裁剪和增加阴影
 */
- (void)clicpFunction {
    [self addShadowToView:_logoBackGroundView];
    [self addCornerRadius:20 toView:_logoImageView];
    [self addShadowToView:_topInfoShadowView];
    [self addCornerRadius:20 toView:_topInfoBackGroundView];
    [self addShadowToView:_tableShadowBackGroundView];
    [self addCornerRadius:20 toView:_tableBackGroundView];
}

- (void)addCornerRadius:(CGFloat)radius toView:(UIView *)view{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

- (void)addShadowToView:(UIView *)view {
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.4].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 0.5f;
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
