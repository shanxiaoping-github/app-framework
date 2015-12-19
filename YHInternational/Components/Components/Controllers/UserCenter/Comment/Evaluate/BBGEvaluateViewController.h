//
//  BBGEvaluateViewController.h
//  Components
//
//  Created by Holyjoy on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGEvaluateViewController : BBGViewController

@property (nonatomic,strong) NSString *googsId;
@property (nonatomic,assign) BOOL hasOrder;
@property (nonatomic,strong) NSString *orderTime;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,assign) BOOL isAnonymous;
@property (nonatomic,assign) BOOL evaluateSucessful;
@property (nonatomic, strong) NSMutableArray *imgArray;

- (void)JudgeUserIsBuyGoods:(LoadDataCallback)callback;

- (void)uploadImg:(UIImage*)img callBack:(LoadDataCallback)callback;

- (void)uploadAllImg:(NSArray*)imgArray callBack:(LoadDataCallback)callback;

@end
