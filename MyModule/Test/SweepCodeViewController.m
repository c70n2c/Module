//
//  SweepCodeViewController.m
//  CubeLive
//
//  Created by zowell on 2019/11/6.
//  Copyright © 2019 zviewtech. All rights reserved.
//

#import "SweepCodeViewController.h"
#import "AddDeviceViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SweepCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, assign) BOOL flashOpen;

@end

@implementation SweepCodeViewController

- (AVCaptureSession *)session {
    if (!_session) {
        _session = ({
            //获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            //创建输入流
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            if (!input) {
                return nil;
            }
            //创建输出流
            AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
            //设置代理 在主线程里刷新
            [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            //设置扫描区域的比例
            CGFloat width = 300 / CGRectGetHeight(self.view.frame);
            CGFloat height = 300 / CGRectGetWidth(self.view.frame);
            output.rectOfInterest = CGRectMake((1 - width) / 2, (1 - height) / 2, width, height);
            
            AVCaptureSession *session = [[AVCaptureSession alloc] init];
            //高质量采集率
            [session setSessionPreset:AVCaptureSessionPresetHigh];
            [session addInput:input];
            [session addOutput:output];
            
            //设置扫码支持的编码格式(这里设置条形码和二维码兼容)
            output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                           AVMetadataObjectTypeEAN13Code,
                                           AVMetadataObjectTypeEAN8Code,
                                           AVMetadataObjectTypeCode128Code];
            
            session;
        });
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initView];
}

- (void)initView {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" image:@"" Target:self Action:@selector(didClickImagePicker)];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.session startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        [self addDevice:metadataObject.stringValue];
    }
}

/// 相册选取
- (void)didClickImagePicker {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController: imagePicker animated:YES completion: NULL];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self identifyQRcode:image];
    [picker dismissViewControllerAnimated:YES completion: NULL];
}

/// 控制闪光灯
- (void)openLight {
    self.flashOpen = !self.flashOpen;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]) {
        [device lockForConfiguration:nil];
        if (self.flashOpen) {
            // 关闭闪光灯
            device.torchMode = AVCaptureTorchModeOn;
        } else {
            // 打开闪光灯 
            device.torchMode = AVCaptureTorchModeOff;
        }
        [device unlockForConfiguration];
    }
}

/// 识别二维码
- (void)identifyQRcode:(UIImage *)image {
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >= 1) {
        CIQRCodeFeature *feature = features.firstObject;
        [self addDevice:feature.messageString];
    } else {
        NSLog(@"没有找到二维码");
        [MBProgressHUD showError:NSLocalizedString(@"NotFindQRCode", nil)];
    }
}

/// 添加设备
- (void)addDevice:(NSString *)qrCode {
    AddDeviceViewController *addDeviceViewController = [[AddDeviceViewController alloc] init];
    addDeviceViewController.qrCode = qrCode;
    [self.navigationController pushViewController:addDeviceViewController animated:YES];
}

- (IBAction)didLight:(UIButton *)sender {
    [self openLight];
}

@end
