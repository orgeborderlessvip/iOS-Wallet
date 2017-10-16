//
//  WDBuy_SellViewModel.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBuy_SellViewModel : NSObject

@property (nonatomic,strong) NSArray *buyArray;
@property (nonatomic,strong) NSArray *sellArray;

@property (nonatomic,assign) CGFloat myAount;
@property (nonatomic,assign) CGFloat lowestBuy;



@end
