//
//  BBGEditAddressCardIDViewController.h
//  Components
//
//  Created by yangjie on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGAddress.h"

@interface BBGEditAddressCardIDViewController : BBGViewController

/**
 *  原地址对象
 */
@property(nonatomic, strong) BBGAddress *editAddress;

/**
 *  修改后的地址对象
 */
@property(nonatomic, strong) BBGAddress *editedAddress;

/**
 *  @author holyjoy, 15-06-08 14:06:19
 *
 *  是否选择身份证背面图片  yes/选择的时背面  no/选中的是正面
 */
@property (nonatomic, assign) BOOL isChooseIDPhotoBack;

@property (nonatomic,strong) BBGAddAddressRequest *addAddressReqeust;

/**
 *  根据姓名和memberId查询身份证信息
 *
 *  @param callback <#callback description#>
 */
- (void)getAddrByName:(LoadDataCallback)callback;

/**
 *  增加收货地址
 *
 *  @param callback <#callback description#>
 */
- (void)addAddress:(LoadDataCallback)callback;

/**
 *  上传身份证照片
 *
 *  @param img      身份证照片
 *  @param callback
 */
- (void)AFNetworkUploadIDPhoto:(UIImage*)img callBack:(LoadDataCallback)callback;

@end
