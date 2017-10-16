//
//  WDSendOutViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDSendOutViewController.h"
#import "WDSendOutViewModel.h"
#import "NSString+changeTest.h"
#import "WDNetworkManager.h"
#import "ScanningViewController.h"
@interface WDSendOutViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIView *sendButtonBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *chargeLabel;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (nonatomic,copy) NSString *coinKind;
@property (nonatomic,assign) CGFloat haveAmount;

@property (nonatomic,strong) WDSendOutViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation WDSendOutViewController

- (void)languageSet {
    NSString *title = WDLocalizedString(@"付款");
    NSString *balance = WDLocalizedString(@"余额:");
    NSString *account = WDLocalizedString(@"账户:");
    NSString *amount = WDLocalizedString(@"数量:");
    _titleLabel.text = title;
    _balanceLabel.text = balance;
    _accountLabel.text = account;
    _amountLabel.text = amount;
    [_sendButton setTitle:title forState:(UIControlStateNormal)];
    NSString *head = WDLocalizedString(@"手续费: ");
    NSString *tail = WDLocalizedString(@" BDS");
    
    _chargeLabel.text = [NSString stringWithFormat:@"%@%@%@",head,@"",tail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[WDSendOutViewModel alloc] init];
    
//    _accountTextField.layer.cornerRadius = 5;
//    _accountTextField.layer.masksToBounds = YES;
//    _amountTextField.layer.cornerRadius = 5;
//    _amountTextField.layer.masksToBounds = YES;
    
    [self registerFunction];
    
    [self addChangeToView:_topBarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:CGRectGetWidth([UIScreen mainScreen].bounds)];
    CGFloat size_width = CGRectGetWidth([UIScreen mainScreen].bounds) * 0.66;
    
    [self addChangeToView:self.sendButtonBackGroundView withDirection:ChangeDirectionLeft_Right startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(0, 130, 226, 1) width:size_width];
    
    self.sendButtonBackGroundView.layer.cornerRadius = 5;
    self.sendButtonBackGroundView.layer.masksToBounds = YES;
    
    [self.viewModel loadMyAccountData];
}

- (void)registerFunction {
    @weakify(self);
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [RACObserve(self.viewModel, coinKind) subscribeNext:^(NSString *coinKind) {
        @strongify(self);
        self.coinKind = coinKind;
        self.kindLabel.text = [NSString stringWithFormat:@"%.5f %@",self.haveAmount,coinKind];
    }];
    
    [RACObserve(self.viewModel, haveAmount) subscribeNext:^(NSNumber *haveAmount) {
        @strongify(self);
        self.haveAmount = [haveAmount doubleValue];
        self.kindLabel.text = [NSString stringWithFormat:@"%.5f %@",self.haveAmount,self.coinKind];
    }];
    
    [RACObserve(self.viewModel, serviceCharge) subscribeNext:^(NSString *string) {
        if (string != nil) {
            NSString *head = WDLocalizedString(@"手续费: ");
            NSString *tail = WDLocalizedString(@" BDS");
            
            self.chargeLabel.text = [NSString stringWithFormat:@"%@%@%@",head,string,tail];
        }
    }];
    
    [RACObserve(self.viewModel, account) subscribeNext:^(NSString *string) {
        @strongify(self);
        string = [string changeTest];
        
        self.accountTextField.text = string;
    }];
    
    [[self.accountTextField rac_textSignal] subscribeNext:^(NSString *x) {
        @strongify(self);
        self.viewModel.account = x;
    }];
    
    [self.amountTextField.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self);
        text = [text stringByReplacingOccurrencesOfString:@"[^0-9/.]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, text.length)];
        
        text = [self changeString:text];
        
        self.amountTextField.text = text;
        
        self.viewModel.amount = text.doubleValue;
    }];
    
    [[self.sendButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        BOOL nameEnable = self.viewModel.account.length > 0;
        BOOL jinEnable = self.viewModel.haveAmount >= (self.viewModel.amount + self.viewModel.serviceCharge.doubleValue);
        BOOL jinETextEnable = self.amountTextField.text.doubleValue > 0;
        BOOL sameNameEnable = ![[WDNetworkManager sharedInstance].userName isEqualToString:self.viewModel.account];
        
        [self clearKeyBoard];
        
        if (nameEnable && jinEnable && sameNameEnable && jinETextEnable) {
            NSString *headString = WDLocalizedString(@"确认转账么?\n用户名:");
            NSString *tailString = WDLocalizedString(@"\n金额:");
            NSString *totalString = [NSString stringWithFormat:@"%@%@%@%.5f",headString,self.viewModel.account,tailString,self.viewModel.amount];
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:totalString withButtonTitle:@[@"取消",@"确定"] clickAction:^(NSInteger index, NSString *title) {
                if (index == 1) {
                    [self.viewModel sendPay];
                }
            }];
        }else {
            NSString *title = @"提示";
            NSString *message = nil;
            
            if (!jinETextEnable) {
                message = @"请输入金额";
            }
            
            if (!jinEnable) {
                message = @"余额不足";
            }
            if (!nameEnable) {
                message = @"用户名为空";
            }
            if (!sameNameEnable) {
                message = @"不能向自己转账";
            }
            
            NSString *confirm = @"确定";
            [UIAlertController showAlert:YES fromVC:self withTitle:title message:message withButtonTitle:@[confirm] clickAction:^(NSInteger index, NSString *title) {
            }];
        }
    }];
    
    /**
     发送成功回调

     @param enable 成功与否
     */
    [self.viewModel.sendSubject subscribeNext:^(NSArray *array) {
        @strongify(self);
        NSNumber *enable = array.firstObject;
        NSNumber *amountEnable = array.lastObject;
        
        BOOL realEnable = [enable boolValue];
        BOOL amount_enable = [amountEnable boolValue];
        
        NSString *title = realEnable?@"交易成功":@"交易失败";
        NSString *message = nil;
        if (!realEnable) {
            message = amount_enable?@"余额不足":@"该账户不存在";
        }
        
        NSString *confirm = @"确定";
        [UIAlertController showAlert:YES fromVC:self withTitle:title message:message withButtonTitle:@[confirm] clickAction:^(NSInteger index, NSString *title) {
            if (realEnable) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    } error:^(NSError *error) {
        @strongify(self);
        NSString *title = @"交易失败";
        NSString *message = @"网络连接失败,请稍后再试";
        NSString *confirm = @"确定";
        [UIAlertController showAlert:YES fromVC:self withTitle:title message:message withButtonTitle:@[confirm] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }];
    [[self.scanButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        ScanningViewController *vc = [ScanningViewController new];
        @weakify(vc);
        
        vc.CamacreString = ^(NSString *number) {
            @strongify(vc);
            self.viewModel.account = number;
            
            [vc dismissViewControllerAnimated:YES completion:nil];
        };
        
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (NSString *)changeString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByString:@"."];
    
    if (array.count < 2) return string;
    
    NSString *first = array[0];
    NSString *second = array[1];
    
    if (second.length > 5) {
        second = [second substringToIndex:5];
    }
    NSArray *realArray = @[first,second];
    
    return [realArray componentsJoinedByString:@"."];
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
