//
//  BBGTopic.h
//  Common
//
//  Created by Damon on 15/5/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGTopic : BBGResponseDataHandler
@property (nonatomic, strong) NSString * adName;
@property (nonatomic, strong) NSString * adURL;
@property (nonatomic, strong) NSString * adImgURL;
/*!
 *  点赞数
 */
@property (nonatomic, assign) NSInteger praiseCount;
@end
