//
//  WDOrderTableViewCell.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDOrderTableDataModel.h"
@interface WDOrderTableViewCell : UITableViewCell

@property (nonatomic,weak) WDOrderTableDataModel *model;

@property (nonatomic,assign) BOOL redColor;

@property (nonatomic,copy) void (^clickBlock) ();

@end
