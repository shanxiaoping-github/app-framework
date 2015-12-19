//
//  BBGShareManager.h
//  Components
//
//  Created by BubuGao on 15-4-21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"
#import "BBGConstants.h"
#import "BBGMacro.h"
typedef void (^shareResultCallback) (BOOL sucessful, NSString *snsName);
typedef void (^clickPlatformCallback) (NSString *snsName);

@interface BBGShareManager : NSObject
+ (BBGShareManager *)sharedInstance;

@property (nonatomic, assign) BOOL isBenifit;

//回调分享成功or失败
- (void)shareToSnsSheetView:(UIViewController *)controller
                  shareText:(NSString *)shareText
                 shareImage:(UIImage *)shareImage
            shareToSnsNames:(NSArray *)shareToSnsNames
                   shareUrl:(NSString *)shareUrl
                   callBack:(shareResultCallback)callBack;
//回调点击的分享平台
- (void)shareToSnsSheetView:(UIViewController *)controller
                  shareText:(NSString *)shareText
                 shareImage:(UIImage *)shareImage
            shareToSnsNames:(NSArray *)shareToSnsNames
                   shareUrl:(NSString *)shareUrl
      clickPlatformCallBack:(clickPlatformCallback)callBack;

@end
