//
//  WDSocketBaseModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDSocketBaseModel : NSObject

@property (nonatomic,copy) NSString *identifier;

@property (nonatomic,copy) NSString *jsonrpc;

@property (nonatomic,strong) id result;

+ (instancetype)modelToDic:(NSDictionary *)dic withDataModelTransFormName:(NSString *)className;

@end
