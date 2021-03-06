//
//  WDHomeTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDHomeTableViewCell.h"
#import "WDHomeTableDataModel.h"
@interface WDHomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *kindImageView;
@property (weak, nonatomic) IBOutlet UILabel *bdsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;

@end

@implementation WDHomeTableViewCell

- (void)setModel:(WDHomeTableDataModel *)model {
    _kindImageView.image = [UIImage imageNamed:model.coinName];
    
    _priceLabel.text = model.coinPrice;
    
    _kindLabel.text = model.coinName;
    
    if ([model.coinName isEqualToString:@"BDS"] || [model.coinName isEqualToString:@"BTC"]) {
        _bdsLabel.text = @"";
    }else {
        _bdsLabel.text = @"BDS";
        
        if ([model.coinName isEqualToString:@"CNY"]) {
            _imageHeight.constant = 26;
            _imageWidth.constant = 30;
        }else if ([model.coinName isEqualToString:@"ETH"]) {
            _imageHeight.constant = 32;
            _imageWidth.constant = 32;
        }else {
            _imageWidth.constant = 30;
            _imageHeight.constant = 30;
        }
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
