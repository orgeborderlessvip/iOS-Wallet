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
    _btcLabel.text = model.amount;
    _bsdBTCLabel.text = model.value;
    _riseTimeLabel.text = model.date;
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
