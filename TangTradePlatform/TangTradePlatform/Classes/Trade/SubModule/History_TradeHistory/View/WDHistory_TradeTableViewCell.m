//
//  WDHistory_TradeTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHistory_TradeTableViewCell.h"

@interface WDHistory_TradeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *btcLabel;
@property (weak, nonatomic) IBOutlet UILabel *bsdBTCLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseTimeLabel;


@end

@implementation WDHistory_TradeTableViewCell

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    _priceLabel.textColor = textColor;
    _btcLabel.textColor = textColor;
    _bsdBTCLabel.textColor = textColor;
    _riseTimeLabel.textColor = textColor;
}

- (void)setModel:(WDHistory_TradeHistoryDataModel *)model {
    _model = model;
    
    _priceLabel.text = model.price;
    _btcLabel.text = model.value;
    _bsdBTCLabel.text = model.amount;
    _riseTimeLabel.text = model.date;
    
    if (model.isCurrentKind) {
        [self setTextColor:!model.isSell?RGBColor(255,41,41,1):RGBColor(55,181,105,1)];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
