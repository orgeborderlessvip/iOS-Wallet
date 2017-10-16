//
//  WDLoginAppViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginAppViewController.h"
#import "WDLoginAppLoginView.h"
#import "WDLoginAppDeleteView.h"

#import "WDLogin_RegisterViewController.h"

#import "WDBaseFileControl.h"

#import "WDCustomButton.h"
@interface WDLoginAppViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@end

@implementation WDLoginAppViewController

+ (void)show {
    WDLoginAppViewController *vc = [WDLoginAppViewController new];
    
    [[UIViewController currentViewController] addChildViewController:vc];
    
    vc.view.frame = [UIScreen mainScreen].bounds;
    
    [[UIApplication sharedApplication].delegate.window addSubview:vc.view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WDBaseFileControl loadLocal];
    
    BOOL jump = [UIApplication sharedApplication].delegate.window.rootViewController != self;
    
    self.launchImageView.hidden = jump;
    
    WDLoginAppLoginView *login = [WDLoginAppLoginView creatXib];
    
    login.removeButton.hidden = jump;
    
    [self.backScrollView addSubview:login];
    
    CGFloat margin = mainWidth * 0.1;
    
    CGFloat width = mainWidth * 0.8;
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backScrollView).offset(margin);
        make.centerY.mas_equalTo(_backScrollView.mas_centerY);
        make.width.mas_equalTo(width);
    }];
    @weakify(login);
    [[login.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(login);
        [WDBaseFileControl judgeWithPassword:login.passwordTextField.text withReturn:^(BOOL result) {
            if (result) {
                if (!jump) {
                    [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WDLogin_RegisterViewController new]];
                }else {
                    [self removeFromParentViewController];
                    [self.view removeFromSuperview];
                }
            }
        }];
        
        
    }];
    
    [[login.removeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self.backScrollView setContentOffset:CGPointMake(mainWidth, 0) animated:YES];
    }];
    
    WDLoginAppDeleteView *delete = [WDLoginAppDeleteView creatXib];
    
    [self.backScrollView addSubview:delete];
    
    [delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(login.mas_right).offset(margin * 2);
        make.centerY.mas_equalTo(_backScrollView.mas_centerY);
        make.width.mas_equalTo(width);
        make.right.mas_equalTo(_backScrollView.mas_right).offset(margin);
    }];
    
    [[delete.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [WDBaseFileControl deleteLocal];
        
        [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WDLogin_RegisterViewController new]];
    }];
    
    [[delete.cancleButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self.backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    
    [_backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGRectGetHeight([UIScreen mainScreen].bounds));
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
