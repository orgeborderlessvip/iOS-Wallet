//
//  WDBuy_SellViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBuy_SellViewController.h"
#import "WDBuy_SellViewModel.h"
#import "WDBuy_SellTableViewCell.h"
@interface WDBuy_SellViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>

@property (nonatomic,strong) WDBuy_SellViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 货币价格旁Label
 */
@property (weak, nonatomic) IBOutlet UILabel *coinPriceLabel;
/**
 输入货币字段
 */
@property (weak, nonatomic) IBOutlet UITextField *coinPriceTextField;

/**
 货币数量显示Label
 */
@property (weak, nonatomic) IBOutlet UILabel *coinAmountLabel;

/**
 输入货币数量
 */
@property (weak, nonatomic) IBOutlet UITextField *coinAmountTextField;

/**
 成交价格
 */
@property (weak, nonatomic) IBOutlet UILabel *turnOverLabel;

/**
 手续费
 */
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;

/**
 我的货币
 */
@property (weak, nonatomic) IBOutlet UILabel *myMoneyLabel;

/**
 最低购买价格
 */
@property (weak, nonatomic) IBOutlet UILabel *lowestLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

//显示国际化Label
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *GMVLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnOverTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightWidth;

@end

@implementation WDBuy_SellViewController

- (WDBuy_SellViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WDBuy_SellViewModel alloc] init];
        @weakify(self);
        [RACObserve(_viewModel, buyArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        [RACObserve(_viewModel, sellArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        
        [RACObserve(self, isSell) subscribeNext:^(id x) {
            self.confirmButton.backgroundColor = self.isSell?RGBColor(249, 133, 65, 1):RGBColor(65,155,249,1);
        }];
    }
    return _viewModel;
}

- (void)languageSet {
    _typeLabel.text = WDLocalizedString(@"类型");
    _priceLabel.text = WDLocalizedString(@"价格");
    _amountLabel.text = WDLocalizedString(@"数量");
    _GMVLabel.text = WDLocalizedString(@"成交量");
    _priceTitleLabel.text = WDLocalizedString(@"价格");
    _amountTitleLabel.text = WDLocalizedString(@"数量");
    _turnOverTitleLabel.text = WDLocalizedString(@"成交额");
    _serviceTitleLabel.text = WDLocalizedString(@"手续费");
    
    /**
     bds不固定

     @return <#return value description#>
     */
#warning ----bds----
    _myMoneyLabel.text = [NSString stringWithFormat:@"%@:%.4f %@",WDLocalizedString(@"我的资产"),self.viewModel.myAount,@"BDS"];
    _lowestLabel.text = [NSString stringWithFormat:@"%@:%.4f %@",WDLocalizedString(@"最低购买价格"),self.viewModel.lowestBuy,@"BDS"];
    NSString *title = self.isSell?@"买入":@"卖出";
    [_confirmButton setTitle:WDLocalizedString(title) forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.layer.masksToBounds = YES;
    
    [RACObserve(self.view, frame) subscribeNext:^(id x) {
        _heightWidth.constant = self.view.frame.size.width;
        
        NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 25;
    [self.tableView registerNib:[UINib nibWithNibName:@"WDBuy_SellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0?self.viewModel.buyArray.count:self.viewModel.sellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDBuy_SellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    NSArray *array = indexPath.section == 0? self.viewModel.sellArray:self.viewModel.buyArray;
    
    cell.model = array[indexPath.row];
    
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