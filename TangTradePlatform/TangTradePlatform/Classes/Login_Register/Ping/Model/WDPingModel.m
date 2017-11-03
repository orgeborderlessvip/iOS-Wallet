//
//  WDPingModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/19.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDPingModel.h"
#import "STDPingServices.h"

@interface WDPingModel ()

@property (nonatomic,strong) STDPingServices *pingServices;

@end

@implementation WDPingModel

+ (instancetype)modelWithBaseUrl:(NSString *)url {
    return [[self alloc] initWithBaseUrl:url];
}

- (instancetype)initWithBaseUrl:(NSString *)url {
    if (self = [super init]) {
        NSString *re = @"(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)";
        
        NSRange range = [url rangeOfString:re options:NSRegularExpressionSearch];
        
        if (range.location != NSNotFound) {
            _url = [url substringWithRange:range];
        }else {
            _url = nil;
        }
        _ping = CGFLOAT_MAX;
        
        _baseSockUrl = url;
        
        if ([_baseSockUrl isEqualToString:[WDWalletManager currecntConnectUrl]]) {
            _selected = YES;
        }
    }
    return self;
}


- (void)startPing {
    @weakify(self);
    
    self.pingServices = [STDPingServices startPingAddress:_url callbackHandler:^(STDPingItem *pingItem, NSArray *pingItems) {
        @strongify(self);
        
        if (pingItem.status == STDPingStatusFinished) {
//            self.ping = pingItem.timeMilliseconds;
            self.pingServices = nil;
            
        }else if (pingItem.status == STDPingStatusError || pingItem.status == STDPingStatusDidTimeout) {
            self.ping = CGFLOAT_MAX;
            [self.pingServices cancel];
        }else if (pingItem.status == STDPingStatusDidReceivePacket || pingItem.status == STDPingStatusDidReceiveUnexpectedPacket){
            self.ping = pingItem.timeMilliseconds;
            [self.pingServices cancel];
        }
        
        
    }];
}

@end
