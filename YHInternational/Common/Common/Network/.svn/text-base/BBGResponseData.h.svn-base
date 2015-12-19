//
// Created by William Zhao on 13-7-4.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#define CHECK_DATA_TYPE(data,type,error) CHECK_DATA_TYPE_VALUE(data,type,nil,error)
#define CHECK_ARRAY_INDEX(index,count,error) CHECK_ARRAY_INDEX_VALUE(index,count,nil,error)
#define CHECK_DICTIONARY_KEY(key,data,error) CHECK_DICTIONARY_KEY_VALUE(key,data,nil,error)
/*!
 *  网络应答的数据格式
 */
typedef enum {
    ResponseDataFormatJson = 0,
    ResponseDataFormatXml,
    ResponseDataFormatString
} ResponseDataFormat;

/*!
 *  网络应答的数据类型
 */
typedef enum {
    ResponseDataUnknown = 0,
    ResponseDataNone,
    ResponseDataNull,
    ResponseDataNumber,
    ResponseDataString,
    ResponseDataArray,
    ResponseDataDictionary
} ResponseDataType;

/*!
 *  网络应答数据类
 */
@interface BBGResponseData : NSObject {
@private
    id _data;
    BOOL _isAllowNull;
    ResponseDataType _dataType;
}

- (id)initWithData:(id)data;

/**
 *  原始数据
 */
@property(nonatomic, strong, readonly) id data;
/*!
 *  网络应答的数据类型
 */
@property(nonatomic, readonly) ResponseDataType dataType;

/*!
 *  是否允许空值
 */
@property(nonatomic, assign) BOOL isAllowNull;

/*!
 *  数据是否为空值
 *
 *  @return bool
 */
- (BOOL)isNull;

/*!
 *  指定key数据是否为空值
 *
 *  @param key key
 *
 *  @return bool
 */
- (BOOL)isNullForKey:(NSString *)key;

/*!
 *  获取字符串，支持字符串类型以及数字类型
 *
 *  @return NSString
 */
- (NSString *)stringValue;

/*!
 *  获取字符串，支持字符串类型以及数字类型
 *
 *  @param error NSError
 *
 *  @return NSString
 */
- (NSString *)stringValue:(NSError * __strong *)error;

/*!
 *  获取数字，支持数字类型和字符串类型
 *
 *  @return NSNumber
 */
- (NSNumber *)numberValue;

/*!
 *  获取数字，支持数字类型和字符串类型
 *
 *  @param error NSError
 *
 *  @return NSNumber
 */
- (NSNumber *)numberValue:(NSError * __strong *)error;

/*!
 *  获取布尔值，支持true/false，字符串类型（“0”，“false”，“1”，“true”），数字类型（0为假，非0为真）
 *
 *  @return bool
 */
- (BOOL)boolValue;

/*!
 *  获取布尔值，支持true/false，字符串类型（“0”，“false”，“1”，“true”），数字类型（0为假，非0为真）
 *
 *  @param error NSError
 *
 *  @return BOOL
 */
- (BOOL)boolValue:(NSError * __strong *)error;

/*!
 *  获取时间戳，支持字符串类型，数字类型
 *
 *  @return NSDate
 */
- (NSDate *)timestampValue;

/*!
 *  获取时间戳，支持字符串类型，数字类型
 *
 *  @param error NSError
 *
 *  @return NSDate
 */
- (NSDate *)timestampValue:(NSError * __strong *)error;

/*!
 *  获取日期，支持字符串类型
 *
 *  @param formatter NSDateFormatter
 *
 *  @return NSDate
 */
- (NSDate *)dateTimeValue:(NSDateFormatter *)formatter;

/*!
 *  获取日期，支持字符串类型
 *
 *  @param formatter NSDateFormatter
 *  @param error     NSError
 *
 *  @return NSDate
 */
- (NSDate *)dateTimeValue:(NSDateFormatter *)formatter error:(NSError * __strong *)error;

/*!
 *  获取当前数据的总数
 *
 *  @return NSUInteger
 */
- (NSUInteger)count;

/**
 *  获取当前字典的所有Key
 *
 *  @return NSArray
 */
- (NSArray *)allKeys;
/*!
 *  获取字符串从指定索引
 *
 *  @param index NSUInteger
 *  @param error NSError
 *
 *  @return NSString
 */
- (NSString *)stringForIndex:(NSUInteger)index error:(NSError * __strong *)error;

/*!
 *  获取Number从指定索引
 *
 *  @param index NSUInteger
 *  @param error NSError
 *
 *  @return NSNumber
 */
- (NSNumber *)numberForIndex:(NSUInteger)index error:(NSError * __strong *)error;

/*!
 *  获取布尔值从指定索引
 *
 *  @param index NSUInteger
 *  @param error NSError
 *
 *  @return BOOL
 */
- (BOOL)boolForIndex:(NSUInteger)index error:(NSError * __strong *)error;

/*!
 *  获取时间戳从指定索引
 *
 *  @param index NSUInteger
 *  @param error NSError
 *
 *  @return NSDate
 */
- (NSDate *)timestampForIndex:(NSUInteger)index error:(NSError * __strong *)error;

/*!
 *  获取日期从指定索引
 *
 *  @param index     NSUInteger
 *  @param formatter NSDateFormatter
 *  @param error     NSError
 *
 *  @return NSDate
 */
- (NSDate *)dateTimeForIndex:(NSUInteger)index formater:(NSDateFormatter *)formatter error:(NSError * __strong *)error;

/*!
 *  获取数据从指定索引
 *
 *  @param index NSUInteger
 *  @param error NSError
 *
 *  @return 网络应答的数据类型
 */
- (BBGResponseData *)dataForIndex:(NSUInteger)index error:(NSError * __strong *)error;

/*!
 *  获取字符串从指定键值
 *
 *  @param key   NSString
 *  @param error NSError
 *
 *  @return NSString
 */
- (NSString *)stringForKey:(NSString *)key error:(NSError * __strong *)error;

/*!
 *  获取Number从指定键值
 *
 *  @param key   NSString
 *  @param error NSError
 *
 *  @return NSNumber
 */
- (NSNumber *)numberForKey:(NSString *)key error:(NSError * __strong *)error;

/*!
 *  获取布尔值从指定键值
 *
 *  @param key   NSString
 *  @param error NSError
 *
 *  @return BOOL
 */
- (BOOL)boolForKey:(NSString *)key error:(NSError * __strong *)error;

/*!
 *  获取时间戳从指定键值
 *
 *  @param key   NSString
 *  @param error NSError
 *
 *  @return NSDate
 */
- (NSDate *)timestampForKey:(NSString *)key error:(NSError * __strong *)error;

/*!
 *  获取日期从指定键值
 *
 *  @param key       NSString
 *  @param formatter NSDateFormatter
 *  @param error     NSError
 *
 *  @return NSDate
 */
- (NSDate *)dateTimeForKey:(NSString *)key formatter:(NSDateFormatter *)formatter error:(NSError * __strong *)error;

/*!
 *  获取数据从指定键值
 *
 *  @param key   NSString
 *  @param error NSError
 *
 *  @return 网络应答的数据类型
 */
- (BBGResponseData *)dataForKey:(NSString *)key error:(NSError * __strong *)error;

/*!
 * 获取指定key的数据类型
 *
 * @param key key
 *
 * @return 数据类型
 */
- (ResponseDataType)typeForKey:(NSString*)key;

@end