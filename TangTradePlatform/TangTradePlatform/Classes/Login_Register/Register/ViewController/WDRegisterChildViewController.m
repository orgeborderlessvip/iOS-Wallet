//
//  WDRegisterChildViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDRegisterChildViewController.h"
#import "WDRegisterCardView.h"
#import "WDAttentionView.h"
#import "NSString+changeTest.h"
@interface WDRegisterChildViewController ()
@property (nonatomic,strong) WDRegisterCardView *cardView;

@property (nonatomic,strong) WDRegisterViewModel *viewModel;

@property (nonatomic,strong) WDAttentionView *attentionView;

@end

@implementation WDRegisterChildViewController

- (void)loadView {
    [super loadView];
    
    _cardView = [WDRegisterCardView creatXib];
    
    self.view = _cardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.shadowColor = RGBColor(227, 227, 227, 1).CGColor;
    
    self.view.layer.cornerRadius = 20;
    
    self.view.layer.shadowOpacity = 0.8f;
    
    self.view.layer.masksToBounds = YES;
    
    self.view.layer.shadowRadius = 5;
    
    self.view.layer.shadowOffset = CGSizeMake(0,0);
    
//    _attentionView = [WDAttentionView creatXib];
//    
//    [self.view addSubview:_attentionView];
    
//    _attentionView.hidden = YES;
    
//    [_attentionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.mas_equalTo(self.view);
//    }];
    
    _viewModel = [[WDRegisterViewModel alloc] init];
    
    [_cardView bindViewModel:_viewModel];
    
//    [_attentionView bindModel:_viewModel];
    
    @weakify(self);
    
//    [[_attentionView.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
//        
//    }];
    
    [[_cardView.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self clearKeyBoard];
        UIScrollView *scroll =(UIScrollView *)self.view.superview.superview;
        
        [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [self.viewModel clear];
//        6-16位非元音字母数字组合
        self.cardView.showLabel.text = @"";
    }];
    
    [[_cardView.registerButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        self.cardView.showLabel.text = @"";
        
        [self.viewModel registerWithSuccess:^{
            [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"注册成功" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                UIScrollView *scroll =(UIScrollView *)self.view.superview.superview;
                
                [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
                
                [self.viewModel clear];
            }];
        } failture:^(NSString *msg) {
            self.cardView.showLabel.text = msg;
        } error:^{
            
        }];
        
    }];
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
