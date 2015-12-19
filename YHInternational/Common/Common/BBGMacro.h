//
//  BBGMacro.h
//  Common
//
//  Created by Damon on 15/4/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

/*!
 *  转换16进制颜色为UIColor对象
 *
 *  @param rgbValue RGB色值，如(0xff0000)
 *
 *  @return UIColor对象
 */
#define UIColorFromHexadecimalRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#pragma mark- 全球购App颜色规范
//字体颜色部分
#define UICOLOR_FONT_IMPORTANT_RED UIColorFromHexadecimalRGB(0xf03468)
#define UICOLOR_FONT_IMPORTANT_BLACK UIColorFromHexadecimalRGB(0x333333)
#define UICOLOR_FONT_GENERAL_GRAY UIColorFromHexadecimalRGB(0x666666)
#define UICOLOR_FONT_GENERAL_GRAYLIGHT UIColorFromHexadecimalRGB(0x999999)
#define UICOLOR_FONT_WEAK_GRAYLIGHT UIColorFromHexadecimalRGB(0xc0c0c0)
//背景色部分
#define UICOLOR_BACKGROUND_GRAYLIGHT UIColorFromHexadecimalRGB(0xf0efed)
#define UICOLOR_BACKGROUND_GRAYWHITE UIColorFromHexadecimalRGB(0xffffff)
#define UICOLOR_BACKGROUND_HILIGHT_GRAY UIColorFromHexadecimalRGB(0xececec)
//cell分割线
#define RGB_CELL_GRAY UIColorFromHexadecimalRGB(0xfe5e5e5)


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//字体
#define APP_FONT(fsize) [UIFont fontWithName:@"NotoSansHans-Light" size:fsize]

#define APP_FONT_DEMI_LIGHT(fsize) [UIFont fontWithName:@"NotoSansHans-DemiLight" size:fsize]


///判断是否运行在模拟器中
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IOS_VERSION [[[UIDevice currentDevice]systemVersion] floatValue]

///判断iOS系统版本
#define isIOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define isIOS4 [[[UIDevice currentDevice]systemVersion] floatValue] < 5.0

//判断设备
#define isDeviceIphone5 CGSizeEqualToSize([UIScreen mainScreen].currentMode.size, CGSizeMake(640, 1136))

#define KEYWindow ([UIApplication sharedApplication].keyWindow)

#define TICK_START   NSDate *tickTime = [NSDate date];
#define TICK_END   NSLog(@"Time: %f", -[tickTime timeIntervalSinceNow]);

#define IPHONE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CCP(x,y) CGPointMake(x,y)
#define CCS(w,h) CGSizeMake(w,h)
#define CCR(x,y,w,h) CGRectMake(x,y,w,h)

#define FRAMEX(v) (v.frame.origin.x)
#define FRAMEY(v) (v.frame.origin.y)
#define FRAMEW(v) (v.frame.size.width)
#define FRAMEH(v) (v.frame.size.height)
#define XRIGHT(v) (v.frame.origin.x + v.frame.size.width)
#define YBOTTOM(v) (v.frame.origin.y + v.frame.size.height)

#define TRANS_X(__x) (((__x)/375.0)*IPHONE_WIDTH)
#define TRANS_Y(__y) (((__y)/667.0)*IPHONE_HEIGHT)
#define TRANS_W(__w) (((__w)/375.0)*IPHONE_WIDTH)
#define TRANS_H(__h) (((__h)/667.0)*IPHONE_HEIGHT)

#define RGB_COLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define DEBUG_COLOR [BBGTools randomColor]  //[BBGTools randomColor] [UIColor clearColor]


#define isiPadClient UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

///获取居中的CGRect
#define CGRectCenter(superRect,subRect) \
CGRectMake((superRect.size.width-subRect.size.width)/2, (superRect.size.height-subRect.size.height)/2,  subRect.size.width, subRect.size.height)

///设置视图frame的x
#define CGRectSetX(viewRect,x) \
CGRectMake(x, view.origin.y, view.size.width, view.size.height)

