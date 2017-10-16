//
//  WDTiXianChildViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//


#import "WDChongZhiTiXianBaseViewModel.h"
@interface WDTiXianChildViewModel : WDChongZhiTiXianBaseViewModel

@property (nonatomic,copy) NSString *accountText;

@property (nonatomic,copy) NSString *bankText;

@property (nonatomic,copy) NSString *cardName;

- (void)tiXianActionWithSuccess:(void(^)())success failture:(void(^)())failture;

@end
