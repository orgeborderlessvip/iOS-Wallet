//
//  WDChongZhiChildViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChongZhiChildViewController.h"
#import "WDChongZhiChildViewModel.h"

#import "WDShowChongZhiQRCodeView.h"
#import "WDShowChongZhiBankCardView.h"

#import "WDAcceptance_CointypeDataModel.h"
#import "WDCoinTypeWayDataModel.h"

#import "NSString+changeTest.h"
@interface WDChongZhiChildViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *currencyBackView;
@property (weak, nonatomic) IBOutlet UILabel *currencyKindLabel;
@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet UIView *assetsBackgroundView;
@property (weak, nonatomic) IBOutlet UITextField *assetsTextField;
@property (weak, nonatomic) IBOutlet UILabel *coinKindLabel;
@property (weak, nonatomic) IBOutlet UIView *chongzhiFangShiBackGroundView;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *currencyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleTitleLabel;

@property (nonatomic,strong) WDChongZhiChildViewModel *viewModel;

@end

@implementation WDChongZhiChildViewController

- (void)languageSet {
    _currencyTitleLabel.text = WDLocalizedString(@"请选择充值币种");
    [self setBalance];
    _assetsTitleLabel.text = WDLocalizedString(@"充值资产");
    _styleTitleLabel.text = WDLocalizedString(@"充值方式");
}

- (void)setBalance {
    NSString *title = nil;
    WDAcceptance_CointypeDataModel *model = self.viewModel.currencyArray[self.viewModel.selectedCurrencyIndex];
    
    title = model.cointyp;
    
    _balanceTitleLabel.text = [NSString stringWithFormat:@"%@: %.4f%@",WDLocalizedString(@"余额"),self.viewModel.myMoney,title];
}

- (WDChongZhiChildViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WDChongZhiChildViewModel alloc] initWithPayId:self.dataModel.AcceptanceList_ID name:self.dataModel.paySupportName];
        
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
        
        [RACObserve(_viewModel, selectedStyleIndex) subscribeNext:^(id x) {
            @strongify(self);
            self.cardLabel.text = WDLocalizedString([NSString stringWithUTF8String:payStyleNameArray[self.viewModel.selectedStyleIndex]]);
        }];
        
        [RACObserve(_viewModel, currencyKind) subscribeNext:^(id x) {
            @strongify(self);
            
            [self addLimitWithTextField:self.assetsTextField withCurrencyKind:(self.viewModel.currencyKind)];
            
            WDAcceptance_CointypeDataModel *model = self.viewModel.currencyArray[self.viewModel.selectedCurrencyIndex];
            
            self.currencyKindLabel.text = model.cointyp;
        }];
        
        [RACObserve(self.viewModel, myMoney) subscribeNext:^(id x) {
            @strongify(self);
            [self setBalance];
        }];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.coinKindLabel,text) = RACObserve(self.currencyKindLabel, text);
    [RACObserve(self.currencyKindLabel, text) subscribeNext:^(id x) {
        [self setBalance];
    }];
    
    [self regisClickFunction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)regisClickFunction {
    @weakify(self);
    [[self.currencyButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *array = [NSMutableArray array];
        
        for (WDAcceptance_CointypeDataModel *model  in self.viewModel.currencyArray) {
            [array addObject:model.cointyp];
        }
        
        NSArray *stringArray = @[@"CNY",@"BTC",@"USD"];
        
        [[UIViewController currentViewController] showPickerIndexViewWithArr:array andSelectStr:self.currencyKindLabel.text selectBolck:^(NSString *selectedString, NSInteger index) {
            CurrencyKind kind = [stringArray indexOfObject:array[index]];
            
            if (kind == NSNotFound) {
                kind = CurrencyKindBTC;
            }
            
            
            self.viewModel.selectedCurrencyIndex = index;
            self.viewModel.currencyKind = kind;
        }];
    }];
    
    
    [[self.cardButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
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
        
        @strongify(self);
        [[UIViewController currentViewController] showPickerIndexViewWithArr:array andSelectStr:self.currencyKindLabel.text selectBolck:^(NSString *selectedString, NSInteger index) {
            WDCoinTypeWayDataModel *model = self.viewModel.payStyleArray[index];
            SelectedPayKind kind = model.cointypeway;
            self.viewModel.selectedPayStyleKindIndex = index;
            self.viewModel.selectedStyleIndex = kind;
        }];
    }];
    
    [[self.submitButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel chongZhiActionWithSuccess:^{
            WDAcceptance_CointypeDataModel *dataModel = self.viewModel.currencyArray[self.viewModel.selectedCurrencyIndex];
            WDCoinTypeWayDataModel *wayModel = self.viewModel.payStyleArray[self.viewModel.selectedPayStyleKindIndex];
            
            NSString *url = wayModel.pic;
            NSString *titleName = dataModel.cointyp;
            NSString *name = wayModel.Name;
            NSString *bankName = wayModel.Bank;
            NSString *cardAccount = wayModel.Account;
            switch (self.viewModel.selectedStyleIndex) {
                case SelectedPayKindCNYCard:
                case SelectedPayKindUSDCard:
                    [WDShowChongZhiBankCardView showWithName:name bankName:bankName cardAccount:cardAccount clickClose:^{
                        
                    } clickConfirm:^{
                        
                    }];
                    break;
                case SelectedPayKindBTCWallet:
                case SelectedPayKindCNYAlipay:
                case SelectedPayKindCNYWeChat:{
                    [WDShowChongZhiQRCodeView showWithTitleName:titleName QRCodeKind:(QRCodeKind)self.viewModel.selectedStyleIndex imageUrl:url nameLabelText:cardAccount clickClose:^{
                        
                    }];
                    break;
                }
                default:
                    break;
            }
            
        } failture:^{
            
        }];
        
        
        
        
        
    }];
    
    [[self.assetsTextField rac_textSignal] subscribeNext:^(NSString *string) {
        @strongify(self);
        [self addLimitWithTextField:self.assetsTextField withCurrencyKind:(self.viewModel.currencyKind)];
        
        
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
