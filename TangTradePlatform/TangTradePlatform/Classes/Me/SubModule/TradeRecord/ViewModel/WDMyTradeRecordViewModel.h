//
//  WDMyTradeRecordViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/29.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDMyTradeRecordViewModel : NSObject

@property (nonatomic,strong) NSArray *dataArray;

- (void)loadData;

@end
