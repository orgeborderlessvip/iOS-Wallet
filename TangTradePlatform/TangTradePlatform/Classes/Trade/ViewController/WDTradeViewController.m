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
    
    [RACObserve(self.viewModel, dataArray) subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        self.headView.dataArray = dataArray;
        
        for (UIViewController *vc in self.childViewControllers) {
            [vc.view removeFromSuperview];
            [vc removeFromParentViewController];
        }
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) * dataArray.count, self.scrollView.frame.size.height);
        
        for (int i = 0; i < dataArray.count; i ++) {
            WDTradeChildViewController *childVC = [WDTradeChildViewController new];
            
            [childVC setDataArray:dataArray index:i];
            
            [self.scrollView addSubview:childVC.view];
            
            CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
            
            CGFloat margin = 8;
            
            childVC.view.frame = CGRectMake(i * width + margin, 0, width - margin * 2, CGRectGetHeight(self.scrollView.frame));
        
            [self addChildViewController:childVC];
        }
        
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    
    self.headView.touchBlock = ^(NSInteger selectedIndex) {
        @strongify(self);
        
        self.userTouch = YES;
        
        [self.scrollView setContentOffset:CGPointMake(selectedIndex * self.scrollView.bounds.size.width, 0) animated:YES];
    };
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
