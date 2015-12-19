//
//  HttpRequestEvent.m
//  gigold
//
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "HttpRequestEvent.h"
#import "HttpUtil.h"
#import "HttpRequestTransaction.h"
@implementation HttpRequestEvent
@synthesize belongHttpRequestTransaction=_belongHttpRequestTransaction;
@synthesize dependentHttpRequestEvent=_dependentHttpRequestEvent;
@synthesize nextHttpRequestEventArray=_nextHttpRequestEventArray;
@synthesize httpConfiguration=_httpConfiguration;
@synthesize httpResponse=_httpResponse;
@synthesize url=_url;
@synthesize action=_action;
@synthesize interceptSubmit = _interceptSubmit;

-(NSArray *)getPramaKeys{
	return nil;
}
-(void)setPramaValues:(NSArray *)values{
	if (!values){
		return;
	}
	if (!_httpConfiguration) {
		self.httpConfiguration = [[HttpConfiguration alloc]init];
		[self setParams:values];
		return;
	}
	if (_httpConfiguration.params) {
		return;
	}
	[self setParams:values];
	
}
-(void)setParams:(NSArray*)values{
	if (![self getPramaKeys]) {
		return;
	}
	if ([self getPramaKeys].count!=values.count) {
		return;
	}
	for (int i = 0;i < values.count;i++){
		[_httpConfiguration addParam:[self getPramaKeys][i] value:values[i]];
	}
}
-(NSDictionary *)filterParamers:(NSDictionary *)parames{
	return parames;
}

-(void)setHttpConfiguration:(HttpConfiguration *)httpConfiguration{
	if (_httpConfiguration){
		if (httpConfiguration.params) {
			_httpConfiguration = httpConfiguration;
		}else{
			HttpConfiguration* tempHttpConfiguration = _httpConfiguration;
			_httpConfiguration = httpConfiguration;
			_httpConfiguration.params = tempHttpConfiguration.params;
		}
	}else{
		_httpConfiguration = httpConfiguration;
	}
}
-(NSString*)getUrl{
	if (_httpConfiguration&&_httpConfiguration.url) {
		return _httpConfiguration.url;
	}else if(self.url){
		return self.url;
	}else{
		return [HttpRequestEvent getBaseUrl];
	}
}
-(NSString*)getAction{
	
	if (_httpConfiguration&&_httpConfiguration.action) {
		return _httpConfiguration.action;
	}else if(self.action){
		return self.action;
	}else{
		return [HttpRequestEvent getBaseAction];
	}
}

/*
	*添加next http请求
	*httpRequestEvent 请求事件
	*/
-(void)addNextHttpRequestEvent:(HttpRequestEvent *)httpRequestEvent{
	if (!_nextHttpRequestEventArray) {
		self.nextHttpRequestEventArray = [[NSMutableArray alloc]init];
	}
	for(int i = 0;i < _nextHttpRequestEventArray.count;i++){
		HttpRequestEvent* httpRequest = _nextHttpRequestEventArray[i];
		NSString* orginUrl = [NSString stringWithFormat:@"%@%@",[httpRequest getUrl],[httpRequest getAction]];
		NSString* cuUrl = [NSString stringWithFormat:@"%@%@",[httpRequestEvent getUrl],[httpRequestEvent getAction]];
		if(orginUrl&&cuUrl&&[orginUrl isEqualToString:cuUrl]){
			return;
		}
	}
	httpRequestEvent.dependentHttpRequestEvent = self;
	[_nextHttpRequestEventArray addObject:httpRequestEvent];
}
//执行下一个http请求
-(void)performNextHttpRequestEvent{
	if (_nextHttpRequestEventArray) {
		for (HttpRequestEvent* httpRequestEvent in _nextHttpRequestEventArray) {
			[httpRequestEvent submitSubRequest:self];
		}
	}
}
-(void)submitRequest{
	if (_interceptSubmit) {
		return;
	}
	if (!_httpConfiguration) {
		self.httpConfiguration = [[HttpConfiguration alloc]init];
	}
	
	if (!_httpConfiguration.httpRequestType){
		_httpConfiguration.httpRequestType = HttpRequestTypePost;
	}
	[HttpUtil sendHttpRequest:_httpConfiguration.httpRequestType url:[HttpConfiguration getUrl:[self getUrl] action:[self getAction]] params:[self filterParamers:_httpConfiguration.params] success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self parseResponse:NOMAL
					 result:operation.responseString
				   response:responseObject];
		if (_belongHttpRequestTransaction) {
			[_belongHttpRequestTransaction countHttpTransaction];
		}
		[self performNextHttpRequestEvent];
		if (_httpResponse){
			_httpResponse.success(self,responseObject);
		}
		
	} faile:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self parseResponse:ERROR
					 result:operation.responseString
				   response:error];
		if (_belongHttpRequestTransaction) {
			[_belongHttpRequestTransaction countHttpTransaction];
		}
		if (_httpResponse) {
			_httpResponse.faile(self,error);
		}
	}];
	
}
-(void)getSubRequestContext:(id)sender{}
-(void)submitSubRequest:(id)sender{
	[self getSubRequestContext:sender];
	[self submitRequest];
	
}
-(void)parseResponse:(NSString *)resultType result:(NSString *)result response:(id)response{
}

/********************************************基本定值********************************************/
//基本服务器地址
+(NSString*)getBaseUrl{
	return @"http://";
}
//获得基本action
+(NSString*)getBaseAction{
	return @"index";
}
@end
