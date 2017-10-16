//
//  WDHomeHeadView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHomeHeadView.h"

@interface WDHomeHeadView ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *wealthLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetsLabel;

@end

@implementation WDHomeHeadView

- (void)languageSet {
    NSString *wealth = WDLocalizedString(@"我的财产");
    NSString *assets = WDLocalizedString(@"总资产(BDS)");
    _wealthLabel.text = wealth;
    _assetsLabel.text = assets;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageSet) name:changeLanguageNotification object:nil];
    
    [self languageSet];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)bindViewModel:(WDHomeHeadViewModel *)viewModel {
    
}


@end
