//
//  WDTiXianChildViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTiXianChildViewController.h"
#import "WDChongZhinContainerView.h"
#import "WDTiXianChildViewModel.h"

#import "WDAcceptance_CointypeDataModel.h"
#import "WDCoinTypeWayDataModel.h"
#import "NSString+changeTest.h"
@interface WDTiXianChildViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;
@property (weak, nonatomic) IBOutlet UILabel *coinKindLabel;
@property (weak, nonatomic) IBOutlet UIButton *coinButton;
@property (weak, nonatomic) IBOutlet UITextField *assetsTextField;
@property (weak, nonatomic) IBOutlet UILabel *assetsLabel;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UILabel *serviceChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceChargeKindLabel;
@property (weak, nonatomic) IBOutlet UILabel *gateWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *gateWayKindLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UILabel *tiXianStyleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuETitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceChargeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *gateWayTitleLabel;
@property (nonatomic,strong) WDChongZhinContainerView *containerView;
@property (nonatomic,strong) WDTiXianChildViewModel *viewModel;

@end

@implementation WDTiXianChildViewController

- (void)languageSet {
    _tiXianStyleTitleLabel.text = WDLocalizedString(@"请选择提现币种");
    [self setBalance];
    _assetsTitleLabel.text = WDLocalizedString(@"提现资产");
    _serviceChargeTitleLabel.text = WDLocalizedString(@"手续费");
    _gateWayTitleLabel.text = WDLocalizedString(@"服务费");
}

- (WDTiXianChildViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WDTiXianChildViewModel alloc] initWithPayId:self.dataModel.AcceptanceList_ID name:self.dataModel.paySupportName];
        
        @weakify(self);
        
        [RACObserve(_viewModel, currencyArray) subscribeNext:^(id x) {
            @strongify(self);
            WDAcceptance_CointypeDataModel *model = _viewModel.currencyArray[0];
            
            NSArray *stringArray = @[@"CNY",@"BTC",@"USD"];
            
            CurrencyKind kind = [stringArray indexOfObject:model.cointyp];
            
            if (kind == NSNotFound) {
                kind = CurrencyKindBTC;
            }
            
            self.viewModel.selectedCurrencyIndex = 0;
            self.viewModel.currencyKind = kind;
        }];
        
        [RACObserve(self.viewModel, selectedStyleIndex) subscribeNext:^(id x) {
            @strongify(self);
            switch (self.viewModel.selectedStyleIndex) {
                case SelectedPayKindCNYWeChat:
                    _containerHeight.constant = 61 * 2 + 15;
                    break;
                case SelectedPayKindCNYCard:
                    _containerHeight.constant = 61 * 4 + 15 * 3;
                    break;
                case SelectedPayKindUSDCard:
                    _containerHeight.constant = 61 * 3 + 15 * 2;
                    break;
                case SelectedPayKindBTCWallet:
                    _containerHeight.constant = 61;
                    break;
                case SelectedPayKindCNYAlipay:
                    _containerHeight.constant = 61 * 2 + 15;
                    break;
                default:
                    break;
            }
            self.containerView.selectedKind = self.viewModel.selectedStyleIndex;
            [self.containerView clearText];
        }];
    
        [RACObserve(self.viewModel, currencyKind) subscribeNext:^(id x) {
            @strongify(self);
            WDAcceptance_CointypeDataModel *model = self.viewModel.currencyArray[self.viewModel.selectedCurrencyIndex];
            
            self.coinKindLabel.text = model.cointyp;
            [self.containerView clearText];
        }];
        
        [RACObserve(self.viewModel, myMoney) subscribeNext:^(id x) {
            @strongify(self);
            [self setBalance];
        }];
    }
    return _viewModel;
}

- (void)setBalance {
    NSString *title = nil;
    switch (self.viewModel.currencyKind) {
        case CurrencyKindUSD:
            title = @"USD";
            break;
        case CurrencyKindCNY:
            title = @"CNY";
            break;
        case CurrencyKindBTC:{
            WDAcceptance_CointypeDataModel *model = self.viewModel.currencyArray[self.viewModel.selectedCurrencyIndex];
            
            title = model.cointyp;
        }
            break;
    }
    
    _yuETitleLabel.text = [NSString stringWithFormat:@"%@: %.4f%@",WDLocalizedString(@"余额"),self.viewModel.myMoney,title];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 1001;i < 1006;i ++) {
        UIView *view = [self.view.subviews.firstObject viewWithTag:i];
        
        [[self class] addCornerRadius:5 toView:view];
    }
    
    self.containerView = [WDChongZhinContainerView creatXib];
    
    [self addBind];
    
    [self registerFunction];
    
    [self.containView addSubview:self.containerView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.containView);
    }];
}

