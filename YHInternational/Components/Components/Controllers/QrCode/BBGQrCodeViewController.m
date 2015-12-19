//
//  BBGQrCodeViewController.m
//  Components
//
//  Created by elvis.peng on 15-5-20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGQrCodeViewController.h"
@interface BBGQrCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic)AVCaptureDevice *captureDevice;
@property (strong, nonatomic)AVCaptureDeviceInput *input;
@property (strong, nonatomic)AVCaptureMetadataOutput *output;
@property (strong, nonatomic)AVCaptureSession *session;
@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;
@property (strong, nonatomic)AVAudioPlayer *audioPlayer;
@end

@implementation BBGQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadBeepSound];
}


-(void)reStartScan{
    if ([self.preview superlayer]) {
        [self.preview removeFromSuperlayer];
    }
    if ([self.overlayView superview]) {
        [self.overlayView removeFromSuperview];
    }
    CGRect previewFrame = self.view.layer.bounds;
    [self initUI:previewFrame];
    [self startScan];
}


- (void)initUI:(CGRect)previewFrame {
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    if (error) {
        [[BBGLoadingTips sharedInstance] showTips:@"该手机不支持二维码扫描"];
        return;
    }
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
        
    }
    // 条码类型
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    // Preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = previewFrame;
    [self.view.layer addSublayer:_preview];
    
    CGFloat ScreenHigh = self.view.frame.size.height;
    CGFloat ScreenWidth = self.view.frame.size.width;
    CGRect frame = CGRectMake((124)/ScreenHigh,((ScreenWidth-220)/2)/ScreenWidth,220/ScreenHigh,220/ScreenWidth);
    [_output setRectOfInterest:frame];
    self.overlayView = [[OverlayView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                            cancelEnabled:YES
                                                 oneDMode:YES];
    [self.view addSubview:self.overlayView];
    [self.overlayView setPoints:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(errorWithDomain:)
                                                 name:AVCaptureSessionRuntimeErrorNotification object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//启动扫描
- (void)startScan {
    [_session startRunning];
}
- (void)stopScan {
    [_session stopRunning];
}

- (void)errorWithDomain:(NSString *)domain{



}
// 此方法是在识别到QRCode，并且完成转换 如果QRCode的内容越大，转换需要的时间就越长
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [_session stopRunning];
    //    [_preview removeFromSuperlayer];
    if (_audioPlayer) {
        [_audioPlayer play];
    }
    [self scanCodeSuccessWithOutputMetadataObjects:metadataObjects];
}


-(void)loadBeepSound{
    
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep-beep" ofType:@"caf"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
    
}

- (void)scanCodeSuccessWithOutputMetadataObjects:(NSArray *)metadataObjects{

    @throw [NSException exceptionWithName:@"BBGQrCodeViewController" reason:@"子类需实现scanCodeSuccessWithOutputMetadataObjects" userInfo:nil];
}

-(void)dealloc{
    [_session stopRunning];
    [_preview removeFromSuperlayer];
    [_output setMetadataObjectsDelegate:nil queue:nil];
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
