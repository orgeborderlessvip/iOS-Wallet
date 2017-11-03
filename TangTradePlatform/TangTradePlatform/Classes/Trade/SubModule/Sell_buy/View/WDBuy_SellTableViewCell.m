//
//  WDBuy_SellTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBuy_SellTableViewCell.h"

@interface WDBuy_SellTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *GMVLabel;

@end

@implementation WDBuy_SellTableViewCell

- (void)setModel:(WDBuy_SellTableDataModel *)model {
    if (model.isSell) {
        _typeLabel.textColor = RGBColor(255, 41, 41, 1);
        _typeLabel.text = [NSString stringWithFormat:@"%@%ld",WDLocalizedString(@"卖"),model.count];
    }else {
        _typeLabel.text = [NSString stringWithFormat:@"%@%ld",WDLocalizedString(@"买"),model.count];
        _typeLabel.textColor = RGBColor(55, 181, 105, 1);
    }
    
    _priceLabel.text = model.price;
    
    _amountLabel.text = model.amount;
    
    _GMVLabel.text = model.GMV;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
