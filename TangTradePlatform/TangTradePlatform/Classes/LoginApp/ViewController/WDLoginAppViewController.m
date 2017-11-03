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
#import "SetInViewController.h"
@interface WDLoginAppViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (nonatomic,strong) WDLoginAppLoginView *loginView;
@property (nonatomic,strong) WDLoginAppDeleteView *deleteView;

@property (nonatomic,copy) NSString *fileName;

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
    
    UINavigationController *controller = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    BOOL jump = controller.viewControllers.lastObject != self;
    
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
    @weakify(self);
    [[login.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [WDBaseFileControl judgeWithPassword:login.passwordTextField.text withReturn:^(BOOL result) {
            if (result) {
                if (!jump) {
                    [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WDLogin_RegisterViewController new]];
                }else {
                    [self removeFromParentViewController];
                    [self.view removeFromSuperview];
                }
            }else {
                [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"钱包密码不正确,请重新输入" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                    self.loginView.passwordTextField.text = @"";
                    [self.loginView.passwordTextField becomeFirstResponder];
                }];
            }
        }];
    }];
    
    [[login.removeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        [self.backScrollView setContentOffset:CGPointMake(mainWidth, 0) animated:YES];
    }];
    
    [[login.chooseWalletButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self clearKeyBoard];
        
        [[UIViewController currentViewController] showPickerIndexViewWithUseLanguage:NO arr:[WDBaseFileControl getLocalWalletArray] andSelectStr:@"" selectBolck:^(NSString *selectedString, NSInteger index) {
            login.walletLabel.text = selectedString;
            
            [WDBaseFileControl loadLocalWithName:selectedString];
            
            [WDWalletManager setSelectedUserModel:nil];
            
            self.fileName = selectedString;
        }];
    }];
    
    [[login.importFileButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [[UIViewController currentViewController].navigationController pushViewController:[SetInViewController new] animated:YES];
    }];
    
    _loginView = login;
    
    WDLoginAppDeleteView *delete = [WDLoginAppDeleteView creatXib];
    
    [self.backScrollView addSubview:delete];
    
    [delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(login.mas_right).offset(margin * 2);
        make.centerY.mas_equalTo(_backScrollView.mas_centerY);
        make.width.mas_equalTo(width);
        make.right.mas_equalTo(_backScrollView.mas_right).offset(margin);
    }];
    
    [[delete.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [WDBaseFileControl deleteLocalWithName:self.fileName];
        
        if ([WDBaseFileControl haveLocal]) {
            [self.backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            
            [self loadBase];
        }else {
            [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WDLogin_RegisterViewController new]];
        }
    }];
    
    [[delete.cancleButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self.backScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    
    [_backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGRectGetHeight([UIScreen mainScreen].bounds));
    }];
    
    _deleteView = delete;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBase) name:@"URLActive" object:nil];
    
    DLog(@"%@",[WDWalletManager currecntConnectUrl]);
    
    if ([WDWalletManager currecntConnectUrl].length > 0) {
        [self loadBase];
    }
}

- (void)loadBase {
    NSArray *nameArray = [WDBaseFileControl getLocalWalletArray];
    
    if ([nameArray containsObject:baseFileName]) {
        self.loginView.walletLabel.text = baseFileName;
        
        self.fileName = baseFileName;
    }else {
        self.loginView.walletLabel.text = nameArray.firstObject;
        self.fileName = nameArray.firstObject;
    }
    
    [WDBaseFileControl loadLocalWithName:self.fileName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
