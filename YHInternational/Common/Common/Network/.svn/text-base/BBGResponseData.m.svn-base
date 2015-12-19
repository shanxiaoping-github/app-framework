//
// Created by William Zhao on 13-7-4.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#define CHECK_DATA_TYPE_VALUE(data,type,value,error) \
    if(data!=type){ \
        if(error!=nil) *error = [NSError errorWithDomain:@"com.vipshop.DataTypeError" code:0 userInfo:nil]; \
        return value; \
    }

#define CHECK_ARRAY_INDEX_VALUE(index,count,value,error) \
    if(index>= count) { \
        if(error!=nil) *error = [NSError errorWithDomain:@"com.vipshop.IndexError" code:0 userInfo:nil]; \
        return value; \
    }

#define CHECK_DICTIONARY_KEY_VALUE(key,data,value,error) \
    if(key==nil){ \
        if(error!=nil) *error = [NSError errorWithDomain:@"com.vipshop.KeyError" code:0 userInfo:nil]; \
        return value; \
    }





#import "BBGResponseData.h"

@implementation BBGResponseData

@synthesize dataType = _dataType;
@synthesize isAllowNull = _isAllowNull;

- (id)initWithData:(id)data {
    self = [super init];
    if (self) {
        if (data == nil)
            _dataType = ResponseDataNone;
        else if ([data isKindOfClass:[NSNull class]])
            _dataType = ResponseDataNull;
        else if ([data isKindOfClass:[NSString class]])
            _dataType = ResponseDataString;
        else if ([data isKindOfClass:[NSNumber class]])
            _dataType = ResponseDataNumber;
        else if ([data isKindOfClass:[NSArray class]])
            _dataType = ResponseDataArray;
        else if ([data isKindOfClass:[NSDictionary class]])
            _dataType = ResponseDataDictionary;
        else
            _dataType = ResponseDataUnknown;

        _data = data;
        _isAllowNull = YES;
    }
    return self;
}


- (BOOL)isNull {
    return (_dataType == ResponseDataNull || _dataType == ResponseDataNone);
}

- (BOOL)isNullForKey:(NSString *)key {
    return _dataType != ResponseDataDictionary || [_data objectForKey:key] == nil;
}

- (NSString *)stringValue {
    return [self stringValue:nil];
}

//获取字符串，支持字符串类型以及数字类型
- (NSString *)stringValue:(NSError * __strong *)error {
    if ([self isNull] && _isAllowNull) return nil;
    if (_dataType == ResponseDataString) {
        return _data;
    }
    if (_dataType == ResponseDataNumber) {
        return [_data stringValue];
    }
    if (error != nil) *error = [NSError errorWithDomain:@"com.vipshop.DataTypeError" code:0 userInfo:nil];
    return nil;
}

- (NSNumber *)numberValue {
    return [self numberValue:nil];
}

//获取数字，支持数字类型和字符串类型
- (NSNumber *)numberValue:(NSError * __strong *)error {
    if ([self isNull] && _isAllowNull) return nil;
    if (_dataType == ResponseDataNumber) {
        return _data;
    }
    if (_dataType == ResponseDataString) {
        NSScanner *scanner = [NSScanner scannerWithString:_data];
        double val;
        if ([scanner scanDouble:&val] && [scanner isAtEnd]) {
            return [NSNumber numberWithDouble:val];
        }
    }
    if (error != nil) *error = [NSError errorWithDomain:@"com.vipshop.DataTypeError" code:0 userInfo:nil];
    return nil;
}

- (BOOL)boolValue {
    return [self boolValue:nil];
}

//获取布尔值，支持true/false，字符串类型（“0”，“false”，“1”，“true”），数字类型（0为假，非0为真）
- (BOOL)boolValue:(NSError * __strong *)error {
    if ([self isNull] && _isAllowNull) return NO;
    if (_dataType == ResponseDataString) {
        if ([_data isEqualToString:@"0"] || [[_data lowercaseString] isEqualToString:@"false"])
            return NO;
        else if ([_data isEqualToString:@"1"] || [[_data lowercaseString] isEqualToString:@"true"])
            return YES;
        else
            goto errorHandle;
    }
    if (_dataType == ResponseDataNumber) {
        return [_data intValue] != 0;
    }
    errorHandle:
    if (error != nil)
        *error = [NSError errorWithDomain:@"com.vipshop.DataTypeError" code:0 userInfo:nil];
    return NO;
}

- (NSDate *)timestampValue {
    return [self timestampValue:nil];
}

