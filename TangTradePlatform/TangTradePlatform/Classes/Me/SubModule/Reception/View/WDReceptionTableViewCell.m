//
//  WDReceptionTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDReceptionTableViewCell.h"
#import "WDMeTransactionModel.h"
#import "WDNetworkManager.h"
@interface WDReceptionTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coinKindImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;


@end

@implementation WDReceptionTableViewCell

- (void)setModel:(WDMeTransactionModel *)model {
    _model = model;
    
    DLog(@"%@",[WDNetworkManager sharedInstance].userName);
    
    BOOL isIn = [model.to isEqualToString:[WDNetworkManager sharedInstance].userName];
    
    if (isIn) {
        _addressLabel.text = model.from;
        _amountLabel.textColor = RGBColor(252, 83, 83, 1);
    }else {
        _addressLabel.text = model.to;
        _amountLabel.textColor = RGBColor(0,228,177,1);
    }
    
    _amountLabel.text = model.amount;
    
    _coinKindImageView.image = [UIImage imageNamed:model.symbol];
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
