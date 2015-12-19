//
//  BBGIDCardEditViewController.h
//  Components
//
//  Created by holyjoy on 15/3/5.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGViewController.h"
#import <Common.h>
typedef enum {
    EDITIDCard = 0,
    ADDIDCard,
    GETSELFIDCardLIST
}BBGIDCardEditRequestType;

typedef void(^BBGIDCardEditViewCallBack)(BBGIDCardEditRequestType,BBGResponseResult);

@interface BBGIDCardEditViewController : BBGViewController

@property (nonatomic,assign)NSInteger IDCardId;
/**
 *  修改后的身份证对象
 */
@property(nonatomic, strong) BBGIDCard *savaIDCard;

/**
 *  @author holyjoy, 15-06-08 14:06:19
 *
 *  是否选择身份证背面图片  yes/选择的时背面  no/选中的是正面
 */
@property (nonatomic, assign) BOOL isChooseIDPhotoBack;

/**
 *  上传身份证照片
 *
 *  @param img      身份证照片
 *  @param callback
 */
- (void)AFNetworkUploadIDPhoto:(UIImage*)img callBack:(LoadDataCallback)callback;
@end
