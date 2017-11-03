//
//  WDChangeLanguageViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/28.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChangeLanguageViewController.h"
#import "WDLanguageTableViewCell.h"


@interface WDChangeLanguageViewController ()<UITableViewDataSource,UITableViewDelegate,UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topBarView;

@end

@implementation WDChangeLanguageViewController

- (void)languageSet {
    NSString *title  = WDLocalizedString(@"语言");
    
    _titleLabel.text = title;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"WDLanguageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    [[self.backButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self addChangeToView:_topBarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:CGRectGetWidth([UIScreen mainScreen].bounds)];
    
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDLanguageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"English";
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"简体中文";
    }else {
        cell.titleLabel.text = @"繁體中文";
    }
    
    cell.selectedImageView.hidden = indexPath.row != [WDInternationalCenter userLanguage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LanguageKind kind = indexPath.row;
    
    [WDInternationalCenter setUserlanguage:kind];
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
