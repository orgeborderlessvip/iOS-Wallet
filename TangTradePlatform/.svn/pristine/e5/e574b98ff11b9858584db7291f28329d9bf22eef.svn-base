//
//  WDInternationalCenter.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/27.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//


#define LANGUAGE_SET @"langeuageset"

#import "WDInternationalCenter.h"
#import "BaseTabBarViewController.h"
@interface WDInternationalCenter ()
@property(nonatomic,strong)NSBundle *bundle;
@property(nonatomic,copy)NSString *language;
@end

NSString *const CNS = @"zh-Hans";
NSString *const EN = @"en";
NSString *const CNT = @"zh-Hant";
@implementation WDInternationalCenter

+(instancetype)sharedInstance
{
    static WDInternationalCenter *sharedModel = nil;
    if (!sharedModel)
    {
        sharedModel = [[WDInternationalCenter alloc]init];
    }
    
    return sharedModel;
}

-(void)initLanguage
{
    NSString *tmp = [[NSUserDefaults standardUserDefaults]objectForKey:LANGUAGE_SET];
    NSString *path;
    
    NSArray *supportLanguage = @[EN,CNS,CNT];
    
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    if ([languageName hasPrefix:@"zh-Hans"]) {
        languageName = @"zh-Hans";
    }else if ([languageName hasPrefix:@"zh-Hant"]) {
        languageName = @"zh-Hant";
    }
    
    //默认是英文
    if (!tmp && ![supportLanguage containsObject:languageName])
    {
        tmp = EN;
    }else
    {
        if (!tmp) {
            tmp = languageName;
        }
    }

    self.language = tmp;
    path = [[NSBundle mainBundle]pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initLanguage];
    }
    
    return self;
}

-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table
{
    if (self.bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
    }
    
    return NSLocalizedStringFromTable(key, table, @"");
}

-(void)setNewLanguage:(NSString *)language
{
    if ([language isEqualToString:self.language])
    {
        return;
    }
    
    if ([language isEqualToString:EN] || [language isEqualToString:CNS] || [language isEqualToString:CNT])
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }
    
    self.language = language;
    [[NSUserDefaults standardUserDefaults]setObject:language forKey:LANGUAGE_SET];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self resetRootViewController];
}

//重新设置
-(void)resetRootViewController
{
    NSString *loca = WDLocalizedString(@"设置中");
    
    [[UIViewController currentViewController] showHuDwith:loca];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIViewController currentViewController] hidenHUD];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:changeLanguageNotification object:nil];
        
        [[UIViewController currentViewController].navigationController popViewControllerAnimated:YES];
//        [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[BaseTabBarViewController new]];
    });
}

+ (NSString *)getStringByKey:(NSString *)key {
    return [[self sharedInstance] getStringForKey:key withTable:@"Localizable"];
}

+ (void)setUserlanguage:(LanguageKind)language {
    NSArray *array = @[CNS,CNT,EN];
    
    [[self sharedInstance] setNewLanguage:array[language]];
}

+ (LanguageKind)userLanguage {
    NSArray *array = @[CNS,CNT,EN];
    
    return [array indexOfObject:[WDInternationalCenter sharedInstance].language];

}

@end
