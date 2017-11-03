//
//  WDRegisterCardView.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDLoginViewModel.h"
@interface WDLoginCardView : UIView
@property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseWalletButton;
@property (weak, nonatomic) IBOutlet UIButton *changeWalletButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UIButton *importButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseServerButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *oldUserButton;

@end