//获取时间戳，支持字符串类型，数字类型
- (NSDate *)timestampValue:(NSError * __strong *)error {
    if ([self isNull] && _isAllowNull) return nil;
    if (_dataType == ResponseDataString) {
        NSScanner *scanner = [NSScanner scannerWithString:_data];
        NSInteger val;
        if ([scanner scanInteger:&val] && [scanner isAtEnd]) {
            return [NSDate dateWithTimeIntervalSince1970:val];
        }
        else
            goto errorHandle;
    }
    if (_dataType == ResponseDataNumber) {
        long long timestamp = [_data longLongValue];
        NSTimeInterval timeInterval =  timestamp / (int)1e+9 == 1 ? timestamp : timestamp / 1000.0;
        return [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
    errorHandle:
    if (error != nil)
        *error = [NSError errorWithDomain:@"com.vipshop.DataTypeError" code:0 userInfo:nil];
    return nil;
}


- (NSDate *)dateTimeValue:(NSDateFormatter *)formatter {
    return [self dateTimeValue:formatter error:nil];
}

//获取日期，支持字符串类型
- (NSDate *)dateTimeValue:(NSDateFormatter *)formatter error:(NSError * __strong *)error {
    if ([self isNull] && _isAllowNull) return nil;
    CHECK_DATA_TYPE(_dataType, ResponseDataString, error)
    return [formatter dateFromString:_data];
}

- (NSUInteger)count {
    if (_dataType == ResponseDataArray) return [_data count];
    if (_dataType == ResponseDataDictionary) return [_data count];
    return [self isNull] ? 0 : 0;
}

- (NSArray *)allKeys {
    if (_dataType == ResponseDataDictionary) return [_data allKeys];
    return nil;
}

- (NSString *)stringForIndex:(NSUInteger)index error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataArray, error)
            CHECK_ARRAY_INDEX(index, [self count], error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectAtIndex:index]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData stringValue:error];
}

- (NSNumber *)numberForIndex:(NSUInteger)index error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataArray, error)
            CHECK_ARRAY_INDEX(index, [self count], error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectAtIndex:index]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData numberValue:error];
}

- (BOOL)boolForIndex:(NSUInteger)index error:(NSError * __strong *)error {
    CHECK_DATA_TYPE_VALUE(_dataType, ResponseDataArray, NO, error)
    CHECK_ARRAY_INDEX_VALUE(index, [self count], NO, error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectAtIndex:index]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData boolValue:error];
}

- (NSDate *)timestampForIndex:(NSUInteger)index error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataArray, error)
            CHECK_ARRAY_INDEX(index, [self count], error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectAtIndex:index]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData timestampValue:error];
}

- (NSDate *)dateTimeForIndex:(NSUInteger)index formater:(NSDateFormatter *)formatter error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataArray, error)
            CHECK_ARRAY_INDEX(index, [self count], error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectAtIndex:index]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData dateTimeValue:formatter error:error];
}

- (BBGResponseData *)dataForIndex:(NSUInteger)index error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataArray, error)
            CHECK_ARRAY_INDEX(index, [self count], error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectAtIndex:index]];
    responseData.isAllowNull = _isAllowNull;
    return responseData;
}

- (NSString *)stringForKey:(NSString *)key error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataDictionary, error)
            CHECK_DICTIONARY_KEY(key, _data, error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectForKey:key]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData stringValue:error];
}

- (NSNumber *)numberForKey:(NSString *)key error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataDictionary, error)
            CHECK_DICTIONARY_KEY(key, _data, error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectForKey:key]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData numberValue:error];
}

- (BOOL)boolForKey:(NSString *)key error:(NSError * __strong *)error {
    CHECK_DATA_TYPE_VALUE(_dataType, ResponseDataDictionary, NO, error)
    CHECK_DICTIONARY_KEY_VALUE(key, _data, NO, error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectForKey:key]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData boolValue:error];
}

- (NSDate *)timestampForKey:(NSString *)key error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataDictionary, error)
            CHECK_DICTIONARY_KEY(key, _data, error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectForKey:key]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData timestampValue:error];
}

- (NSDate *)dateTimeForKey:(NSString *)key formatter:(NSDateFormatter *)formatter error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataDictionary, error)
            CHECK_DICTIONARY_KEY(key, _data, error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectForKey:key]];
    responseData.isAllowNull = _isAllowNull;
    return [responseData dateTimeValue:formatter error:error];
}

- (BBGResponseData *)dataForKey:(NSString *)key error:(NSError * __strong *)error {
    CHECK_DATA_TYPE(_dataType, ResponseDataDictionary, error)
            CHECK_DICTIONARY_KEY(key, _data, error)
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectForKey:key]];
    responseData.isAllowNull = _isAllowNull;
    return responseData;
}

- (ResponseDataType)typeForKey:(NSString*)key {
    BBGResponseData *responseData = [[BBGResponseData alloc] initWithData:[_data objectForKey:key]];
    return responseData.dataType;
}

- (NSString *)description {
    return [_data description];
}

@end