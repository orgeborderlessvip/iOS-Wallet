//
//  UIImage+QRCode.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/23.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

+ (instancetype)qrcodeFromString:(NSString *)string withSize:(CGFloat)size;

@end
