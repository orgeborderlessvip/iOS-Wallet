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
#import "WDBuy_SellTableDataModel.h"
#import "NSString+changeTest.h"
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
@property (weak, nonatomic) IBOutlet UILabel *turnOverAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnOverLabel;

/**
 手续费
 */
@property (weak, nonatomic) IBOutlet UILabel *serviceChargeAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;

/**
 我的货币
 */
@property (weak, nonatomic) IBOutlet UILabel *myMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *myMoneyTitleLabel;

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
        _viewModel = [[WDBuy_SellViewModel alloc] initWithBaseCoin:self.baseCoin quetoCoin:self.quetoCoin isBuy:!_isSell];
        @weakify(self);
        
        [RACObserve(_viewModel, isBuy) subscribeNext:^(id x) {
            @strongify(self);
            self.confirmButton.backgroundColor = self.viewModel.isBuy? RGBColor(0, 130, 226, 1):RGBColor(243, 144, 2, 1);
        }];
        
        [RACObserve(_viewModel, buyArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        [RACObserve(_viewModel, sellArray) subscribeNext:^(id x) {
            @strongify(self);
            [self.tableView reloadData];
        }];
        
        [RACObserve(_viewModel, quetoCoin) subscribeNext:^(NSString *string) {
            @strongify(self);
            
            [[self class] setWithBase:self.baseCoin quote:self.quetoCoin toLabel:self.coinPriceLabel withFont:[UIFont systemFontOfSize:14] toFont:[UIFont systemFontOfSize:10]];
            
//            self.coinPriceLabel.text = [NSString stringWithFormat:@"%@/%@",self.baseCoin,self.quetoCoin];
            
            NSString *base = self.quetoCoin;
            
            if (!self.isSell) {
                base = self.baseCoin;
            }
            [[self class] setWithCoin:base toLabel:self.turnOverLabel withFont:[UIFont systemFontOfSize:14] toFont:[UIFont systemFontOfSize:10]];
//            self.turnOverLabel.text = [NSString stringWithFormat:@"%.5f%@",self.viewModel.turnOver,base];
            [[self class] setWithCoin:string toLabel:self.coinAmountLabel withFont:[UIFont systemFontOfSize:14] toFont:[UIFont systemFontOfSize:10]];
//            self.coinAmountLabel.text = string;
            
        }];
        
        [RACObserve(_viewModel, price) subscribeNext:^(id x) {
            @strongify(self);
            if (self.viewModel.price != 0) {
                
                NSString *symbol = self.baseCoin;
                
                NSString *price = [NSString stringWithFormat:@"%.5f",self.viewModel.price];
                
                if ([symbol isEqualToString:@"BTC"] || [symbol isEqualToString:@"BDS"]) {
                    price = [price digitalNumberWithMaxLength:4];
                }else {
                    price = [price digitalNumberWithMaxLength:3];
                }
                
                self.coinPriceTextField.text = price;
            }
        }];
        
        [RACObserve(_viewModel, baseCoin) subscribeNext:^(id x) {
            @strongify(self);
            
//            [[self class] setWithCoin:x toLabel:self.serviceLabel];
            
            [[self class] setWithCoin:x toLabel:self.turnOverLabel withFont:[UIFont systemFontOfSize:14] toFont:[UIFont systemFontOfSize:10]];
            [[self class] setWithCoin:@"BDS" toLabel:self.serviceLabel withFont:[UIFont systemFontOfSize:14] toFont:[UIFont systemFontOfSize:10]];
        }];
        
        [[self.coinPriceTextField rac_textSignal] subscribeNext:^(NSString *price) {
            @strongify(self);
            NSString *symbol = self.baseCoin;
            
            if ([symbol isEqualToString:@"BTC"] || [symbol isEqualToString:@"BDS"]) {
                price = [price digitalNumberWithMaxLength:4];
            }else {
                price = [price digitalNumberWithMaxLength:3];
            }
            
            self.coinPriceTextField.text = price;
        }];
        
        [RACObserve(_viewModel, amount) subscribeNext:^(id x) {
            @strongify(self);
            if (self.viewModel.amount != 0) {
                NSString *price = [NSString stringWithFormat:@"%.5f",self.viewModel.amount];
                
                NSString *symbol = self.quetoCoin;
                
                if ([symbol isEqualToString:@"BTC"] || [symbol isEqualToString:@"BDS"]) {
                    price = [price digitalNumberWithMaxLength:4];
                }else {
                    price = [price digitalNumberWithMaxLength:3];
                }
                
                self.coinAmountTextField.text = price;
            }
        }];
        
        [[self.coinPriceTextField rac_signalForControlEvents:(UIControlEventEditingDidEnd)] subscribeNext:^(UITextField *string) {
            @strongify(self);
            self.viewModel.price = [self.coinPriceTextField.text doubleValue];
        }];
        
        [[self.coinAmountTextField rac_textSignal]subscribeNext:^(NSString *price) {
            @strongify(self);
            NSString *symbol = self.quetoCoin;
            
            if ([symbol isEqualToString:@"BTC"] || [symbol isEqualToString:@"BDS"]) {
                price = [price digitalNumberWithMaxLength:4];
            }else {
                price = [price digitalNumberWithMaxLength:3];
            }
            
            self.coinAmountTextField.text = price;
        }];
        
        [[self.coinAmountTextField rac_signalForControlEvents:(UIControlEventEditingDidEnd)] subscribeNext:^(id x) {
            @strongify(self);
            
            self.viewModel.amount = [self.coinAmountTextField.text doubleValue];
        }];
        
        [RACObserve(_viewModel, turnOver) subscribeNext:^(NSNumber *x) {
            @strongify(self);
            self.turnOverAmountLabel.text = [NSString stringWithFormat:@"%.5f",self.viewModel.turnOver];
        }];
        
        [RACObserve(_viewModel, serviceSymbol) subscribeNext:^(id x) {
            @strongify(self);
            [[self class] setWithCoin:x toLabel:self.serviceLabel withFont:[UIFont systemFontOfSize:14]toFont:[UIFont systemFontOfSize:10]];
        }];
        
        [RACObserve(_viewModel, serviceCharge) subscribeNext:^(id x) {
            @strongify(self);
            self.serviceChargeAmountLabel.text = [NSString stringWithFormat:@"%.5f",self.viewModel.serviceCharge];
        }];
        
        [RACObserve(_viewModel, myAount) subscribeNext:^(id x) {
            @strongify(self);
            
            NSString *base = self.quetoCoin;
            
            if (!self.isSell) {
                base = self.baseCoin;
            }
            
            self.myMoneyLabel.text = [NSString stringWithFormat:@"%@:%.5f",WDLocalizedString(@"我的资产"),self.viewModel.myAount];
            
            [[self class] setWithCoin:base toLabel:self.myMoneyTitleLabel withFont:[UIFont systemFontOfSize:12] toFont:[UIFont systemFontOfSize:8]];
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
    
    _myMoneyLabel.text = [NSString stringWithFormat:@"%@:%.5f %@",WDLocalizedString(@"我的资产"),self.viewModel.myAount,self.baseCoin];
    _lowestLabel.text = [NSString stringWithFormat:@"%@:%.5f %@",WDLocalizedString(@"最低购买价格"),self.viewModel.lowestBuy,self.baseCoin];
    NSString *title = !self.isSell?@"买入":@"卖出";
    [_confirmButton setTitle:WDLocalizedString(title) forState:(UIControlStateNormal)];
}

- (void)setQuetoCoin:(NSString *)quetoCoin {
    if (_quetoCoin == nil) {
        _quetoCoin = quetoCoin;
        return;
    }
    
    _quetoCoin = quetoCoin;
    if ([_quetoCoin isEqualToString:self.viewModel.quetoCoin]) return;
    self.viewModel.quetoCoin = quetoCoin;
}

- (void)setBaseCoin:(NSString *)baseCoin {
    _baseCoin = baseCoin;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.layer.masksToBounds = YES;
    @weakify(self);
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        
        [self.viewModel sendPay];
    }];
    
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

- (void)getAllData {
    [self.viewModel getAllData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = section == 0?self.viewModel.sellArray:self.viewModel.buyArray;
    
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDBuy_SellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    NSArray *array = indexPath.section == 0? self.viewModel.sellArray:self.viewModel.buyArray;
    
    cell.model = array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = indexPath.section == 0? self.viewModel.sellArray:self.viewModel.buyArray;
    
    WDBuy_SellTableDataModel *model = array[indexPath.row];
    
    self.viewModel.price = [model.price doubleValue];
    self.viewModel.amount = [model.amount doubleValue];
}

@end
