//
//  UILabel+Copy.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/11/2.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Copy)

@property (nonatomic,assign) BOOL canCopy;

@property (nonatomic,copy) NSString *copyString;

@end
