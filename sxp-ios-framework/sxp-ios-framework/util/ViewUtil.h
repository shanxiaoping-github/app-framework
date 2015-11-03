//
//  ViewUtil.h
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/8/21.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ViewUtil : NSObject
/*操作状态*/
+(UIBarButtonItem*)getBackButtonItemWithImage:(UIImage*)image frame:(CGRect)frame target:(id)target sel:(SEL)sel;
/*uicolor 转为 uiimage*/
+(UIImage*)UIColorTransferUIImage:(UIColor*)color rect:(CGRect)rect;

@end
