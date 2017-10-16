//
//  WDLoginChildViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginChildViewController.h"
#import "WDLoginCardView.h"
#import "BaseTabBarViewController.h"
#import "SetInViewController.h"
@interface WDLoginChildViewController ()
@property (nonatomic,strong) WDLoginCardView *loginView;

@property (nonatomic,strong) WDLoginViewModel *loginViewModel;
@end

@implementation WDLoginChildViewController

- (void)loadView {
    [super loadView];
    
    _loginView = [WDLoginCardView creatXib];
    
    self.view = _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 20;
    
    self.view.layer.masksToBounds = YES;
    
    self.loginViewModel = [[WDLoginViewModel alloc] init];
    
    
    @weakify(self);
    
    [[self.loginView.registerButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self clearKeyBoard];
        
        UIScrollView *scroll =(UIScrollView *) self.view.superview.superview;
        
        [scroll setContentOffset:CGPointMake(CGRectGetWidth(scroll.frame), 0) animated:YES];
    }];
    
    [[self.loginView.importButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [[UIViewController currentViewController].navigationController pushViewController:[SetInViewController new] animated:YES];
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
