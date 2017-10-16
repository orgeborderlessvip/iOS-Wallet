//
//  WDBlockTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBlockTableViewCell.h"
#import "WDBlockTableDataModel.h"
@interface WDBlockTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *blockIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionLabel;


@end

@implementation WDBlockTableViewCell

- (void)setDataModel:(WDBlockTableDataModel *)model {
    _blockIDLabel.text = model.blocknumber;
    _dateLabel.text = model.time;
    _detailLabel.text = model.witness;
    _transactionLabel.text = model.exchangecount;
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
