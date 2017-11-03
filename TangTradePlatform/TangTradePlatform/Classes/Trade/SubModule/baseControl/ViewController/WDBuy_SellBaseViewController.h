//
//  WDBuy_SellBaseViewController.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDHomeTableDataModel.h"
@interface WDBuy_SellBaseViewController : UIViewController

@property (nonatomic,copy) NSString *baseCoin;

@property (nonatomic,copy) NSString *quetoCoin;

@property (nonatomic,copy) NSArray *dataArray;

@end
