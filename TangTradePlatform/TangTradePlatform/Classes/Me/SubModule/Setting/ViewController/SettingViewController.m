//
//  SettingViewController.m
//  TangTradePlatform
//
//  Created by wanggang on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "SettingViewController.h"
#import "WDLogin_RegisterViewController.h"
#import "WDChangeLanguageViewController.h"
#import "WDVIPUpdateViewController.h"
#import "WDCheckUpdateViewController.h"
#import "WDBakUpViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginOutButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;


@property (nonatomic,strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation SettingViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"设置");
    
    self.dataSource = @[@[WDLocalizedString(@"会员升级"),WDLocalizedString(@"切换语言"),WDLocalizedString(@"检测新版本"),WDLocalizedString(@"备份")],@[WDLocalizedString(@"我的特权"),WDLocalizedString(@"创建账户")]].mutableCopy;
    [_loginOutButton setTitle:WDLocalizedString(@"退出登录") forState:(UIControlStateNormal)];
    _versionLabel.text = [NSString stringWithFormat:@"%@:%@",WDLocalizedString(@"当前版本"),({
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        app_Version;
    })];
    
    [self.tableView reloadData];
}

-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        
        self.dataSource = [NSMutableArray array];
        
    }
    
    return _dataSource;
}

- (NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        
        self.imageArray = [NSMutableArray array];
        
    }
    
    return _imageArray;
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    @weakify(self);
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)setUI{
    self.tableView.dataSource = self;
    
    self.tableView.delegate   = self;
 
    [self addChangeToView:self.headView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:[UIScreen mainScreen].bounds.size.width];
    
    self.tableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.scrollEnabled = NO;
    
    self.loginOutButton.layer.masksToBounds = YES;
    
    self.loginOutButton.layer.cornerRadius = 4;

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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";// 加static修饰重用字符串,可以提高速率
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  45;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return  20;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
//            [self presentViewController:langVC animated:YES completion:nil];
            [self.navigationController pushViewController:[WDChangeLanguageViewController new] animated:YES];
            
        }else if (indexPath.row == 0) {
            [self.navigationController pushViewController:[WDVIPUpdateViewController new] animated:YES];
        }else if (indexPath.row == 2) {
            [WDCheckUpdateViewController showWithUserCheck:YES];
        }else if (indexPath.row == 3) {
            [self.navigationController pushViewController:[WDBakUpViewController new] animated:YES];
        }
        
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[NSClassFromString(@"WDMyTeQuanViewController") new] animated:YES];
        }else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[NSClassFromString(@"WDCreatAccountViewController") new] animated:YES];
        }
    }
}

- (IBAction)clickedLoginButton:(UIButton *)sender {
    WDLogin_RegisterViewController *vc = [WDLogin_RegisterViewController new];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = vc;
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
