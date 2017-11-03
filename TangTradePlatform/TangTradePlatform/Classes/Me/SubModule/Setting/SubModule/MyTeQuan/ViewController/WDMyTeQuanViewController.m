//
//  WDMyTeQuanViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMyTeQuanViewController.h"
#import "UIImage+QRCode.h"

#import <AssetsLibrary/AssetsLibrary.h>
@interface WDMyTeQuanViewController ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *clicpButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation WDMyTeQuanViewController

- (void)languageSet {
    _titleLabel.text = WDLocalizedString(@"我的特权");
    [_clicpButton setTitle:WDLocalizedString(@"复制") forState:(UIControlStateNormal)];
    [_saveButton setTitle:WDLocalizedString(@"保存图片到相册") forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChangeToHeadView:_topbarView];
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.qrcodeImageView.image = [UIImage qrcodeFromString:[WDWalletManager selectedModel].name withSize:CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5 - 16];
    self.detailLabel.text = [WDWalletManager selectedModel].name;
    @weakify(self);
    [[self.clicpButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:[WDWalletManager selectedModel].name];
        
        [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"已经复制到剪切板" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }];
    
    [[self.saveButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        __block ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib writeImageToSavedPhotosAlbum:self.qrcodeImageView.image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            
            NSLog(@"assetURL = %@, error = %@", assetURL, error);
            lib = nil;
            NSString *msg = nil;
            if (!error) {
                msg = @"图片保存成功";
            }else {
                msg = @"图片保存失败";
            }
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:msg withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                
            }];
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
