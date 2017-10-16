//
//  WDChengDuiRecordDataModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDChongZhiTiXianBaseHeader.h"
typedef NS_ENUM(NSInteger,PaySupportKind) {
    PaySupportKindComplete = 1,
    PaySupportKindOther = 0
};

@interface WDChengDuiRecordDataModel : NSObject<ModelProtocol>

@property (nonatomic,copy) NSString *paySupportName;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *coinKind;
@property (nonatomic,assign) PaySupportKind paySupportKind;
@property (nonatomic,assign) SelectedPayKind selectedKind;


@end
