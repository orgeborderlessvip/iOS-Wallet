//
//  WDPingTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/19.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDPingTableViewCell.h"
#import "WDCircleView.h"
#import "WDPingModel.h"
@interface WDPingTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yanChiLabel;
@property (weak, nonatomic) IBOutlet WDCircleView *circleView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseLabel;

@end

@implementation WDPingTableViewCell

- (void)setModel:(WDPingModel *)model {
    _model = model;
    if (model.ping <CGFLOAT_MAX) {
        if (model.ping > 150) {
            _circleView.circleColor = RGBColor(239, 44, 71, 1);
        }else if (model.ping <= 150 && model.ping >= 60) {
            _circleView.circleColor = RGBColor(247, 180, 24, 1);
        }else {
            _circleView.circleColor = RGBColor(66, 210, 116, 1);
        }
        _nameLabel.textColor = [UIColor blackColor];
        _yanChiLabel.text = [NSString stringWithFormat:@"%.0fms",model.ping];
        _yanChiLabel.textColor = [UIColor blackColor];
    }else {
        _nameLabel.textColor = RGBColor(198, 198, 198, 1);
        _yanChiLabel.textColor = RGBColor(198, 198, 198, 1);
        _yanChiLabel.text = @"-";
        _circleView.circleColor = RGBColor(178, 178, 178, 1);
    }
    
    _nameLabel.text = model.baseSockUrl;
    
    _chooseLabel.hidden = !model.selected;
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
