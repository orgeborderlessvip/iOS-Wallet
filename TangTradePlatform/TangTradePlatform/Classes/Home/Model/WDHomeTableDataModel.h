//
//  WDHomeTableDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDHomeTableDataModel : NSObject <ModelProtocol>

@property (nonatomic,copy) NSString *coinName;

@property (nonatomic,copy) NSString *asset_id;

@property (nonatomic,assign) NSInteger precision;

@property (nonatomic,copy) NSString *coinPrice;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) BOOL isSmart;

@property (nonatomic,assign) CGFloat rate;

@end
