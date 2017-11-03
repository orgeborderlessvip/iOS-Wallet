//
//  WDBuy_SellViewController.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDBuy_SellViewController : UIViewController

@property (nonatomic,copy) NSString *baseCoin;

@property (nonatomic,copy) NSString *quetoCoin;

/**
 买入或卖出
 */
@property (nonatomic,assign) BOOL isSell;

- (void)getAllData;

@end
