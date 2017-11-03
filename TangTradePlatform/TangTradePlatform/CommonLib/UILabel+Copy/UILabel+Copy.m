//
//  UILabel+Copy.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/11/2.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "UILabel+Copy.h"
#import <objc/runtime.h>
@implementation UILabel (Copy)

- (void)setCopyString:(NSString *)copyString {
    objc_setAssociatedObject(self, @selector(copyString), copyString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)copyString {
    NSString *_copyString = objc_getAssociatedObject(self, @selector(copyString));
    
    return _copyString;
}

- (void)setCanCopy:(BOOL)canCopy {
    objc_setAssociatedObject(self, @selector(canCopy), @(canCopy), OBJC_ASSOCIATION_ASSIGN);
    
    if (canCopy) {
        [self addLongPressEvent];
    }else {
        if (self.gestureRecognizers.count > 0) {
            [self removeGestureRecognizer:self.gestureRecognizers.firstObject];
        }
    }
}

- (void)addLongPressEvent{
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionS:)];
    [self addGestureRecognizer:longPress];
    
}


- (void)actionS:(UILongPressGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuItem *menuItem1 = [[UIMenuItem alloc] initWithTitle:WDLocalizedString(@"拷贝") action:@selector(copyS:)];
        UIMenuController *menuC = [UIMenuController sharedMenuController];
        
        menuC.menuItems = @[menuItem1];
        menuC.arrowDirection = UIMenuControllerArrowUp;
        
        if (menuC.menuVisible) {
            //        NSLog(@"menuC.menuVisible    判断 --  %d", menuC.menuVisible);
            return ;
        }
        
        [menuC setTargetRect:self.frame inView:self.superview];
        [menuC setMenuVisible:YES animated:YES];
        
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(copyS:) && self.copyString.length > 0) {
        //        NSLog(@"粘贴板   --  %@", [UIPasteboard generalPasteboard].string);
        return YES;
    }else{
        return NO;
    }
}
//拷贝
- (void)copyS:(id)sender{
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
    
}

- (BOOL)canBecomeFirstResponder{
    return YES;
    
}

- (BOOL)canCopy {
    BOOL canCopy = [objc_getAssociatedObject(self, @selector(canCopy)) boolValue];
    return canCopy;
}

@end
