//
//  WDKlineWebViewController.m
//  TangTradePlatform
//
//  Created by ctcios2 on 2017/10/21.
//  Copyright © 2017年 com.tang.trade. All rights reserved.
//

#import "WDKlineWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "NSDate+UTCDate.h"
@interface WDKlineWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topbarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign) NSInteger second;

@property (nonatomic,assign) BOOL alerdyLoad;

@property WebViewJavascriptBridge* bridge;

@end

@implementation WDKlineWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _second = 60;
    
    [WDWalletManager getKLineWithBaseCoin:@"LTC" quoteCoin:@"EFG" bucket:_second start:[[NSDate dateWithTimeInterval:-60 * 60 * 24 * 30 * 12 sinceDate:[NSDate date]] UTCString] end:[[NSDate date] UTCString] withSuccess:^(NSArray *array) {
        self.dataArray = array;
        
        if (!self.alerdyLoad) {
            [self loadExamplePage:self.webView];
        }
    }];
    
    [self addChangeToHeadView:self.topbarView];
    
    [self.backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge registerHandler:@"testCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(self.dataArray);
    }];
    
}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"coinkline" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _alerdyLoad = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
