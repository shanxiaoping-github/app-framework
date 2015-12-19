//
//  OnePhotoAlbumViewController.h
//  Common
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>





@interface OnePhotoAlbumViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) ALAssetsGroup *assetGroup;
@property (nonatomic, strong) UICollectionView* photoCollectionView;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIScrollView* bottomScrollView;

@property (nonatomic, strong) UIButton* doneBtn;

@property (nonatomic, assign) int maxSelectCount;

@property (nonatomic,strong) NSMutableArray* assetArray;

@property (nonatomic,strong) NSMutableDictionary* selectAssetDict;

@property (nonatomic, assign)id albumGroupVC;

@end
