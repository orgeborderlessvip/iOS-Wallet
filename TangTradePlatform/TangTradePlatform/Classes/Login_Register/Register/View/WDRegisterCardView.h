//
//  WDRegisterCardView.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDRegisterViewModel.h"
@interface WDRegisterCardView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *tuiJianRenTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
- (void)bindViewModel:(WDRegisterViewModel *)viewModel;

@end
