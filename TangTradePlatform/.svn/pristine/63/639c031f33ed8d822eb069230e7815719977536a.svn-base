//
//  WDBaseResultModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelProtocol <NSObject>

+ (instancetype)modelToDic:(NSDictionary *)dic;

@end

@interface WDBaseResultModel : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) BOOL status;

+ (instancetype)modelToDic:(NSDictionary *)dic withDataModelTransFormName:(NSString *)className;

@end
