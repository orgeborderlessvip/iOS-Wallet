//
//  WDBaseChengDuiUploadModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBaseChengDuiUploadModel : NSObject

@property (nonatomic,copy) NSString *code;

@property (nonatomic,strong) NSArray *prm;

@property (nonatomic,copy,readonly) NSString *time;

+ (instancetype)modelWithCode:(NSString *)code prm:(NSArray *)prm;

- (NSDictionary *)dictionaryFromModelWithLang;

@end
