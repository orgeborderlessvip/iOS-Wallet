//
//  SetInViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "SetInViewController.h"
#import "WDBaseFileControl.h"
@interface SetInViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedFileButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic,copy) NSString *fileName;

@end

@implementation SetInViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"导入");
    _fileNameLabel.text = [NSString stringWithFormat:@"%@:",WDLocalizedString(@"导入文件")];
    [_selectedFileButton setTitle:WDLocalizedString(@"选择文件") forState:(UIControlStateNormal)];
    
    [_confirmButton setTitle:WDLocalizedString(@"确定") forState:(UIControlStateNormal)];
}


- (void)setFileName:(NSString *)fileName {
    _fileName = fileName;
    
    _fileNameLabel.text = [NSString stringWithFormat:@"%@:%@",WDLocalizedString(@"导入文件"),fileName];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToView:_topbarView withDirection:ChangeDirectionUp_Down startColor:RGBColor(68, 168, 255, 1) endColor:RGBColor(25, 131, 209, 1) width:CGRectGetWidth([UIScreen mainScreen].bounds)];
    
    @weakify(self);
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [[self.selectedFileButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        NSArray *array = [WDBaseFileControl getBakUpDataName];
        
        if (!array.count) {
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"没有备份文件" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
            return;
        }
        
        [self showPickerIndexViewWithArr:[WDBaseFileControl getBakUpDataName] andSelectStr:@"" selectBolck:^(NSString *selectedString, NSInteger index) {
            self.fileName = selectedString;
        }];
    }];
    
    [[self.confirmButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        if (self.fileName) {
            [WDBaseFileControl loadBakUpFromName:self.fileName withSuccess:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else {
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"请选择备份文件" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
        }
        
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
