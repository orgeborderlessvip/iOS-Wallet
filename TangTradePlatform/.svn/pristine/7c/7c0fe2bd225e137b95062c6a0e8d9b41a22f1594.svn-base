//
//  WDOrderSelectionView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOrderSelectionView.h"

@interface WDOrderSelectionView ()<UserLanguageChange>

@property (weak, nonatomic) IBOutlet UIImageView *buyImageView;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIImageView *sellImageView;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UIButton *sellButton;


@end

@implementation WDOrderSelectionView

- (void)languageSet {
    _buyLabel.text = WDLocalizedString(@"买入");
    _sellLabel.text = WDLocalizedString(@"卖出");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
    self.selectedView = 0;
    
    @weakify(self);
    
    [[self.buyButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        self.selectedView = 0;
        self.buyImageView.image = [UIImage imageNamed:@"selected_true"];
        self.sellImageView.image = [UIImage imageNamed:@"selected_false"];
    }];
    
    [[self.sellButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        self.selectedView = 1;
        self.sellImageView.image = [UIImage imageNamed:@"selected_true"];
        self.buyImageView.image = [UIImage imageNamed:@"selected_false"];
    }];
}

@end
