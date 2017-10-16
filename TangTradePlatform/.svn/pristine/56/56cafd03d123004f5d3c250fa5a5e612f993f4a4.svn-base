//
//  CuideViewController.m
//  DreamTravelOnRoad
//
//  Created by lanouhn on 16/6/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CuideViewController.h"
#import "AppDelegate.h"

@interface CuideViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;



@end

@implementation CuideViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat size_width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat size_height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    for (int i = 0; i < self.imageArray.count; i++) {
        
        // 创建引导页要展示的iamgeView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(size_width *i, 0, size_width, size_height)];
        
        [self.backView addSubview:imageView];
        
        // 设置imageView的图片为外界传进来的图片
        [imageView setImage:[UIImage imageNamed:self.imageArray[i]]];
        
        // 判断当前引导页是最后一页,添加进入应用按钮
        
        if (i == self.imageArray.count -1) {
            
//            WDCustomButton *enterButton = [WDCustomButton buttonWithType:(UIButtonTypeCustom)];
//            
//            enterButton.cornerdius = 20;
//            
//            enterButton.lineWidth = 1;
            
//            enterButton.lineColor = RGBColor(230, 29, 57);
//            
//            [enterButton setTitle:@"立即开启" forState:(UIControlStateNormal)];
            
//            [enterButton setTitleColor:RGBColor(230, 29, 57) forState:(UIControlStateNormal)];
//            enterButton.frame = CGRectMake((size_width - 120) / 2, size_heigth  -100 , size_width / 3 * 2, 40);
//            
//            CGPoint center = enterButton.center;
//            
//            center.x = size_width / 2;
//            
//            enterButton.center = center;
//        
//            [imageView addSubview:enterButton];
//         
//        // 打开imageView的交互
//        imageView.userInteractionEnabled = YES;
//        
//        [enterButton addTarget:self action:@selector(enterButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
         }
    }

}

- (void)enterButtonClicked:(id *)sender {
    
    // 当用户点击进入应用按钮时,将启动动画设置成当前应用的主window的rootViewController
    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //指定根视图控制器
//    AppDelegate *dele =[UIApplication sharedApplication].delegate;
    
//    UIWindow *keyWindow =[UIApplication sharedApplication].keyWindow;
    
//    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    
//    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:dele.sideVC];
//    
//    keyWindow.rootViewController = rootNC;
    
    // 获得storyboard中的tabBarController
//    UITabBarController *tabBarController = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
    
   // dele.sideVC.rootViewController = tabBarController;
    
    
//    keyWindow.rootViewController = dele.sideVC;

}

- (void)updateViewConstraints{
 
    [super updateViewConstraints];
    CGFloat size_width = CGRectGetWidth([UIScreen mainScreen].bounds);
    // 设置backView的宽度为当前引导页的宽度
    self.widthConstraint.constant = size_width * self.imageArray.count;

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
