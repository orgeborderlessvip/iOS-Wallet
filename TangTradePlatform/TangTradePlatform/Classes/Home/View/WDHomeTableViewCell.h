//
//  WDHomeTableViewCell.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDHomeTableDataModel;
@interface WDHomeTableViewCell : UITableViewCell

@property (nonatomic,weak) WDHomeTableDataModel *model;
@property (weak, nonatomic) IBOutlet UIView *headLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end
