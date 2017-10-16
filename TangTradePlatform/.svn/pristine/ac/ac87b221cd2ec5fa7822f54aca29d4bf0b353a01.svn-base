//
//  WDChengDuiShangTableViewCell.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDChengDuiShangTableViewCell.h"
#import "WDShowSupportScrollView.h"
@interface WDChengDuiShangTableViewCell ()


/**
 头部视图（负责找到5个星星图片）
 */
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet WDShowSupportScrollView *paySupportView;

@property (weak, nonatomic) IBOutlet UILabel *paySupportLabel;
@property (weak, nonatomic) IBOutlet UILabel *payDetailLabel;


@end

@implementation WDChengDuiShangTableViewCell

- (void)setModel:(WDChengDuiShangTableDataModel *)model {
    _model = model;
    
    [RACObserve(model, paySupportArray) subscribeNext:^(id x) {
        if (model != _model) return;
        
        NSMutableArray *imageArray = [NSMutableArray array];
        
        for (NSString *string in model.paySupportArray) {
            [imageArray addObject:string];
        }
        
        _paySupportView.imageArray = imageArray;
    }];
    
    NSInteger index = model.paySupportRanking / 2;
    NSInteger shengYu = model.paySupportRanking % 2;
    //做星星
    for (int i = 1000; i < 1005; i ++) {
        UIImageView *imageView = [_headView viewWithTag:i];
        
        NSInteger realIndex = i - 1000;
        if (realIndex < index) {
            imageView.image = [UIImage imageNamed:@"ranking_full"];
        }else {
            if (shengYu == 1) {
                imageView.image = [UIImage imageNamed:@"ranking_half"];
                
                shengYu = 0;
            }else {
                imageView.image = [UIImage imageNamed:@"ranking_zero"];
            }
        }
    }
    
    _paySupportLabel.text = model.paySupportName;
    
    _payDetailLabel.text = model.paySupportDetail;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
