//
//  WDChengDuiShangTableDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDChengDuiShangTableDataModel : NSObject<ModelProtocol>

/**
 供应商姓名
 */
@property (nonatomic,copy) NSString *paySupportName;

/**
 承兑商ID
 */
@property (nonatomic,assign) NSInteger AcceptanceList_ID;

/**
 承兑商评分
 */
@property (nonatomic,assign) NSInteger paySupportRanking;

/**
 承兑商详情
 */
@property (nonatomic,copy) NSString *paySupportDetail;

/**
 承兑商支持图片列表
 */
@property (nonatomic,strong) NSArray *paySupportArray;

@end
