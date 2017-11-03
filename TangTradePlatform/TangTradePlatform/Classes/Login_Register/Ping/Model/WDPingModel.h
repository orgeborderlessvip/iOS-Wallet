//
//  WDPingModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/19.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDPingModel : NSObject

@property (nonatomic,copy,readonly) NSString *url;

@property (nonatomic,assign) BOOL selected;

@property (nonatomic,assign) CGFloat ping;

@property (nonatomic,copy) NSString *baseSockUrl;

+ (instancetype)modelWithBaseUrl:(NSString *)url;

- (void)startPing;

@end
