//
//  WDChongZhiTiXianBaseHeader.h
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/12.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CurrencyKind) {
    CurrencyKindCNY,
    CurrencyKindBTC,
    CurrencyKindUSD,
};

typedef NS_ENUM(NSInteger,SelectedPayKind) {
    SelectedPayKindCNYCard,
    SelectedPayKindUSDCard,
    SelectedPayKindCNYWeChat,
    SelectedPayKindCNYAlipay,
    SelectedPayKindBTCWallet,
};

static char payStyleNameArray[SelectedPayKindBTCWallet + 1][256] = {
    "银行卡",
    "银行卡",
    "微信",
    "支付宝",
    "钱包地址",
};
