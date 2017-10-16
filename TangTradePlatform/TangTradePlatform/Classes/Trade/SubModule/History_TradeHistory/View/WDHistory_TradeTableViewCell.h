//
//  WDHistory_TradeTableViewCell.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDHistory_TradeHistoryDataModel.h"
@interface WDHistory_TradeTableViewCell : UITableViewCell

@property (nonatomic,weak) WDHistory_TradeHistoryDataModel *model;

@property (nonatomic,strong) UIColor *textColor;

@end
