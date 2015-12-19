//
//  BBGWebViewController.h
//  Components
//
//  Created by Holyjoy on 15/5/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGWebViewController : BBGViewController

@property (nonatomic, strong, readonly) UIWebView *webView;

@property (nonatomic, assign) BOOL hasBottomView;
@property (nonatomic, strong) NSURL *url;

- (id)initWithHTMLString:(NSString *)htmlString;
- (id)initWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url htmlString:(NSString *)htmlString;
- (void)loadURL:(NSURL *)url;
- (NSMutableURLRequest *)buildRequest;
- (NSDictionary *)pasingWithString:(NSString *)string;
- (BOOL)parseURLString:(NSString *)url;
//是否处理https,如果证书没有问题,不需要设置
- (BOOL)handleHttps;


/**
 *  子类实现
 */
-(void)reLoadNavView;

@end
