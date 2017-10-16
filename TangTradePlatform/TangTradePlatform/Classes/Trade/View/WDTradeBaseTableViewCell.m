//
//  WDTradeBaseTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDTradeBaseTableViewCell.h"

@interface WDTradeBaseTableViewCell ()<UserLanguageChange>
@property (weak, nonatomic) IBOutlet UIImageView *coinKindImageView;
@property (weak, nonatomic) IBOutlet UILabel *bdsHeadLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinKindLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinAmplitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestLabel;
@property (weak, nonatomic) IBOutlet UILabel *minimumLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnoverLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *minimumTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnoverTitleLabel;



@end

@implementation WDTradeBaseTableViewCell

- (void)languageSet {
    _highestTitleLabel.text = WDLocalizedString(@"最高买入价");
    _minimumTitleLabel.text = WDLocalizedString(@"最低卖出价");
    _volumeTitleLabel.text = WDLocalizedString(@"成交量");
    _turnoverTitleLabel.text = WDLocalizedString(@"成交");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    self.layer.cornerRadius = 10;
    
    self.layer.masksToBounds = YES;
    
    [self languageSet];
}

- (void)setModel:(WDTradeDataModel *)model {
    _model = model;
    
    _bdsHeadLabel.text = [_model.quote isEqualToString:@"BDS"]?@"":@"BDS";
    
    _coinKindLabel.text = _model.quote;
    
    _coinPriceLabel.text = [NSString stringWithFormat:@"%.5f",_model.latest];
    
    _coinAmplitudeLabel.textColor = _model.latest > _model.lowest_ask ? RGBColor(239, 41, 0, 1):[UIColor greenColor];
    
    _coinAmplitudeLabel.text = [NSString stringWithFormat:@"%@%.5f%%",_model.latest > _model.lowest_ask ? @"+":@"-",_model.rose];
    
    _highestLabel.text = [NSString stringWithFormat:@"%.5f",_model.highest_bid];
    
    _minimumLabel.text = [NSString stringWithFormat:@"%.5f",_model.lowest_ask];
    
    _volumeLabel.text = [NSString stringWithFormat:@"%.5f",_model.quote_volume];
    
    _turnoverLabel.text = [NSString stringWithFormat:@"%.5f",_model.rose];
}
@end