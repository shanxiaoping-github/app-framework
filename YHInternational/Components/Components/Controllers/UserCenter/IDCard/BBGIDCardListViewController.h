//
//  BBGIDCardListViewController.h
//  Components
//
//  Created by holyjoy on 15/3/4.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGViewController.h"
#import <UIKit/UIKit.h>
typedef enum {
    GETALLIDCard = 0,
    DELETEIDCard
}BBGIDCardListRequestType;

typedef void(^BBGIDCardListCallBack)(BBGIDCardListRequestType,BBGResponseResult);

@interface BBGIDCardListViewController : BBGViewController
/**
 *  身份证信息
 */
@property (strong,nonatomic) NSMutableArray *userIDCardList;
@property (nonatomic,copy) BBGIDCardListCallBack dataCallback;
/**
 *  是否删除成功
 */
@property (nonatomic, assign) BOOL deleteSuccessful;

-(void)loadUserIDCard;
-(void)deleteIDCard:(NSInteger)IDCardID;
@end
