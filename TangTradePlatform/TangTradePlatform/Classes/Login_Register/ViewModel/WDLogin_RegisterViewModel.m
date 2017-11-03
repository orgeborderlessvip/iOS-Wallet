//
//  WDLogin_RegisterViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/14.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDLogin_RegisterViewModel.h"
#import "WDBaseFileControl.h"
@implementation WDLogin_RegisterViewModel

- (void)creatPasswordWithComplete:(void (^)())complete {
    [WDBaseFileControl creatLocalWithPassword:self.password];
    
    if (complete) {
        complete();
    }
}

@end
