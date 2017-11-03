//
//  WDTradeViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTradeViewController.h"

#import "WDHeadView.h"
#import "WDTradeViewModel.h"
#import "WDTradeChildViewController.h"
@interface WDTradeViewController ()<UIScrollViewDelegate,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet WDHeadView *headView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) NSMutableArray *vcArray;

@property (nonatomic,strong) WDTradeViewModel *viewModel;

@property (nonatomic,assign) BOOL userTouch;

@property (nonatomic,assign) NSInteger totalShow;

@end

@implementation WDTradeViewController

- (void)languageSet {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToView:_topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:CGRectGetWidth([UIScreen mainScreen].bounds)];
    
    _titleLabel.text = WDLocalizedString(_titleLabel.text);
    
    self.headView.lineColor = RGBColor(0, 144, 234, 1);
    
    self.viewModel = [[WDTradeViewModel alloc] init];
    
    _scrollView.delegate = self;
    
    @weakify(self);

    self.headView.dataArray = @[@"USD",@"CNY"];
    
    self.headView.titleFont = [UIFont systemFontOfSize:17];
    self.headView.showSymbol = YES;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * self.headView.dataArray.count, self.scrollView.frame.size.height);
    
    for (int i = 0; i < self.headView.dataArray.count; i ++) {
        WDTradeChildViewController *childVC = [WDTradeChildViewController new];
        
        [self.scrollView addSubview:childVC.view];
        [self addChildViewController:childVC];
        
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        
        CGFloat margin = 8;
        
        childVC.view.frame = CGRectMake(i * width + margin, 0, width - margin * 2, CGRectGetHeight(self.scrollView.frame));
        
        
    }
    
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [RACObserve(self.viewModel, dataArray) subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        
        if (dataArray == nil) return;
        
        for (int i = 0; i < self.headView.dataArray.count; i ++) {
            WDTradeChildViewController *child = self.childViewControllers[i];
            
            [child setAllInfoArray:self.viewModel.allInfoArray DataArray:self.viewModel.dataArray index:i];
            
            if (i == _totalShow) {
                [child load];
            }
        }
    }];
    
    self.headView.touchBlock = ^(NSInteger selectedIndex) {
        @strongify(self);
        
        self.userTouch = YES;
        
        [self.scrollView setContentOffset:CGPointMake(selectedIndex * self.scrollView.bounds.size.width, 0) animated:YES];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.viewModel.dataArray) return;
    
    WDTradeChildViewController *childVC = self.childViewControllers[_totalShow];
    
    [childVC load];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat margin = 8;
    
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        WDTradeChildViewController *vc = self.childViewControllers[i];
        
        vc.view.frame = CGRectMake(i * width + margin, 0, width - margin * 2, CGRectGetHeight(self.scrollView.frame));
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.userTouch = NO;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    WDTradeChildViewController *childVC = self.childViewControllers[index];
    
    if (_totalShow != index) {
        [childVC load];
        _totalShow = index;
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    WDTradeChildViewController *childVC = self.childViewControllers[index];
    
    if (_totalShow != index) {
        [childVC load];
        _totalShow = index;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headView setCenterPercent:scrollView.contentOffset.x / scrollView.contentSize.width withUsrSelected:self.userTouch];
    
    self.headView.selectedIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
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
