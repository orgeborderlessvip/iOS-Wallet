//
//  WDChengDuiRecordViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SelectedKind) {
    SelectedKindIn,
    SelectedKindOut
};

@interface WDChengDuiRecordViewModel : NSObject

/**
 充值记录
 */
@property (nonatomic,strong) NSArray *inArray;

/**
 提现记录
 */
@property (nonatomic,strong) NSArray *outArray;

@property (nonatomic,assign) SelectedKind selectedKind;

@end
