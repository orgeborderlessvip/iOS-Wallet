//
//  WDFileModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDPasswordUserPrivateFileModel.h"
@interface WDFileModel : NSObject<ModelProtocol>

@property (nonatomic,copy) NSString *chain_id;

@property (nonatomic,strong) NSArray *my_accounts;

@end
