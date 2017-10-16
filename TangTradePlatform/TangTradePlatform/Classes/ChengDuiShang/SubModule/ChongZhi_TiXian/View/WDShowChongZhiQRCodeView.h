//
//  WDShowChongZhiQRCodeView.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,QRCodeKind) {
    QRCodeKindWallet = 4,
    QRCodeKindAlipay = 3,
    QRCodeKindWechat = 2,
};

@interface WDShowChongZhiQRCodeView : UIView

+ (void)showWithTitleName:(NSString *)titleName QRCodeKind:(QRCodeKind)kind imageUrl:(NSString *)imgUrl nameLabelText:(NSString *)text clickClose:(void (^)())clickClose;

@end
