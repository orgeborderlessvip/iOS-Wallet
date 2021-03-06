//
//  WDUploadSendModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/22.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDUploadSendModel : NSObject

@property (nonatomic,copy) NSString *from;

@property (nonatomic,copy) NSString *to;

@property (nonatomic,copy) NSString *amount;

@property (nonatomic,copy) NSString *symbol;

@property (nonatomic,copy) NSString *memo;

@property (nonatomic,copy) NSString *broadcast;

@property (nonatomic,copy) NSString *token;

@property (nonatomic,copy) NSString *api_code;

- (instancetype)initWithFrom:(NSString *)from to:(NSString *)to amount:(CGFloat)amount symbol:(NSString *)symbol;



@end
