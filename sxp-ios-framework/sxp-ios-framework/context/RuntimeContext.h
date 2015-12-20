//
//  RuntimeContext.h
//  WMF
//
//  Created by beijingwomaifang on 15/6/10.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RuntimeContext : NSObject
+(instancetype)shareInstance;

-(void)putData:(id)value forkey:(NSString*)key;
-(id)getData:(NSString*)key;
-(void)putClassData:(id)value forkey:(Class)keyClass;
-(id)getClasstData:(Class)keyClass;

-(void)putConfiguration:(NSString*)value forkey:(NSString*)key;
-(NSString*)getConfiguration:(NSString*)key;
@end