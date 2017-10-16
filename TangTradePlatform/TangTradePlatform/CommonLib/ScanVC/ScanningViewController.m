//
//  ScanningViewController.m
//  FlbCartercoin
//
//  Created by wanggang on 2017/7/4.
//  Copyright © 2017年 newcartercoin. All rights reserved.
//

#import "ScanningViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UserLanguageChange>
{
    AVCaptureSession * session;//输入输出的中间桥梁
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;

@property (weak, nonatomic) IBOutlet UIButton *lightButton;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (nonatomic,assign) BOOL flashOn;
@property (weak, nonatomic) IBOutlet UILabel *scanLabel;
@property (weak, nonatomic) IBOutlet UIButton *albumButton;

@end

@implementation ScanningViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAnimated) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIAlertController showAlert:YES fromVC:self withTitle:@"请在iPhone的“设置-隐私-相机”选项中，允许Broderless访问你的相机。" message:nil withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        });
    }
    
    if (!input) return;
    
    CGFloat size_width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat size_height = CGRectGetHeight([UIScreen mainScreen].bounds);
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop=[self getScanCrop:CGRectMake(0, 0, size_width, size_width) readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=CGRectMake(0, 0, size_width, size_height);
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
    
}

- (void)languageSet {
    NSString *title = WDLocalizedString(@"扫描二维码");
    NSString *buttonAction = WDLocalizedString(@"相册");
    
    _scanLabel.text = title;
    [_albumButton setTitle:buttonAction forState:(UIControlStateNormal)];
}

- (void)startAnimated {
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    basic.fromValue = @(0);
    
    basic.toValue = @(240);
    
    basic.duration = 2.5;
    basic.repeatCount = MAXFLOAT;
    [self.lineImageView.layer addAnimation:basic forKey:nil];
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //[session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
//        NSLog(@"二维码扫描%@",metadataObject.stringValue);
        if (self.CamacreString) {
            [session stopRunning];
            self.CamacreString(metadataObject.stringValue);
        }
    }
}

#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self startAnimated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.lineImageView.layer removeAllAnimations];
    
//    self.lineImageView.transform = CGAffineTransformIdentity;
    
}
- (IBAction)cancleButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (IBAction)clickedLightButton:(UIButton *)sender {
    
   if (self.flashOn) { //打开闪光灯
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
    [self.lightButton setBackgroundImage:[UIImage imageNamed:@"barcode_torch_on"] forState:UIControlStateNormal];
       
    }else {
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                if ([device hasTorch]) {
                    [device lockForConfiguration:nil];
                    [device setTorchMode: AVCaptureTorchModeOff];
                    [device unlockForConfiguration];
              
                }
        [self.lightButton setBackgroundImage:[UIImage imageNamed:@"barcode_torch_off"] forState:UIControlStateNormal];
    }
    self.flashOn = !self.flashOn;
}


- (IBAction)clikedPhotoButton:(UIButton *)sender {
    
    [self myAlbum];
    
}


#pragma mark-> 我的相册
-(void)myAlbum{
    
    CGFloat size_width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
//    CGFloat size_height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    self.lineImageView.frame = CGRectMake(size_width/2 -120, self.backImageView.frame.origin.y, 240, 2);
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
            
        }
        [self.lightButton setBackgroundImage:[UIImage imageNamed:@"barcode_torch_off"] forState:UIControlStateNormal];
        self.flashOn = NO;
        //1.初始化相册拾取器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //2.设置代理
        controller.delegate = self;
        //3.设置资源：
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //4.随便给他一个转场动画
        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:NULL];
        
    }else{
        
        [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许Broderless访问你的相机。" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
            
        }];
    }
    
}

#pragma mark-> imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
        
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];

        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            
            NSString *scannedResult = feature.messageString;
            
            if (self.CamacreString) {
                self.CamacreString(scannedResult);
            }
        }else{
            [UIAlertController showAlert:YES fromVC:self withTitle:@"提示" message:@"该图片没有包含一个二维码!" withButtonTitle:@[@"确定"] clickAction:^(NSInteger index, NSString *title) {
                [self startAnimated];
            }];
            
        }
        
        
    }];
    
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
