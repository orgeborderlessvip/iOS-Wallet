//
//  AppDelegate.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/11.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "AppDelegate.h"
#import "CuideViewController.h"
#import "WDLogin_RegisterViewController.h"
#import "BaseTabBarViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "WDHomeViewController.h"
#import "WDCheckUpdateViewController.h"
#import "WDTradeViewController.h"
#import "WDBuy_SellViewController.h"
#import "WDBuy_SellBaseViewController.h"

#import "WDChengDuiViewController.h"
#import "WDChengDuiRecordViewController.h"

#import "WDLoginAppViewController.h"
#import "WDBaseFileControl.h"

#import "WDBaseWalletCommand.h"
#import "WDPasswordUserPrivateFileModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    
    keyboardManager.enable = YES;
    
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    keyboardManager.enableAutoToolbar = NO;

    keyboardManager.keyboardDistanceFromTextField = 40.0f;
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    [self test];
    
    if (![WDBaseFileControl haveLocal]) {
        _window.rootViewController = ({
            WDLogin_RegisterViewController *vc = [WDLogin_RegisterViewController new];
    
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav;
        });
    }else {
        _window.rootViewController = [WDLoginAppViewController new];
    }
    
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)test {
    _window.rootViewController = ({
        BaseTabBarViewController *vc = [BaseTabBarViewController new];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier {
    
    return NO;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)checkUpdate {
    [WDCheckUpdateViewController showWithUserCheck:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self checkUpdate];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
