//
//  WDVipUpdateViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDVipUpdateViewModel : NSObject

@property (nonatomic,assign) CGFloat updateFee;

@property (nonatomic,assign) CGFloat myAmount;

@property (nonatomic,assign) BOOL isVip;

- (void)clickUpdate;

@end
