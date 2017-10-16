//
//  WDUpdateTradeModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/9.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDUpdateTradeModel.h"
#import "HttpCommunicateDefine.h"
@interface WDUpdateTradeModel ()

@property (nonatomic,copy) NSString *jsonrpc;

@property (nonatomic,copy) NSString *identifier;

@property (nonatomic,copy) NSString *method;

@end

@implementation WDUpdateTradeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _jsonrpc = @"2.0";
        
        _identifier = @"1";
        
        _method = [NSString stringWithUTF8String:cWebSocketMethod[WebSocket_COMMAND_LIST_TradeFor24Hour]];
    }
    return self;
}

- (NSDictionary *)dictionaryFromModel {
    NSMutableDictionary *dic = [[super dictionaryFromModel] mutableCopy];
    
    [dic removeObjectsForKeys:@[@"identifier",@"from",@"to"]];
    
    [dic setObject:@[self.from,self.to] forKey:@"params"];
    
    return dic;
}

@end
