//
//  JsonFactory.m
//  apos-enterprise-ios
//
//  Created by shanxiaoping on 14-12-8.
//  Copyright (c) 2014年 cpz. All rights reserved.
//
#import "JsonFactory.h"
#import "MJExtension.h"
@implementation JsonFactory
+(NSArray *)creatJsonDataArrayByStr:(NSString *)jsonStr class:(Class)className{
    NSArray* jsonDataArray = [JsonFactory creatJsonDataArrayByStr:jsonStr];
    return [JsonFactory creatJsonDataArrayByArray:jsonDataArray class:className];
}
+(NSArray *)creatJsonDataArrayByStr:(NSString *)jsonStr{
    NSData* jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return jsonArray;
}
+(NSArray *)creatJsonDataArrayByArray:(NSArray *)jsonArray class:(Class)className{
   return [className objectArrayWithKeyValuesArray:jsonArray];
}

+(NSDictionary *)creatJsonDataItem:(NSString*)jsonStr{
    NSData* jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *item = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return item;
}
+(id)creatJsonDataItemByStr:(NSString *)jsonStr class:(Class)className{
    NSDictionary* item = [JsonFactory creatJsonDataItem:jsonStr];
    return [JsonFactory creatJsonDataItemByDic:item class:className];
}
+(id)creatJsonDataItemByDic:(NSDictionary *)jsonItem class:(Class)className{
    return [className objectWithKeyValues:jsonItem];
}
@end
