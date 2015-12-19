//
//  BBGTools.h
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGTools : NSObject

+ (BOOL)checkStringIsBlank:(NSString*)str;

+ (NSDateFormatter*)dateFormatter;

+ (NSString*)timeToString:(double)unixtime Format:(NSString*)formatStr;

/**
 *  检测是否中文
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateChinese:(NSString *)str;

/**
 *  检测是否身份证
 *
 *  @param identityCard <#identityCard description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;


/**
 *  随机颜色
 *
 *  @return <#return value description#>
 */
+ (UIColor *)randomColor;

/**
 *  cell上的组件得到cell
 *
 *  @param obj 组件
 *
 *  @return UITableViewCell
 */
+ (UITableViewCell *)tableViewCell:(id)obj;



/**
 *  拨打电话
 *
 *  @param phoneNumber <#phoneNumber description#>
 *  @param title       提示文字
 */
+ (void)callPhone:(NSString*)phoneNumber alertTitle:(NSString*)title;
@end


@interface UIImage (CS_Extensions)
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage*)reSizeImage:(CGSize)maxSize;
@end

@interface UIButton (ExtentionButton)
+ (UIButton*)buttonWithMyImage:(NSString*)imageName;
+ (UIButton*)buttonWithMyImage:(NSString*)imageName stretchInset:(UIEdgeInsets)inset;
+ (UIButton*)buttonWithMyImage:(NSString *)imageName Frame:(CGRect)rect;
+ (UIButton*)buttonWithName:(NSString *)name Price:(float)price;
+ (UIButton*)buttonWithTitle:(NSString*)title color:(UIColor*)_color;
+ (UIButton*)buttonWithTitle:(NSString*)title color:(UIColor*)_color rect:(CGRect)_rect;
@end

@interface UIImageView(ExtentionImageView)
+ (UIImageView*) imageViewWithMyImage:(NSString*)imageName;
+ (UIImageView*) imageViewWithMyImage:(NSString*)imageName stretchInset:(UIEdgeInsets)inset;
@end

//超级容错
@interface NSObject (SuperFaultTolerant)

/**
 *  返回数组指定索引位置的元素
 *  eg:ARRAY_OBJ_AT(1)
 *  @return obj
 */
- (id)ARRAY_OBJ_AT;

/**
 *  尾部追加一个元素
 *  eg:ARRAY_ADD_OBJ(@@"name")
 */
- (void)ARRAY_ADD_OBJ;

/**
 *  尾部追加一个数组
 *  eg:ARRAY_ADD_OBJS_FROM_ARRAY(NSArray)
 */
- (void)ARRAY_ADD_OBJS_FROM_ARRAY;

/**
 *  在指定索引处插入一个元素
 *  eg:ARRAY_INSERT_OBJ_AT(@@"name",1)
 */
- (void)ARRAY_INSERT_OBJ_AT;

/**
 *  删除对应索引位置的元素
 *  eg:ARRAY_REMOVEOBJ_AT(1)
 */
- (void)ARRAY_REMOVEOBJ_AT;

/**
 *  删除对应元素
 *  eg :ARRAY_REMOVE_OBJ(@@"name")
 */
- (void)ARRAY_REMOVE_OBJ;


/**
 *  通过key查找对应的value
 *  eg:DICT_OBJ_FOR_K(@@"name")
 *  @return obj
 */
- (id)DICT_OBJ_FOR_K;

/**
 *  赋值替换键值对
 *  eg:DICT_SET_VK(@@"小黑",@@"name")
 */
- (void)DICT_SET_VK;

/**
 *  删除指定key的键值对
 *  eg:DICT_REMOVEOBJ_K(@@"name")
 */
- (void)DICT_REMOVEOBJ_K;

/**
 *  等效于先removeAllObjects后addObjectsFromArray
 *  eg:DICT_SET_DICT(NSDictionary)
 */
- (void)DICT_SET_DICT;

/**
 *  是否存在key对应的值
 *  eg:DICT_HAS_K(@@"name")
 *  @return 布尔值
 */
- (BOOL)DICT_HAS_K;

/**
 *  删除指定key数组对应的键值对
 *  DICT_REMOVEOBJS_KS(NSArray)
 */
- (void)DICT_REMOVEOBJS_KS;

-(void)My_removeObjectAtIndex:(NSInteger)index File:(char*)file Line:(int)line; //NSMutableArray
-(void)My_removeAllObjects_File:(char*)file Line:(int)line; //NSMutableArray
-(void)My_removeObject:(id)obj File:(char*)file Line:(int)line; //NSMutableArray
-(NSString*)MY_joinByString:(NSString*)sep File:(char*)file Line:(int)line; //NSArray

-(id)My_objectAtIndex:(NSInteger)index File:(char*)file Line:(int)line; //NSArray
-(void)My_setObject:(id)value forKey:(id)key File:(char*)file Line:(int)line; //NSMutableDictionary
-(void)My_setDict:(NSDictionary*)dict File:(char*)file Line:(int)line; //NSMutableDictionary
-(void)My_removeObjectForKey:(id)key File:(char*)file Line:(int)line;
-(void)My_removeObjectsForKeys:(NSArray*)keys File:(char*)file Line:(int)line;
-(BOOL)My_hasKey:(id)key File:(char*)file Line:(int)line;//NSDictionary

- (int)My_count_File:(char*)file Line:(int)line;
- (id)My_objectForKey:(id)aKey File:(char*)file Line:(int)line;
- (NSArray *)My_allKeys_File:(char*)file Line:(int)line;
- (NSArray *)My_allValues_File:(char*)file Line:(int)line;
- (void)My_addObject:(id)anObject File:(char*)file Line:(int)line;
- (void)My_addObjectsFromArray:(NSArray*)objs File:(char*)file Line:(int)line;
- (void)My_insertObject:(id)anObject atIndex:(NSInteger)index File:(char*)file Line:(int)line;
-(int)My_length_File:(char*)file Line:(int)line;

-(void)My_setString:(NSString*)str File:(char*)file Line:(int)line;


-(void)performBlock:(void (^)(void))block Delay:(float)delay;

@end


NSString *NSStringFromOBJPointer(id obj);
NSString *NSStringFromInt(NSInteger num);
NSString *NSStringFromFloat(float num);
NSString *NSStringFromNumber(id obj);
