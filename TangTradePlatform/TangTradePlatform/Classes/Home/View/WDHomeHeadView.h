//
//  WDHomeHeadView.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDHomeHeadViewModel.h"
@interface WDHomeHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *blockButton;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

- (void)bindViewModel:(WDHomeHeadViewModel *)viewModel;

@end
