//
//  WDChengDuiRecordTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiRecordTableViewCell.h"

@interface WDChengDuiRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *paySupportLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinKindLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;


@end

@implementation WDChengDuiRecordTableViewCell

- (void)setModel:(WDChengDuiRecordDataModel *)model {
    _model = model;
    
    _paySupportLabel.text = model.paySupportName;
    _dateLabel.text = model.date;
    _amountLabel.text = model.amount;
    _coinKindLabel.text = model.coinKind;
    switch (model.paySupportKind) {
        case PaySupportKindComplete:
            _stateLabel.text = WDLocalizedString(@"完成");
            _stateLabel.textColor = RGBColor(40, 193, 20, 1);
            break;
        case PaySupportKindOther:
            _stateLabel.text = WDLocalizedString(@"未知");
            _stateLabel.textColor = RGBColor(255, 41, 41, 1);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
