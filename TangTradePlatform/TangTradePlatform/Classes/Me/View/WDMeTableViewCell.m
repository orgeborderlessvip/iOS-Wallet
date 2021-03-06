//
//  WDMeTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDMeTableViewCell.h"
#import "WDMeTransactionModel.h"
#import "WDNetworkManager.h"
@interface WDMeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tradeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeKindLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coinImageView;
@end

@implementation WDMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
}

- (void)setModel:(WDMeTransactionModel *)model {
    _model = model;
    
    BOOL isIn = [model.to isEqualToString:[WDNetworkManager sharedInstance].userName];
    
    if (isIn) {
        _tradeNameLabel.text = model.from;
        _tradeKindLabel.text = WDLocalizedString(@"转入");
        _amountLabel.textColor = RGBColor(252, 83, 83, 1);
    }else {
        _tradeNameLabel.text = model.to;
        _tradeKindLabel.text = WDLocalizedString(@"转出");
        _amountLabel.textColor = RGBColor(0,228,177,1);
    }
    
    _amountLabel.text = model.amount;
    
    _coinImageView.image = [UIImage imageNamed:model.symbol];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
