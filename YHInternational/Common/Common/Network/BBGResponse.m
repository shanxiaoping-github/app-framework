//
// Created by William Zhao on 13-6-26.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BBGResponse.h"
#import "BBGSessionManager.h"
//#import "BBGJumpManager.h"
#import "Common.h"
@implementation BBGResponse

@synthesize isCache = _isCache;

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        _data = data;
        //判断商城接口错误
        
        STRING_FOR_KEY(self.errorCode, @"code")
        
        if (![@"0000" isEqualToString:self.errorCode]) {
            _isError = YES;
        }else{
            _isError = NO;
        }
        if (_isError) {
            STRING_FOR_KEY(self.errorMsg, @"msg")
            if ([self.errorCode isEqualToString:@"0094"] ||
                [self.errorCode isEqualToString:@"0095"] ||
                [self.errorCode isEqualToString:@"0098"] ||
                [self.errorCode isEqualToString:@"0099"] ||
                [self.errorCode isEqualToString:@"0106"]
                ) {
                self.errorMsg = @"";
            }
            
            if ([self.errorCode isEqualToString:@"0098"] ||
                [self.errorCode isEqualToString:@"0099"] ||
                [self.errorCode isEqualToString:@"0106"]
                ) {
                [[BBGSessionManager sharedInstance] doLogout:^(BOOL successful) {
                    
                }];
                [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                    
                }];
            }
//            if (self.errorCode == 200010002 ||
//                self.errorCode == 200010001 ||
//                self.errorCode == 200010005 ||
//                self.errorCode == 200010004) {
//                //需要重新登录,清除已有的登录信息
////                [[BBGSessionManager sharedInstance] doLogout:YES];
//            }
        }

        STRING_FOR_KEY(self.tmessage, @"tmessage")
        if (![BBGTools checkStringIsBlank:self.tmessage]) {
            [[BBGLoadingTips sharedInstance] showTips:self.tmessage];
        }
    }
    return self;
}


- (NSString *)description {
    return [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
}

@end