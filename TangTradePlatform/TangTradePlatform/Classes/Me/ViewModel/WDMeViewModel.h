//
//  WDMeViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDMeViewModel : NSObject

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) RACSubject *dataSubject;

- (void)loadData;

@end
