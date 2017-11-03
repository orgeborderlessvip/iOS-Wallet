//
//  ScanningViewController.h
//  FlbCartercoin
//
//  Created by wanggang on 2017/7/4.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanningViewController : UIViewController

@property (nonatomic,copy)void(^CamacreString)(NSString *number);

@end
