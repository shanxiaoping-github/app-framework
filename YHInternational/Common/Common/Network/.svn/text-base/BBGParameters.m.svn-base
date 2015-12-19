//
// Created by William Zhao on 13-6-26.
// Copyright (c) 2013 Vipshop Holdings Limited. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BBGParameters.h"
#import "BBGConstants.h"
#import "NSString+Encryption.h"
#import "JSONKit.h"
@implementation BBGParameters

- (id)init {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithParameters:(NSString *)parameters {
    self = [self init];
    if (self) {
        if (parameters) {
            NSArray *components = [parameters componentsSeparatedByString:@"&"];
            for (NSString *component in components) {
                NSArray *subComponents = [component componentsSeparatedByString:@"="];
                if ([subComponents count] == 2) {
                    [_dictionary setObject:[subComponents objectAtIndex:1] forKey:[subComponents objectAtIndex:0]];
                }
            }
        }
    }
    return self;
}


- (NSString *)signString {
    if ([self count] == 0) return @"";
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *sortedKeys = [[_dictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    NSMutableString *signString = [NSMutableString stringWithString:@""];
    for (NSString *key in sortedKeys) {
        id value = [_dictionary objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [signString appendString:key];
            [signString appendString:value];
        }else if ([value isKindOfClass:[NSArray class]]) {
            for (id subValue in value) {
                if ([subValue isKindOfClass:[NSString class]]) {
                    [signString appendString:key];
                    [signString appendString:subValue];
                }else {
                    //异常数据类型
                    @throw [NSException exceptionWithName:@"签名参数类型错误" reason:@"签名参数类型只能是字符串或数组！" userInfo:nil];
                }
            }
        }else {
            //异常数据类型
            @throw [NSException exceptionWithName:@"签名参数类型错误" reason:@"签名参数类型只能是字符串或数组！" userInfo:nil];
        }
    }
    return [signString md5String];
}

- (NSString *)buildParameters{
    if ([self count] == 0) return @"";
    NSString * parametersString = [[NSString alloc] initWithData:[_dictionary JSONData] encoding:NSUTF8StringEncoding];
    return parametersString;
}

- (NSString *)buildSystemParameters {
    if ([self count] == 0) return @"";
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *sortedKeys = [[_dictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    NSMutableString *parametersString = [NSMutableString stringWithString:@""];
    for (NSString *key in sortedKeys) {
        if ([parametersString length] != 0) {
            [parametersString appendString:@"&"];
        }
        id value = [_dictionary objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [parametersString appendString:key];
            [parametersString appendString:@"="];
            [parametersString appendString:value];
        }else if ([value isKindOfClass:[NSArray class]]) {
            for (id subValue in value) {
                if ([subValue isKindOfClass:[NSString class]]) {
                    if ([parametersString length] != 0) {
                        [parametersString appendString:@"&"];
                    }
                    [parametersString appendString:key];
                    [parametersString appendString:@"="];
                    [parametersString appendString:subValue];
                }else {
                    //异常数据
                    @throw [NSException exceptionWithName:@"请求参数类型错误" reason:@"参数类型只能是字符串或数组！" userInfo:nil];
                }
            }
        }else {
            //异常数据
            @throw [NSException exceptionWithName:@"请求参数类型错误" reason:@"参数类型只能是字符串或数组！" userInfo:nil];
        }
    }
    return parametersString;
}

- (NSDictionary*)dictionary {
    return _dictionary;
}

- (NSInteger)count {
    return [_dictionary count];
}

- (BOOL)isEqualToParameters:(NSString *)parameters {
    return [[self buildParameters] isEqualToString:parameters];
}

@end

@implementation BBGMutableParameters

- (void)addParameter:(id)value forKey:(NSString *)key {
    if (!key) {
        @throw [NSException exceptionWithName:@"Error" reason:@"key for addParameter:forKey: is nil" userInfo:nil];
    }
    if (!value) {
        return;
    }
//    if ([value isKindOfClass:[NSDictionary class]]) {
//        NSString * str = [value JSONString];
//        value = str;
//    }
    
//    if ([value isKindOfClass:[NSArray class]]) {
//        NSString * str = [[NSString alloc] initWithData:[(NSArray *)value JSONData] encoding:NSUTF8StringEncoding];
//        value = str;
//    }
    [_dictionary setObject:value forKey:key];
}

-(id)getParameter:(NSString *)key{
    if (!key) {
        @throw [NSException exceptionWithName:@"Error" reason:@"key for removeParameter: is nil" userInfo:nil];
    }
 
    return [_dictionary objectForKey:key];
    
}

- (void)removeParameter:(NSString *)key {
    if (!key) {
        @throw [NSException exceptionWithName:@"Error" reason:@"key for removeParameter: is nil" userInfo:nil];
    }
    [_dictionary removeObjectForKey:key];
}

- (void)clearAllParameter {
    [_dictionary removeAllObjects];
}

@end