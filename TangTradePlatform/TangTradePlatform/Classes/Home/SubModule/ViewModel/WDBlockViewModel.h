//
//  WDBlockViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBlockViewModel : NSObject

@property (nonatomic,copy) NSString *currentBlock;

@property (nonatomic,copy) NSString *headBlockAge;

@property (nonatomic,copy) NSString *activeWitness;

@property (nonatomic,copy) NSString *nextMainTime;

@property (nonatomic,copy) NSString *activeCommitteeMember;

@property (nonatomic,strong) RACSubject *clearSubject;

@property (nonatomic,strong) RACSubject *dataSubject;

- (void)loadHeadData;

@end
