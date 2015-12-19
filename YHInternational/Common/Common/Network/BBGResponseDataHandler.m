//
// Created by William Zhao on 13-7-10.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BBGResponseDataHandler.h"
#import "JSONKit.h"

@interface BBGResponseDataHandler ()
- (BBGResponseData *)parseJson:(NSData *)jsonData;

- (BBGResponseData *)parseXml:(NSData *)xmlData;
@end

@implementation BBGResponseDataHandler

@synthesize isError = _isError;
@synthesize error = _error;
@synthesize responseFormat = _responseFormat;
@synthesize responseData = _responseData;
@synthesize standardFormatter = _standardFormatter;

- (id)init {
    self = [super init];
    if (self) {
        _standardFormatter = [[NSDateFormatter alloc] init];
        _standardFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return self;
}

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [self init];
    if (self) {
        
        if (format == ResponseDataFormatJson) {
            BBGResponseData *responseData = [self parseJson:data];
            if (![responseData isNull]) {
                _responseData = responseData;
                _isError = NO;
            }
            else {
                //不正常返回数据格式时候，返回字符串处理
                if (data) {
                    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    _responseData = [[BBGResponseData alloc] initWithData:dataString];
                }
                _isError = YES;
            }
        }
        else if (format == ResponseDataFormatString) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            _responseData = [[BBGResponseData alloc] initWithData:dataString];
        }
        else {
            @throw [NSException exceptionWithName:@"未实现" reason:@"只实现Json/String数据解析" userInfo:nil];
        }
    }
    return self;
}

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [self init];
    if (self) {
        _isError = handler.isError;
        if (_error) {
            _error = nil;
        }
        _error = handler.error;
        _responseFormat = handler.responseFormat;
        if (_responseData) {
            _responseData = nil;
        }
        _responseData = responseData;
    }
    return self;
}


- (BBGResponseData *)parseJson:(NSData *)jsonData {
    id data = nil;
    @try {
        NSError *error = nil;
        data = [jsonData objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&error];
        if (error) {
            data = nil;
        }
    } @catch (NSException *e) {
        data = nil;
    }
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:data];
    return responseData;
}

- (BBGResponseData *)parseXml:(NSData *)xmlData {
    //TODO:未实现
    return nil;
}

@end