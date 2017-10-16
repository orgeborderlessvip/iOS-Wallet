//
//  MMPickerView.h
//  MMPickerView
//
//  Created by Madjid Mahdjoubi on 6/5/13.
//  Copyright (c) 2013 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MMbackgroundColor;
extern NSString * const MMtextColor;
extern NSString * const MMtoolbarColor;
extern NSString * const MMbuttonColor;
extern NSString * const MMfont;
extern NSString * const MMvalueY;
extern NSString * const MMselectedObject;
extern NSString * const MMselectedMoneyObject;
extern NSString * const MMtoolbarBackgroundImage;
extern NSString * const MMtextAlignment;
extern NSString * const MMshowsSelectionIndicator;

@interface MMPickerView: UIView 

+(void)showPickerViewInView: (UIView *)view
                withStrings: (NSArray *)strings
                withOptions: (NSDictionary *)options
                 completion: (void(^)(NSString *selectedString,NSInteger index))completion;
+(void)showPickerViewInView:(UIView *)view
                withStrings:(NSArray *)strings
               withMoenyStr:(NSArray *)moenyStr
                withOptions:(NSDictionary *)options
                 completion:(void (^)(NSString *selectedString,NSInteger index))completion
                completion1:(void (^)(NSString *selectedString))completion1;

+(void)dismissWithCompletion: (void(^)(NSString *,NSInteger index))completion Completion: (void(^)(NSString *))completion1;
@end