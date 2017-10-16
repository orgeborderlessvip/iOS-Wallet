//
//  WDBuy_SellViewModel.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/10.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDBuy_SellViewModel.h"
#import "WDBuy_SellBaseResultModel.h"

@interface WDBuy_SellViewModel ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation WDBuy_SellViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self testGetBuy_SellData];
    }
    return self;
}
- (void)testGetBuy_SellData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buy_sell_test" ofType:@"json"]];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
    WDBuy_SellBaseResultModel *model = [WDSocketBaseModel modelToDic:dic withDataModelTransFormName:@"WDBuy_SellBaseResultModel"].result;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.buyArray = model.bids;
        self.sellArray = model.asks;
    });
}

@end