- (void)addBind {
    RAC(self.assetsLabel,text) = RACObserve(self.coinKindLabel, text);
    RAC(self.serviceChargeKindLabel,text) = RACObserve(self.coinKindLabel, text);
    RAC(self.gateWayKindLabel,text) = RACObserve(self.coinKindLabel, text);
    @weakify(self);
    [[self.containerView.nameTextField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.cardName = x;
    }];
    
    [[self.containerView.cardTextField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.accountText = x;
    }];
    [[self.containerView.bankTextField rac_textSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.bankText = x;
    }];
    
//    RAC(self.viewModel,name) = RACObserve(self.containerView.nameTextField, text);
//    RAC(self.viewModel,accountText) = RACObserve(self.containerView.cardTextField, text);
//    RAC(self.viewModel,bankText) = RACObserve(self.containerView.bankTextField, text);
    
    
    [RACObserve(self.coinKindLabel, text) subscribeNext:^(id x) {
        @strongify(self);
        
        [self setBalance];
    }];
    
    [[self.assetsTextField rac_textSignal] subscribeNext:^(NSString *text) {
        @strongify(self);
        [self addLimitWithTextField:self.assetsTextField withCurrencyKind:self.viewModel.currencyKind];
    }];
}

- (void)registerFunction {
    @weakify(self);
    [[self.coinButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        
        
        @strongify(self);
        NSMutableArray *array = [NSMutableArray array];
        
        for (WDAcceptance_CointypeDataModel *model  in self.viewModel.currencyArray) {
            [array addObject:model.cointyp];
        }
        
        NSArray *stringArray = @[@"CNY",@"BTC",@"USD"];
        
        [[UIViewController currentViewController] showPickerIndexViewWithArr:array andSelectStr:self.coinKindLabel.text selectBolck:^(NSString *selectedString, NSInteger index) {
            CurrencyKind kind = [stringArray indexOfObject:array[index]];
            
            if (kind == NSNotFound) {
                kind = CurrencyKindBTC;
            }
        
            self.viewModel.selectedCurrencyIndex = index;
            self.viewModel.currencyKind = kind;
        }];
        
    }];
    
    [[self.containerView.styleButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *array = [NSMutableArray array];
        
        for (WDCoinTypeWayDataModel *item in self.viewModel.payStyleArray) {
            switch (item.cointypeway) {
                case SelectedPayKindUSDCard:
                case SelectedPayKindCNYCard:
                    [array addObject:@"银行卡"];
                    break;
                case SelectedPayKindBTCWallet:
                    [array addObject:@"钱包地址"];
                    break;
                case SelectedPayKindCNYWeChat:
                    [array addObject:@"微信"];
                    break;
                case SelectedPayKindCNYAlipay:
                    [array addObject:@"支付宝"];
                    break;
            }
        }
        
        NSString *string = WDLocalizedString([NSString stringWithUTF8String:payStyleNameArray[self.viewModel.selectedStyleIndex]]);
        
        [[UIViewController currentViewController] showPickerIndexViewWithArr:array andSelectStr:string selectBolck:^(NSString *selectedString, NSInteger index) {
            WDCoinTypeWayDataModel *model = self.viewModel.payStyleArray[index];
            
            SelectedPayKind kind = model.cointypeway;
            self.viewModel.selectedPayStyleKindIndex = index;
            self.viewModel.selectedStyleIndex = kind;
        }];
    }];
    
    [[self.submitButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel tiXianActionWithSuccess:^{
            
        } failture:^{
            
        }];
    }];
}

- (void)addLimitWithTextField:(UITextField *)textField withCurrencyKind:(CurrencyKind)kind {
    switch (kind) {
        case CurrencyKindCNY:
        case CurrencyKindUSD:
            textField.text = [textField.text digitalNumberWithMaxLength:0];
            break;
        case CurrencyKindBTC:
            textField.text = [textField.text digitalNumberWithMaxLength:2];
            break;
    }
    self.viewModel.inputMoney = [self.assetsTextField.text doubleValue];
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
