//
// Created by William Zhao on 13-7-10.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BBGResponseData.h"

#define CHECK_DATA_ERROR() \
        if(_error!=nil){ \
            _isError = YES; \
        }
#define STRING_FOR_KEY_DATA(value,key,data) \
        value = [data stringForKey:key error:&_error]; \
        CHECK_DATA_ERROR()

#define NUMBER_FOR_KEY_DATA(value,key,data) \
        value = [data numberForKey:key error:&_error]; \
        CHECK_DATA_ERROR()

#define INTEGER_FOR_KEY_DATA(value,key,data) \
        value = [[data numberForKey:key error:&_error] integerValue]; \
        CHECK_DATA_ERROR()

#define FLOAT_FOR_KEY_DATA(value,key,data) \
        value = [[data numberForKey:key error:&_error] floatValue]; \
        CHECK_DATA_ERROR()

#define DOUBLE_FOR_KEY_DATA(value,key,data) \
        value = [[data numberForKey:key error:&_error] doubleValue]; \
        CHECK_DATA_ERROR()

#define BOOL_FOR_KEY_DATA(value,key,data) \
        value = [data boolForKey:key error:&_error]; \
        CHECK_DATA_ERROR()

#define TIMESTAMP_FOR_KEY_DATA(value,key,data) \
        value = [data timestampForKey:key error:&_error]; \
        CHECK_DATA_ERROR()

#define DATETIME_FOR_KEY_DATA(value,key,df,data) \
        value = [data dateTimeForKey:key formatter:df error:&_error]; \
        CHECK_DATA_ERROR()

#define DATA_FOR_KEY_DATA(value,key,data) \
        value = [data dataForKey:key error:&_error]; \
        CHECK_DATA_ERROR()

#define STRING_FOR_INDEX_DATA(value,index,data) \
        value = [data stringForIndex:index error:&_error]; \
        CHECK_DATA_ERROR()

#define NUMBER_FOR_INDEX_DATA(value,index,data) \
        value = [data numberForIndex:index error:&_error]; \
        CHECK_DATA_ERROR()

#define BOOL_FOR_INDEX_DATA(value,index,data) \
        value = [data boolForIndex:index error:&_error]; \
        CHECK_DATA_ERROR()

#define TIMESTAMP_FOR_INDEX_DATA(value,index,data) \
        value = [data timestampForIndex:index error:&_error]; \
        CHECK_DATA_ERROR()

#define DATETIME_FOR_INDEX_DATA(value,index,df,data) \
        value = [data dateTimeForIndex:index formatter:df error:&_error]; \
        CHECK_DATA_ERROR()

#define DATA_FOR_INDEX_DATA(value,index,data) \
        value = [data dataForIndex:index error:&_error]; \
        CHECK_DATA_ERROR()

#define STRING_FOR_KEY(value,key) STRING_FOR_KEY_DATA(value,key,self.responseData)
#define NUMBER_FOR_KEY(value,key) NUMBER_FOR_KEY_DATA(value,key,self.responseData)
#define INTEGER_FOR_KEY(value,key) INTEGER_FOR_KEY_DATA(value,key,self.responseData)
#define FLOAT_FOR_KEY(value,key) FLOAT_FOR_KEY_DATA(value,key,self.responseData)
#define DOUBLE_FOR_KEY(value,key) DOUBLE_FOR_KEY_DATA(value,key,self.responseData)
#define BOOL_FOR_KEY(value,key) BOOL_FOR_KEY_DATA(value,key,self.responseData)
#define TIMESTAMP_FOR_KEY(value,key) TIMESTAMP_FOR_KEY_DATA(value,key,self.responseData)
#define DATETIME_FOR_KEY(value,key,df) DATETIME_FOR_KEY_DATA(value,key,df,self.responseData)
#define DATA_FOR_KEY(value,key) DATA_FOR_KEY_DATA(value,key,self.responseData)
#define STRING_FOR_INDEX(value,index) STRING_FOR_INDEX_DATA(value,index,self.responseData)
#define NUMBER_FOR_INDEX(value,index) NUMBER_FOR_INDEX_DATA(value,index,self.responseData)
#define BOOL_FOR_INDEX(value,index) BOOL_FOR_INDEX_DATA(value,index,self.responseData)
#define TIMESTAMP_FOR_INDEX(value,index) TIMESTAMP_FOR_INDEX_DATA(value,index,self.responseData)
#define DATETIME_FOR_INDEX(value,index,df) DATETIME_FOR_INDEX_DATA(value,index,df,self.responseData)
#define DATA_FOR_INDEX(value,index) DATA_FOR_INDEX_DATA(value,index,self.responseData)

/*!
 *  应答数据处理类
 */
@interface BBGResponseDataHandler : NSObject {
@private
    /*!
     *  网络应答的数据格式
     */
    ResponseDataFormat _responseFormat;
    /*!
     *  网络应答数据类
     */
    BBGResponseData *_responseData;
@protected
    NSError *_error;
    BOOL _isError;
}

/*!
 *  初始化
 *
 *  @param data   NSData
 *  @param format 网络应答的数据格式
 *
 *  @return BBGResponseDataHandler
 */
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format;

/*!
 *  初始化
 *
 *  @param handler      应答数据处理类
 *  @param responseData 网络应答数据类
 *
 *  @return BBGResponseDataHandler
 */
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData;

/*!
 *  数据格式_standardFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss"
 */
@property(nonatomic, readonly) NSDateFormatter *standardFormatter;

/*!
 *  数据是否错误
 */
@property(nonatomic, readonly) BOOL isError;
/*!
 *  错误信息
 */
@property(nonatomic, readonly) NSError *error;
/*!
 *  数据的格式
 */
@property(nonatomic, readonly) ResponseDataFormat responseFormat;
/*!
 *  应答的数据
 */
@property(nonatomic, readonly) BBGResponseData *responseData;

@end