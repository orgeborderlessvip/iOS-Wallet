//
//  WDMeTableViewCell.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDMeTransactionModel;
@interface WDMeTableViewCell : UITableViewCell
@property (nonatomic,weak) WDMeTransactionModel *model;
@end
