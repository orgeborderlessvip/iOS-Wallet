//
//  WDOrderTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDOrderTableViewCell.h"
#import "WDCustomButton.h"
@interface WDOrderTableViewCell ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bdsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bdsBTCLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseTimeButton;
@property (weak, nonatomic) IBOutlet WDCustomButton *cancelButton;

@end

@implementation WDOrderTableViewCell

- (void)languageSet {
    [_cancelButton setTitle:WDLocalizedString(@"取消") forState:(UIControlStateNormal)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self languageSet];
    _cancelButton.lineColor = _cancelButton.titleLabel.textColor;
    _cancelButton.lineWidth = 1;
    _cancelButton.cornerdius = 5;
    
    @weakify(self);
    
    [[_cancelButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock();
        }
    }];
}

- (void)setModel:(WDOrderTableDataModel *)model {
    _model = model;
    
    _priceLabel.text = model.price;
    _bdsLabel.text = model.coinAmount;
    _bdsBTCLabel.text = model.coinTotalAmount;
    _riseTimeButton.text = model.riseTime;
}

- (void)setRedColor:(BOOL)redColor {
    _redColor = redColor;
    
    UIColor *color = redColor?RGBColor(255,41,41,1):RGBColor(55,181,105,1);
    
    _priceLabel.textColor = color;
    _bdsLabel.textColor = color;
    _bdsBTCLabel.textColor = color;
    _riseTimeButton.textColor = color;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
