//
//  WDCheckUpdateModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/25.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCheckUpdateModel : NSObject

@property (nonatomic,copy) NSString *iosversion;
@property (nonatomic,copy) NSString *appVersion;
@property (nonatomic,assign) BOOL needUpdate;

@property (nonatomic,assign) BOOL status;
@property (nonatomic,copy) NSString *contents;
@property (nonatomic,copy) NSString *contents_tw;
@property (nonatomic,copy) NSString *contents_cn;
@property (nonatomic,copy) NSString *iosurl;

+ (instancetype)modelToDic:(NSDictionary *)dic;

@end
