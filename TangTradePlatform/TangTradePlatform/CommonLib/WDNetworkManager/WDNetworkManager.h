//
//  WDNetworkManager.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/20.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommunicateDefine.h"
typedef NS_ENUM(NSInteger,HTTPRequestMethod) {
    POST,GET,PUT,DELETE
};

@interface WDNetworkManager : NSObject

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *password;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) RACSubject *dataSubject;

@property (nonatomic,strong) NSArray *urlArray;

+ (instancetype)sharedInstance;

+ (void)createRequestWithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure showHUD:(BOOL)showHud showText:(NSString *)showText;

+ (void)createWithBaseUrl:(NSString *)baseurl WithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure showHUD:(BOOL)showHud showText:(NSString *)showText;

- (void)checkUpdateWithSuccess:(void(^)(id result))success error:(void(^)())errors;

@end
