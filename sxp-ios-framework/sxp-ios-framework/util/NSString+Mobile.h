//
//  NSString+Mobile.h
//  apos-enterprise-ios
//
//  Created by shanxiaoping on 15-2-10.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Mobile)


typedef NS_ENUM(NSUInteger,MHMobileNubmerType)
{
    //不是手机号
    MHMobileNubmerType_NONE = 0,
    //中国移动
    MHMobileNubmerType_CM,
    //中国联通
    MHMobileNubmerType_CU,
    //中国电信
    MHMobileNubmerType_CT,
    //其他未知
    MHMobileNubmerType_OTHER
};
- (MHMobileNubmerType)isMobileNumber;
@end
