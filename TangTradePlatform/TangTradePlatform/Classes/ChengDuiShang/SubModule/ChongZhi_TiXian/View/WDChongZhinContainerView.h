//
//  WDChongZhinContainerView.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDChongZhiTiXianBaseHeader.h"
@interface WDChongZhinContainerView : UIView

@property (nonatomic,assign) SelectedPayKind selectedKind;

@property (nonatomic,assign) CurrencyKind curreccyKind;

@property (weak, nonatomic) IBOutlet UIButton *styleButton;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardTextField;
- (void)clearText;

@end