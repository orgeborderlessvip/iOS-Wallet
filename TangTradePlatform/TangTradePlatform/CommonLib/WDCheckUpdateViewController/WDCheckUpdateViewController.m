//
//  WDCheckUpdateViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/25.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDCheckUpdateViewController.h"

#import "WDCustomButton.h"
#import "WDNetworkManager.h"


@interface WDCheckUpdateViewController ()

@property (nonatomic,strong) WDCheckUpdateModel *model;

@property (nonatomic,strong) NSMutableArray *viewArray;

@property (nonatomic,assign) BOOL userCheck;

@end

@implementation WDCheckUpdateViewController

+ (void)showWithModel:(WDCheckUpdateModel *)model userCheck:(BOOL)check{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    NSString *key = [NSString stringWithFormat:@"update %@",model.iosversion];
    NSNumber *obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (!model.needUpdate && check) {
        [UIAlertController showAlert:YES fromVC:[UIViewController currentViewController] withTitle:@"提示" message:@"当前已是最新版本" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
        
        return;
    }
    
    if (!check) {
        if ([obj boolValue] && !model.status) return;
        if ([window viewWithTag:21985]) return;
        if (!model.needUpdate) return;
    }

    WDCheckUpdateViewController *vc = [[self alloc] initWithModel:model check:check];
    vc.view.tag = 21985;    
    [window addSubview:vc.view];
    
    [[UIViewController currentViewController] addChildViewController:vc];
}

+ (void)showWithUserCheck:(BOOL)check {
    if (check) {
        [[UIViewController currentViewController] showHuDwith:@"加载中"];
    }
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [[WDNetworkManager sharedInstance] checkUpdateWithSuccess:^(id result) {
        [[UIViewController currentViewController] hidenHUD];
        WDCheckUpdateModel *model = [WDCheckUpdateModel modelToDic:result];
        
        CGFloat time = check?0:2;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WDCheckUpdateViewController showWithModel:model userCheck:check];
        });
    } error:^{
        if (check) {
            [[UIViewController currentViewController] showHuDwith:@"网络连接失败,请稍后再试" duration:1];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showWithUserCheck:NO];
            });
        }
        
        
    }];
}

- (instancetype)initWithModel:(WDCheckUpdateModel *)model check:(BOOL)check{
    if (self = [super init]) {
        _model = model;
        _userCheck = check;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewArray = [NSMutableArray array];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    NSString *content = _model.contents;
    
    switch ([WDInternationalCenter userLanguage]) {
        case LanguageKindEN:
            content = _model.contents;
            break;
        case LanguageKindCNS:
            content = _model.contents_cn;
            break;
        case LanguageKindCNT:
            content = _model.contents_tw;
            break;
    }
    
    NSMutableArray *dataArray = [[content componentsSeparatedByString:@"\n"] mutableCopy];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    backView.layer.cornerRadius = 15;
    backView.layer.masksToBounds = YES;
    
    UIView *iconBackView = [[UIView alloc] init];
    [backView addSubview:iconBackView];
    [iconBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView).offset(24);
        make.centerX.equalTo(backView.mas_centerX);
        make.width.height.mas_equalTo(50);
    }];
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"Logo"];
    iconImageView.layer.cornerRadius = 15;
    iconImageView.layer.masksToBounds = YES;
    [iconBackView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(iconBackView);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = WDLocalizedString(@"版本更新");
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = RGBColor(28, 69, 91, 1);
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconBackView.mas_bottom).offset(16);
        make.centerX.mas_equalTo(backView.mas_centerX);
    }];
    for (int i = 0; i < dataArray.count; i ++) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = dataArray[i];
        textLabel.numberOfLines = 0;
        textLabel.textColor = label.textColor;
        [backView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(backView).offset(16);
            
            make.right.mas_equalTo(backView).offset(-16);
            
            UIView *lastView = i != 0?_viewArray.lastObject:label;
            
            CGFloat height = i != 0?6:16;
            
            make.top.mas_equalTo(lastView.mas_bottom).offset(height);
        }];
        [_viewArray addObject:textLabel];
    }
    
    UIView *bottomButtonView = [[UIView alloc] init];
    
    [backView addSubview:bottomButtonView];
    
    [bottomButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *lastView = _viewArray.lastObject;
        
        make.top.mas_equalTo(lastView.mas_bottom).offset(16);
        make.left.mas_equalTo(backView).offset(16);
        make.right.bottom.mas_equalTo(backView).offset(-16);
        make.height.mas_equalTo(40);
    }];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.75);
    }];
    
    
    
    if (_model.status) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        NSString *confirm = WDLocalizedString(@"升级");
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:confirm forState:(UIControlStateNormal)];
        
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
    
        button.backgroundColor = RGBColor(0, 146, 214, 1);
        
        [bottomButtonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(bottomButtonView);
        }];
        
        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.iosurl]];
            
            [self close];
        }];
    }else {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        NSString *confirm = WDLocalizedString(@"升级");
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:confirm forState:(UIControlStateNormal)];
        
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        
        button.backgroundColor = RGBColor(0, 146, 214, 1);
        
        [bottomButtonView addSubview:button];
        
        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.iosurl]];
            
            [self close];
        }];
        
        WDCustomButton *cancelButton = [[WDCustomButton alloc] init];
        
        cancelButton.lineColor = RGBColor(153, 153, 153, 1);
        
        [cancelButton setTitleColor:cancelButton.lineColor forState:(UIControlStateNormal)];
        
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        cancelButton.titleLabel.numberOfLines = 0;
        
        NSString *string = WDLocalizedString(@"不再提示");
        
        if (self.userCheck) {
            string = WDLocalizedString(@"关闭");
        }
        
        cancelButton.lineWidth = 1;
        
        cancelButton.cornerdius = 5;
        
        [cancelButton setTitle:string forState:(UIControlStateNormal)];
        
        [bottomButtonView addSubview:cancelButton];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(bottomButtonView);
            make.width.mas_equalTo(cancelButton);
            make.right.mas_equalTo(cancelButton.mas_left).offset(-16);
        }];
        
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(bottomButtonView);
        }];
        
        [[cancelButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            if (!self.userCheck) {
                [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:[NSString stringWithFormat:@"update %@",self.model.iosversion]];
            }
            
            [self close];
        }];
    }
}

- (void)close {
    [self.view removeFromSuperview];
    
    [self removeFromParentViewController];
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
