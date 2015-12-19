//
//  BBGPayViewController.h
//  Components
//
//  Created by Holyjoy on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGPayInfo.h"
@interface BBGPayViewController : BBGViewController
/**
 *  订单id数组
 */
@property (nonatomic,strong) NSMutableArray *orderIds;
- (void)getPayTypeWithCallback:(LoadDataCallback)callback;
- (void)getPaymentOrderInfoWithPayType:(NSString *)payType callback:(LoadDataCallback)callback;
/**
 *  获取验签信息
 *
 *  @param payType  <#payType description#>
 *  @param callback <#callback description#>
 */
-(void)getPaymentSignInfoWithPayType:(NSString *)payType orderIds:(NSMutableArray *)orderIds callback:(LoadDataCallback)callback;


-(void)getPmsMessageCallback:(LoadDataCallback)callback;
@end
