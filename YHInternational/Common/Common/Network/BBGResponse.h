//
// 名称：BBGResponse
// 注释：接口应答基类
//      提供所有网络应答的基类
// 作者：william zhao
// 日期：2013-09-30
//

#import "BBGResponseDataHandler.h"

/*!
 *  网络应答抽象类
 */
@interface BBGResponse : BBGResponseDataHandler {
@private
    BOOL _isCache;
    NSData *_data;
}

/*!
 *  应答是否为缓存
 */
@property(nonatomic, readonly) BOOL isCache;
/*!
 *  错误信息
 */
@property (nonatomic, strong) NSString *errorMsg;
/**
 *  错误状态码
 */
@property (nonatomic, strong) NSString* errorCode;
/**
 *  返回状态码
 */
//@property (nonatomic, strong) NSString *statusCode;

/**
 *  特殊字段显示提示
 */
@property (nonatomic, strong) NSString* tmessage;
@end