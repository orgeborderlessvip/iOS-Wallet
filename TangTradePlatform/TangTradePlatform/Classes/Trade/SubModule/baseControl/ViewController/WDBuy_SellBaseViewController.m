//
//  WDBuy_SellBaseViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBuy_SellBaseViewController.h"
#import "WDHeadView.h"
#import "WDBuy_SellViewController.h"
#import "WDOrderChildViewController.h"
#import "WDHistory_TradeHistoryViewController.h"

#import "WDKlineWebViewController.h"
@interface WDBuy_SellBaseViewController ()<UIScrollViewDelegate,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet WDHeadView *headView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *kLineButton;

@property (nonatomic,assign) BOOL userTouch;

@property (nonatomic,strong) WDHomeTableDataModel *baseData;
@property (nonatomic,strong) WDHomeTableDataModel *quetoData;

@property (nonatomic,assign) NSInteger totalShow;

@end

@implementation WDBuy_SellBaseViewController

- (void)languageSet {
    NSString *buy = WDLocalizedString(@"买入");
    NSString *sell = WDLocalizedString(@"卖出");
    NSString *order = WDLocalizedString(@"委托");
    NSString *history = WDLocalizedString(@"我的交易");
    NSString *tradeHistory = WDLocalizedString(@"交易历史");
    
    NSArray *array = @[buy,sell,order,history,tradeHistory];
    
    self.headView.lineColor = RGBColor(0, 144, 234, 1);
    
    self.headView.dataArray = array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToView:_topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:mainWidth];
    
    [self languageSet];
    
    [[self class] setWithBase:self.quetoCoin quote:self.baseCoin withMinString:@":" toLabel:self.titleLabel withFont:[UIFont systemFontOfSize:19] toFont:[UIFont systemFontOfSize:13]];
    
    NSInteger count = 5;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * count, 0);
    
    self.headView.titleFont = [UIFont systemFontOfSize:14];
    
    for (int i = 0; i < count; i ++) {
        UIViewController *vc = nil;
        if (i == 0 || i == 1) {
            WDBuy_SellViewController *realVC = [WDBuy_SellViewController new];
            
            realVC.baseCoin = self.baseCoin;
            
            realVC.quetoCoin = self.quetoCoin;
            
            realVC.isSell = i == 1;
            
            vc = realVC;
        }else if (i == 2) {
            WDOrderChildViewController *realVC = [WDOrderChildViewController new];
            
            realVC.baseCoin = self.baseCoin;
            
            realVC.quetoCoin = self.quetoCoin;
            
            vc = realVC;
        }else if (i == 3 || i == 4) {
            WDHistory_TradeHistoryViewController *realVC = [WDHistory_TradeHistoryViewController new];
            
            realVC.historyKind = i == 4?HistoryKindTradeHistory:HistoryKindHistory;
            
            realVC.baseCoin = self.baseCoin;
            
            realVC.quetoCoin = self.quetoCoin;
            
            vc = realVC;
        }
        if (vc) {
            [self.scrollView addSubview:vc.view];
            [self addChildViewController:vc];
        }
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (i == 1 || i == 0) {
                vc.view.frame = CGRectMake(i * mainWidth + 8, 8, mainWidth - 16, CGRectGetHeight(self.scrollView.frame) - 8);
            }else {
                vc.view.frame = CGRectMake(i * mainWidth, 8, mainWidth, CGRectGetHeight(self.scrollView.frame) - 8);
            }
        });
    }
    
    self.scrollView.delegate = self;
    
    @weakify(self);
    self.headView.touchBlock = ^(NSInteger selectedIndex) {
        @strongify(self);
        
        self.userTouch = YES;
        
        [self.scrollView setContentOffset:CGPointMake(selectedIndex * self.scrollView.bounds.size.width, 0) animated:YES];
    };
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.kLineButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController pushViewController:[WDKlineWebViewController new] animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [(WDBuy_SellViewController *)self.childViewControllers[_totalShow] getAllData];
}

- (void)setQuetoCoin:(NSString *)quetoCoin {
    _quetoCoin = quetoCoin;
    
    for (WDHistory_TradeHistoryViewController *vc in self.childViewControllers) {
        vc.quetoCoin = quetoCoin;
    }
}

- (void)changeQueto {
    [self clearKeyBoard];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray];
    
    [array removeObject:self.baseCoin];
    
    [[UIViewController currentViewController] showPickerIndexViewWithUseLanguage:NO arr:array andSelectStr:@"" selectBolck:^(NSString *selectedString, NSInteger index) {
        self.quetoCoin = selectedString;
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.userTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headView setCenterPercent:scrollView.contentOffset.x / scrollView.contentSize.width withUsrSelected:self.userTouch];
    
    self.headView.selectedIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    WDBuy_SellViewController *childVC = self.childViewControllers[index];
    
    if (_totalShow != index) {
        [childVC getAllData];
        _totalShow = index;
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    WDBuy_SellViewController *childVC = self.childViewControllers[index];
    
    if (_totalShow != index) {
        [childVC getAllData];
        _totalShow = index;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
