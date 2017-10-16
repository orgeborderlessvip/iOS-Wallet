//
//  WDPasswordUserPrivateFileModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/16.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDPasswordUserPrivateFileModel : NSObject<ModelProtocol>


@property (nonatomic,copy) NSString *idnentifier;
/**
 pubKey
 */
@property (nonatomic,copy,readonly) NSString *pub_key;

/**
 privateKey
 */
@property (nonatomic,copy,readonly) NSString *wif_priv_key;

@property (nonatomic,copy) NSString *name;

@end
