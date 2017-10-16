//
//  WDNetworkManager.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/9/20.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDNetworkManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import "UIViewController+CurrentVC.h"
#import "UIViewController+Base.h"
static NSInteger const time_out = 45;
static BOOL const openHttpsSSL = NO;
@implementation WDNetworkManager
{
    AFHTTPSessionManager *_HTTPManager;
}

+ (id)sharedInstance {
    static WDNetworkManager * HTTPCommunicate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTTPCommunicate = [[WDNetworkManager alloc] init];
    });
    return HTTPCommunicate;
}

- (id)init
{
    if (self = [super init])
    {
        _HTTPManager = [AFHTTPSessionManager manager];
        _HTTPManager.requestSerializer.HTTPShouldHandleCookies = YES;
        
        _HTTPManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        _HTTPManager.securityPolicy.allowInvalidCertificates = YES;
        [_HTTPManager.requestSerializer setTimeoutInterval:time_out];
        
        //防止https 证书 code999
        _HTTPManager.securityPolicy.validatesDomainName = NO;
        // 加上这行代码，https ssl 验证。
        if(openHttpsSSL)
        {
            [_HTTPManager setSecurityPolicy:[self customSecurityPolicy]];
        }
        //设置可接受内容类型
        _HTTPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
    }
    return self;
}

/**
 构造请求方法
 
 @param taskID 请求地址
 @param param 请求参数
 @param method 请求方法
 @param success 成功后回调
 @param failure 请求失败回调
 @param showHud 是否显示浮层
 @param showText 浮层文字
 */
- (void)createRequest:(HTTP_COMMAND_LIST)taskID WithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure showHUD:(BOOL)showHud showText:(NSString *)showText {
    [self createWithBaseUrl:URL_BASE request:taskID WithParam:param withMethod:method success:success failure:failure showHUD:NO showText:showText];
}

- (void)createWithBaseUrl:(NSString *)baseurl request:(HTTP_COMMAND_LIST)taskID WithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure showHUD:(BOOL)showHud showText:(NSString *)showText {
    DLog(@"%@",[self convertToJsonData:param]);
    
    if ([baseurl isEqualToString:URL_ChengDui]) {
        _HTTPManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else {
        _HTTPManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    /**
     *  请求的时候给一个转圈的状态
     */
    UIViewController *current = [UIViewController currentViewController] ;
    
    if (showHud) {
        void (^showBlock)() = ^{
            [current showHuDwith:showText];
            //        showView.userInteractionEnabled = NO;
            [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
        };
        
        if ([NSThread isMainThread]) {
            showBlock();
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                showBlock();
            });
        }
    }
    
    NSString * url = baseurl;
    /******************************************************************/
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer requestWithMethod:[self getStringForRequestType:method] URLString:[[NSURL URLWithString:url relativeToURL:_HTTPManager.baseURL] absoluteString] parameters:param error:nil];
    
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        void (^hidenBlock) () = ^{
            [current hidenHUD];
            
            [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
        };
        
        if (error) {
            DLog(@"%@",error);
            if (showHud) {
                if ([NSThread isMainThread]) {
                    hidenBlock();
                }else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hidenBlock();
                    });
                }
            }
            if (failure) {
                failure(error);
            }
        } else {
            DLog(@"%@",[self convertToJsonData:responseObject]);
            if (success != nil) {
                if (showHud) {
                    if ([NSThread isMainThread]) {
                        hidenBlock();
                    }else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            hidenBlock();
                        });
                    }
                }
                success(responseObject);
            }
        }
    }];
    
    [dataTask resume];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (void)createRequestWithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure showHUD:(BOOL)showHud showText:(NSString *)showText {
    [[self sharedInstance] createRequest:0 WithParam:param withMethod:method success:success failure:failure showHUD:showHud showText:showText];
}

+ (void)createWithBaseUrl:(NSString *)baseurl WithParam:(NSDictionary *)param withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure showHUD:(BOOL)showHud showText:(NSString *)showText {
    [[self sharedInstance] createWithBaseUrl:baseurl request:0 WithParam:param withMethod:method success:success failure:failure showHUD:showHud showText:showText];
}

- (void)checkUpdateWithSuccess:(void(^)(id result))success error:(void(^)())errors {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    /**
     *  请求的时候给一个转圈的状态
     */
    
    NSString * url = @"http://www.borderless.vip/update.json";
    /******************************************************************/
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer requestWithMethod:[self getStringForRequestType:GET] URLString:[[NSURL URLWithString:url relativeToURL:_HTTPManager.baseURL] absoluteString] parameters:nil error:nil];
    
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            DLog(@"%@",error);
            if (errors) {
                errors();
            }
        } else {
            DLog(@"%@",[self convertToJsonData:responseObject]);
            if (success != nil) {
                success(responseObject);
            }
        }
    }];
    
    [dataTask resume];
}


-(NSString *)getStringForRequestType:(HTTPRequestMethod)type {
    NSString *requestTypeString = nil;
    
    switch (type) {
        case POST:
            requestTypeString = @"POST";
            break;
            
        case GET:
            requestTypeString = @"GET";
            break;
            
        case PUT:
            requestTypeString = @"PUT";
            break;
            
        case DELETE:
            requestTypeString = @"DELETE";
            break;
        default:
            requestTypeString = @"POST";
            break;
    }
    
    return requestTypeString;
}

/**
 https校验证书
 */
- (AFSecurityPolicy*)customSecurityPolicy
{
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"mbank" ofType:@"cer"];
    
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // policyWithPinningMode 使用证书验证模式
    //AFSSLPinningModeNone: 代表客户端无条件地信任服务器端返回的证书。
    //AFSSLPinningModePublicKey: 代表客户端会将服务器端返回的证书与本地保存的证书中，PublicKey的部分进行校验；如果正确，才继续进行。
    //AFSSLPinningModeCertificate: 代表客户端会将服务器端返回的证书和本地保存的证书中的所有内容，包括PublicKey和证书部分，全部进行校验；如果正确，才继续进行。
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    securityPolicy.validatesDomainName = YES;
    //自签证书
    securityPolicy.pinnedCertificates = (NSSet *)@[certData];
    
    return securityPolicy;
}

@end
