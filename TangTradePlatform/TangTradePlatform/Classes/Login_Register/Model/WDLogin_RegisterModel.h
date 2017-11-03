//
//  WDLogin_RegisterModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDLogin_RegisterModel : NSObject

@property (nonatomic,copy) NSString *api_code;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *password;

- (instancetype)initFromViewModel:(id)viewModel;

@end
