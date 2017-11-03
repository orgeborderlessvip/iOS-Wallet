//
//  WDMeViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMeViewController.h"
#import "WDMeViewModel.h"
#import "WDMeTableViewCell.h"
#import "WDNetworkManager.h"
#import "WDReceptionViewController.h"
#import "WDSendOutViewController.h"
#import "SettingViewController.h"
#import "WDPrivateKeyViewController.h"

#import "WDChangeLanguageViewController.h"
#import "WDVIPUpdateViewController.h"
#import "WDCheckUpdateViewController.h"
#import "WDBakUpViewController.h"

#import "WDLogin_RegisterViewController.h"

#import "WDMyTradeRecordViewController.h"

typedef NS_ENUM(NSInteger,SelectedKind) {
    SelectedKindTradeRecord,
    SelectedKindVipUpgrade,
    SelectedKindMyKey,
    SelectedKindLanguage,
    SelectedKindBakup,
    SelectedKindCheckUpdate
};

@interface WDMeViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *receptionBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *receptionButton;
@property (weak, nonatomic) IBOutlet UIView *sendBackGroundView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *privateKeyButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quitHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (nonatomic,strong) WDMeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation WDMeViewController



- (void)languageSet {
    NSString *record = WDLocalizedString(@"交易记录");
    NSString *pay = WDLocalizedString(@"转出");
    NSString *recive = WDLocalizedString(@"转入");
    _recordLabel.text = record;
    [_sendButton setTitle:pay forState:(UIControlStateNormal)];
    [_receptionButton setTitle:recive forState:(UIControlStateNormal)];
    @weakify(self);
    [[_privateKeyButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController pushViewController:[WDPrivateKeyViewController new] animated:YES];
    }];
    
    
    self.dataSource = @[@[WDLocalizedString(@"转账记录"),WDLocalizedString(@"会员升级"),WDLocalizedString(@"我的秘钥"),WDLocalizedString(@"切换语言"),WDLocalizedString(@"备份"),WDLocalizedString(@"检测新版本")],@[WDLocalizedString(@"创建账户")]].mutableCopy;
    self.imageArray = @[@[@"trade_record",@"vip",@"key",@"language",@"bakup",@"check_update"],@[@"creat_account"]];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (CGRectGetWidth([UIScreen mainScreen].bounds) < 360) {
//        _quitHeight.constant = 24;
//        _topHeight.constant -= 8;
//    }
    
    _nameLabel.text = [WDNetworkManager sharedInstance].userName;
    
    _viewModel = [[WDMeViewModel alloc] init];
    
    CGFloat size_width = (CGRectGetWidth([UIScreen mainScreen].bounds) - 80) / 2;
    
    [self addChangeToView:self.receptionBackGroundView withDirection:ChangeDirectionLeft_Right startColor:RGBColor(255, 185, 74,1) endColor:RGBColor(243, 144, 2,1) width:size_width];
    
    self.receptionBackGroundView.layer.cornerRadius = 5;
    self.receptionBackGroundView.layer.masksToBounds = YES;
    
    [self addChangeToView:self.sendBackGroundView withDirection:ChangeDirectionLeft_Right startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(0, 130, 226, 1) width:size_width];
    
    self.sendBackGroundView.layer.cornerRadius = 5;
    self.sendBackGroundView.layer.masksToBounds = YES;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
//    [RACObserve(self.viewModel, dataArray) subscribeNext:^(id x) {
//        [self.tableView reloadData];
//    }];
//    [self.tableView registerNib:[UINib nibWithNibName:@"WDMeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 60;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 0)];
    
    self.tableView.tableFooterView.backgroundColor = RGBColor(246, 246, 246, 1);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    
    [self registerButtonAction];
}

- (void)registerButtonAction {
    @weakify(self)
    [[self.receptionButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController pushViewController:[WDReceptionViewController new] animated:YES];
    }];
    [[self.sendButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController pushViewController:[WDSendOutViewController new] animated:YES];
    }];
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WDLogin_RegisterViewController new]];
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";// 加static修饰重用字符串,可以提高速率
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *image = self.imageArray[indexPath.section][indexPath.row];
    
    cell.imageView.image = [self scaleToSize:[UIImage imageNamed:image] size:CGSizeMake(24, 24)];
    
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  50;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  16;
    }
    return 5;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return ((NSArray *)self.dataSource[section]).count;
        
    }else{
        return ((NSArray *)self.dataSource[section]).count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([WDWalletManager selectedModel].isLifeTime) {
        return self.dataSource.count;
    }
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        SelectedKind kind = indexPath.row;
        
        switch (kind) {
            case SelectedKindBakup:
                [self.navigationController pushViewController:[WDBakUpViewController new] animated:YES];
                break;
            case SelectedKindMyKey:
                [self.navigationController pushViewController:[WDPrivateKeyViewController new] animated:YES];
                break;
            case SelectedKindLanguage:
                [self.navigationController pushViewController:[WDChangeLanguageViewController new] animated:YES];
                break;
            case SelectedKindVipUpgrade:
                [self.navigationController pushViewController:[WDVIPUpdateViewController new] animated:YES];
                break;
            case SelectedKindCheckUpdate:
                [WDCheckUpdateViewController showWithUserCheck:YES];
                break;
            case SelectedKindTradeRecord:
                [self.navigationController pushViewController:[WDMyTradeRecordViewController new] animated:YES];
                break;
            default:
                break;
        }
        
//        if (indexPath.row == 1) {
//            //            [self presentViewController:langVC animated:YES completion:nil];
//            [self.navigationController pushViewController:[WDChangeLanguageViewController new] animated:YES];
//            
//        }else if (indexPath.row == 0) {
//            [self.navigationController pushViewController:[WDVIPUpdateViewController new] animated:YES];
//        }else if (indexPath.row == 2) {
//            [WDCheckUpdateViewController showWithUserCheck:YES];
//        }else if (indexPath.row == 3) {
//            [self.navigationController pushViewController:[WDBakUpViewController new] animated:YES];
//        }
        
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[NSClassFromString(@"WDCreatAccountViewController") new] animated:YES];
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(newsize,NO,0.f);
    //    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.model = self.viewModel.dataArray[indexPath.row];
    
    return cell;
}*/

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
