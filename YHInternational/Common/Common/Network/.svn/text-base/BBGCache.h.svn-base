//
// 名称：BBGCache
// 注释：缓存静态类，包括数据库缓存与文件缓存。
// 作者：william zhao
// 日期：2013-09-30
//

#import <Foundation/Foundation.h>

/*!
 *  缓存类型
 */
typedef enum {
    BBGCacheTypeNone = 0,
    BBGCacheTypeAPI,
    BBGCacheTypeImage,
    BBGCacheTypeStartupAd,
    BBGCacheTypeStatistics,
    BBGCacheTypeTodayLike,
    BBGCacheTypeRegions,
    BBGCacheTypeSearchHistory,//搜索历史
    BBGCacheTypeUserAddressList
} BBGCacheType;

#define KEYREGIONS @"REGIONS"           //商城行政区域
#define KEYNEWREGIONS @"NEWREGIONS"     //大会员行政区域
#define KEYUSER @"USERDATAS"
#define KEYUSERREGIONS @"USERREGIONS"
#define KEYMOBILEUSERREGION @"KEYMOBILEUSERREGION"
#define KEYLASTMOBILEUSERREGION @"KEYLASTMOBILEUSERREGION"    //用户最后一次定位到的位置（条件是定位到的地址在地址库中存在）
#define KEYUSERLIFEREGIONS @"USERLIFEREGIONS"
#define KEYUSERLOCATION @"USERLOCATION"
#define KEYUSERSELECTSEARCHADDRESSES @"KEYUSERSELECTSEARCHADDRESSES"  //用户选择的使用高德API搜索到的地址
#define KEYSEARCHHISTORY @"SEARCHHISTORY"    //搜索历史
#define KEYUSERADDRESSLIST @"USERADDRESSLIST"//用户地址列表
#define KEYUSERADDRESS     @"USERADDRESS"    //用户所选地址

#define KEYLAUNCHINFO @"LAUNCHINFO"
/*!
 *  缓存策略
 */
@interface BBGCachePolicy : NSObject<NSCopying>

+(id)cachePolicyWithCacheType:(BBGCacheType)cacheType;

-(id)initWithCacheType:(BBGCacheType)cacheType;

/*!
 *  缓存类型
 */
@property(nonatomic, assign) BBGCacheType cacheType;

/*!
 *  失效日期
 */
@property(nonatomic, strong) NSDate* expDate;

/*!
 *  是否使用文件缓存
 */
@property(nonatomic, assign) BOOL useFileCache;

@end

/*!
 *  缓存管理类
 */
@interface BBGCache : NSObject

/*!
 *  查询缓存
 *
 *  @param key key
 *
 *  @return 返回某类型的所有数据。如果缓存不存在或已经失效，返回nil
 */
+ (id)queryCache:(NSString *)key;

/*!
 *  查询缓存，返回某类型的所有数据
 *
 *  @param type BBGCacheType-缓存类型
 *
 *  @return 返回某类型的所有数据
 */
+ (NSArray *)queryCacheForType:(BBGCacheType)type;

/*!
 *  查询缓存，返回某类型的所有数据
 *
 *  @param type     BBGCacheType-缓存类型
 *  @param maxCount 最大返回数量
 *
 *  @return 返回某类型的所有数据
 */
+ (NSArray *)queryCacheForType:(BBGCacheType)type maxCount:(NSInteger)maxCount;

/*!
 *  查询某类型数据条数
 *
 *  @param type BBGCacheType-缓存类型
 *
 *  @return 某类型数据条数
 */
+ (NSInteger)queryCacheCountForType:(BBGCacheType)type;

/*!
 *  缓存数据的路径
 *
 *  @return 缓存数据的路径
 */
+ (NSString *)dbPath;

/*!
 *  清除图片缓存
 *
 *
 */
+ (void)clearCache;

/*!
 *  缓存量达到峰值，清除指定大小的图片缓存
 *
 *  @param maxsize    最大缓存量
 *  @param clearsize  删除的缓存量
 *
 */
+ (void)clearCacheWithMaxSize:(long)maxsize clearSize:(long)clearsize;

/*!
 *  缓存数据的锁
 *
 *  @return 缓存数据的锁
 */
+ (NSLock *)dbLock;

/*!
 *  添加缓存
 *
 *  @param key key
 *  @param obj object
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj;
/*!
 *  添加缓存
 *
 *  @param key    key
 *  @param obj    object
 *  @param policy 缓存策略
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj policy:(BBGCachePolicy*)policy;
/*!
 *  添加缓存
 *
 *  @param key  key
 *  @param obj  object
 *  @param type BBGCacheType-缓存类型
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj type:(BBGCacheType)type;
/*!
 *  添加缓存
 *
 *  @param key     key
 *  @param obj     object
 *  @param type    BBGCacheType-缓存类型
 *  @param expDate 失效日期
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj type:(BBGCacheType)type expDate:(NSDate *)expDate;

/*!
 *  删除指定key缓存
 *
 *  @param key key
 */
+ (void)removeCacheForKey:(NSString *)key;

/*!
 *  删除指定type缓存
 *
 *  @param type BBGCacheType-缓存类型
 */
+ (void)removeCacheForType:(BBGCacheType)type;


/*!
 *  删除所有缓存
 */
+ (void)removeAllCache;
@end