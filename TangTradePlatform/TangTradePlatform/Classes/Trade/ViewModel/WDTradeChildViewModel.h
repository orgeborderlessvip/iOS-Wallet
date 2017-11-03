//
//  WDTradeChildViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDTradeChildViewModel : NSObject

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) NSArray *allInfoArray;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) RACSubject *dataSubject;

- (void)getData;

@end
