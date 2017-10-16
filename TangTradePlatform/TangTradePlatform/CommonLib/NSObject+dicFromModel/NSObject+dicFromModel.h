//
//  NSObject+dicFromModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (dicFromModel)

/**
 *  模型转字典
 *
 *  @return 字典
 */
- (NSDictionary * _Nonnull)dictionaryFromModel;
/**
 *  模型转字典(去除空字符串)
 *
 *  @return 字典
 */
- (NSDictionary * _Nullable)dictionaryFromModelRemoveNilValue;

/**
 *  带model的数组或字典转字典
 *
 *  @param object 带model的数组或字典转
 *
 *  @return 字典
 */
- (_Nonnull id)idFromObject:(nonnull id)object;

@end
