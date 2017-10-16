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
@interface WDBuy_SellBaseViewController ()<UIScrollViewDelegate,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet WDHeadView *headView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic,assign) BOOL userTouch;
@end

@implementation WDBuy_SellBaseViewController

- (void)languageSet {
    NSString *buy = WDLocalizedString(@"买入");
    NSString *sell = WDLocalizedString(@"卖出");
    NSString *order = WDLocalizedString(@"记录");
    NSString *history = WDLocalizedString(@"历史");
    NSString *tradeHistory = WDLocalizedString(@"全网交易历史");
    
    NSArray *array = @[buy,sell,order,history,tradeHistory];
    
    self.headView.lineColor = RGBColor(0, 144, 234, 1);
    
    self.headView.dataArray = array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToView:_topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:mainWidth];
    
    [self languageSet];
    
    NSInteger count = 5;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * count, 0);
    
    self.headView.titleFont = [UIFont systemFontOfSize:14];
    
    for (int i = 0; i < count; i ++) {
        UIViewController *vc = nil;
        if (i == 0 || i == 1) {
            WDBuy_SellViewController *realVC = [WDBuy_SellViewController new];
            
            realVC.isSell = i == 1;
            
            vc = realVC;
        }else if (i == 2) {
            WDOrderChildViewController *realVC = [WDOrderChildViewController new];
            
            vc = realVC;
        }else if (i == 3 || i == 4) {
            WDHistory_TradeHistoryViewController *realVC = [WDHistory_TradeHistoryViewController new];
            
            realVC.historyKind = i == 4?HistoryKindTradeHistory:HistoryKindHistory;
            
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
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.userTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headView setCenterPercent:scrollView.contentOffset.x / scrollView.contentSize.width withUsrSelected:self.userTouch];
    
    self.headView.selectedIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