///设置视图frame的y
#define CGRectSetY(viewRect,y) \
CGRectMake(viewRect.origin.x, y, viewRect.size.width, viewRect.size.height)
//获取视图的高
#define GETHEIGHT(view) CGRectGetHeight(view.frame)
//获取视图的宽
#define GETWIDTH(view) CGRectGetWidth(view.frame)
//获取视图的X坐标
#define GETORIGIN_X(view) view.frame.origin.x
//获取视图的Y坐标
#define GETORIGIN_Y(view) view.frame.origin.y
//获取下一个视图的X坐标
#define GETRIGHTORIGIN_X(view) view.frame.origin.x + CGRectGetWidth(view.frame)
//获取下一个视图的Y坐标
#define GETBOTTOMORIGIN_Y(view) view.frame.origin.y + CGRectGetHeight(view.frame)
//拉伸图片
#define _ResizeImage(image)  ([image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height / 2, image.size.width / 2, image.size.height / 2 - 1, image.size.width / 2 - 1)])

#define  SessionIsTemporaryLogin    (([[BBGSession sharedInstance] passport] != nil) && ([[[BBGSession sharedInstance] passport] lifeType]==0))
#define  SessionIsPermanentLogin    (([[BBGSession sharedInstance] passport] != nil) && ([[[BBGSession sharedInstance] passport] lifeType]>0))
#define  SessionIsNotLogin          [[BBGSession sharedInstance] passport] == nil

#define IsAvailablePhoneNumber(phoneNumber) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1([3578]\\d|4[57])\\d{8}$"] evaluateWithObject:phoneNumber]


#define ARRAY_OBJ_AT(index) My_objectAtIndex:(index) File:__FILE__ Line:__LINE__
#define ARRAY_ADD_OBJ(obj) My_addObject:(obj) File:__FILE__ Line:__LINE__
#define ARRAY_ADD_OBJS_FROM_ARRAY(objs) My_addObjectsFromArray:(objs) File:__FILE__ Line:__LINE__
#define ARRAY_INSERT_OBJ_AT(obj,index)My_insertObject:(obj) atIndex:index File:__FILE__ Line:__LINE__
#define ARRAY_REMOVEOBJ_AT(index) My_removeObjectAtIndex:(index) File:__FILE__ Line:__LINE__
#define ARRAY_REMOVE_ALLOBJ My_removeAllObjects_File:__FILE__ Line:__LINE__
#define ARRAY_REMOVE_OBJ(obj) My_removeObject:(obj) File:__FILE__ Line:__LINE__
#define ARRAY_JOIN_BY(sep) MY_joinByString:(sep) File:__FILE__ Line:__LINE__

#define DICT_SET_VK(value,key) My_setObject:value forKey:key File:__FILE__ Line:__LINE__
#define DICT_SET_DICT(dict) My_setDict:dict File:__FILE__ Line:__LINE__
#define DICT_HAS_K(key) My_hasKey:key File:__FILE__ Line:__LINE__
#define DICT_REMOVEOBJ_K(key) My_removeObjectForKey:key File:__FILE__ Line:__LINE__
#define DICT_REMOVEOBJS_KS(keys) My_removeObjectsForKeys:keys File:__FILE__ Line:__LINE__
#define DICT_OBJ_FOR_K(key) My_objectForKey:(key) File:__FILE__ Line:__LINE__
#define DICT_ALL_KS My_allKeys_File:__FILE__ Line:__LINE__
#define DICT_ALL_VS My_allValues_File:__FILE__ Line:__LINE__
#define DICT_REMOVE_ALLOBJ My_removeAllObjects_File:__FILE__ Line:__LINE__

#define COUNT My_count_File:__FILE__ Line:__LINE__




///声明为单例类
///需要在@interface中声明以下函数原型
///+ (className *)sharedInstance
#define DECLARE_SINGLETON_B(className) \
static className *singletonInstance = nil; \
\
+ (className *)sharedInstance { \
@synchronized (self) { \
if (!singletonInstance) { \
[[self alloc] init]; \
} \
} \
return singletonInstance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized (self) { \
if (!singletonInstance) { \
singletonInstance = [super allocWithZone:zone]; \
return singletonInstance; \
} \
} \
return nil; \
} \
\

#define DECLARE_SINGLETON_A(className) \
static className *singletonInstance = nil; \
+ (className *)sharedInstance { \
@synchronized (self) { \
if (!singletonInstance) { \
singletonInstance = [[self alloc] init]; \
} \
return singletonInstance; \
} \
} \

#ifdef DEBUG
#define DECLARE_SINGLETON DECLARE_SINGLETON_A
#else
#define DECLARE_SINGLETON DECLARE_SINGLETON_B
#endif

typedef enum{
    BBGLoginTypeMobile = 0,
    BBGLoginTypeQQ,
    BBGLoginTypeWebChat,
    BBGLoginTypeSina,
    BBGLoginTypeFastMobile
}BBGLoginType;
