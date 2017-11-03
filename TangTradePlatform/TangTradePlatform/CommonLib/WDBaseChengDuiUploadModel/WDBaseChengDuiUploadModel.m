//
//  WDBaseChengDuiUploadModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBaseChengDuiUploadModel.h"

@implementation WDBaseChengDuiUploadModel

+ (instancetype)modelWithCode:(NSString *)code prm:(NSArray *)prm {
    return [[self alloc] initWithCode:code prm:prm];
}

- (instancetype)initWithCode:(NSString *)code prm:(NSArray *)prm {
    if (self = [super init]) {
        _time = [NSString stringWithFormat:@"%lld",(long long int)[[NSDate date] timeIntervalSince1970]];
        
        _code = code;
        
        _prm = prm;
    }
    return self;
}
- (NSDictionary *)dictionaryFromModel {
    NSMutableDictionary *dic = [[super dictionaryFromModel] mutableCopy];
    
    if (self.prm) {
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.prm options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *jsonString = nil;
        
        if (!jsonData) {
            NSLog(@"%@",error);
        }else{
            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        if (jsonString) {
            NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
            
            NSRange range = {0,jsonString.length};
            
            //去掉字符串中的空格
            
            [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
            
            NSRange range2 = {0,mutStr.length};
            
            //去掉字符串中的换行符
            
            [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
            
            dic[@"prm"] = mutStr;
        }else {
            dic[@"prm"] = @"";
        }
    }else {
        dic[@"prm"] = @"";
    }
    
    return dic;
}

- (NSDictionary *)dictionaryFromModelWithLang {
    NSMutableDictionary *dic = [[self dictionaryFromModel] mutableCopy];
    
    switch ([WDInternationalCenter userLanguage]) {
        case LanguageKindCNS:
            dic[@"lang"] = @"zh_cn";
            break;
        case LanguageKindEN:
            dic[@"lang"] = @"en";
            break;
        case LanguageKindCNT:
            dic[@"lang"] = @"zh_hk";
            break;
    }
    return dic;
}

@end
