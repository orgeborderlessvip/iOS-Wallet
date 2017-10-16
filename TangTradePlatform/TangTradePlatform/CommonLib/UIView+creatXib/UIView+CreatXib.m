//
//  UIView+CreatXib.m
//  FlbCartercoin
//
//  Created by ctcios2 on 2017/7/28.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import "UIView+CreatXib.h"

@implementation UIView (CreatXib)

+ (instancetype)creatXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end
