//
// 名称：BBGParameters
// 注释：参数类
//      提供参数管理，参数签名等功能
// 作者：william zhao
// 日期：2013-09-30
//


#import <Foundation/Foundation.h>

/*!
 *  参数集合类
 */
@interface BBGParameters : NSObject {
@protected
    NSMutableDictionary *_dictionary;

}
//初始化参数集合
/*!
 *  初始化参数集合
 *
 *  @param parameters parameters
 *
 *  @return self
 */
- (id)initWithParameters:(NSString *)parameters;

/*!
 *  获取参数集合的签名
 *
 *  @return [signString md5String]
 */
- (NSString *)signString;

/*!
 *  构建系统参数为字符串
 *
 *  @return NSString
 */
- (NSString *)buildSystemParameters;

/*!
 *  @author Damon, 15-04-07 17:04:53
 *
 *  构建Params参数
 *
 *  @return 参数
 */
- (NSString *)buildParameters;

/*!
 *  获取参数集合的字典
 *
 *  @return NSDictionary
 */
- (NSDictionary*)dictionary;

/*!
 *  参数总数
 *
 *  @return NSInteger
 */
- (NSInteger)count;

/*!
 *  比较参数是否一致
 *
 *  @param parameters parameters
 *
 *  @return bool
 */
- (BOOL)isEqualToParameters:(NSString *)parameters;
@end

/*!
 *  可变参数集合类
 */
@interface BBGMutableParameters : BBGParameters {
}
/*!
 *  新增一个参数
 *
 *  @param value value
 *  @param key   key
 */
- (void)addParameter:(id)value forKey:(NSString *)key;

/*!
 *  移除一个参数
 *
 *  @param key key
 */
- (void)removeParameter:(NSString *)key;

/*!
 *  清空参数集合
 */
- (void)clearAllParameter;

/*!
 *  获取一个参数
 *
 *  @param key key
 *
 *  @return value
 */
-(id)getParameter:(NSString *)key;

@end