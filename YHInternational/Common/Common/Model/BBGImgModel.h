//
//  BBGImgModel.h
//  Common
//
//  Created by yangjie on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGImgModel : BBGResponseDataHandler

@property (nonatomic,strong) NSString *imgId;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *imgBase64Str;
@property (nonatomic,assign) BOOL isAddBtn;

@end
