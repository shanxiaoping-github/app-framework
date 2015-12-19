//
//  BBGGetAddrByNameResponse.h
//  Common
//
//  Created by yangjie on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"

@interface BBGGetAddrByNameResponse : BBGResponse

@property (nonatomic,strong) NSString *IDCard;
//图片URL
@property (nonatomic,strong) NSString *IDCardPhotoFrontUrl;
@property (nonatomic,strong) NSString *IDCardPhotoBackUrl;
@property (nonatomic,strong) NSString *IDCardPhotoFrontUrlHD;
@property (nonatomic,strong) NSString *IDCardPhotoBackUrlHD;
//图片URL对应的id
@property (nonatomic,strong) NSString *IDCardPhotoFrontImageId;
@property (nonatomic,strong) NSString *IDCardPhotoBackImageId;


@end
