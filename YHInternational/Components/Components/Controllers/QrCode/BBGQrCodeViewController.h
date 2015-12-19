//
//  BBGQrCodeViewController.h
//  Components
//
//  Created by elvis.peng on 15-5-20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "OverlayView.h"
@interface BBGQrCodeViewController : BBGViewController
@property (strong, nonatomic)OverlayView *overlayView;
/**
 *  关闭扫码
 */
- (void)stopScan;
/**
 *  重置并开启扫码
 */
- (void)reStartScan;

/**
 *  扫码成功调用   子类实现此方法
 *
 *  @param metadataObjects 二维码内容
 */
- (void)scanCodeSuccessWithOutputMetadataObjects:(NSArray *)metadataObjects;
@end
