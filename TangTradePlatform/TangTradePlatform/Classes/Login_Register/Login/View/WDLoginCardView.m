//
//  WDRegisterCardView.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLoginCardView.h"
#import "NSString+changeTest.h"
@interface WDLoginCardView ()<UserLanguageChange>



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *registerLabel;

@end

@implementation WDLoginCardView

- (void)languageSet {
    NSString *string = WDLocalizedString(@"选择账户");
    _titleLabel.text = string;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self languageSet];
}

@end
