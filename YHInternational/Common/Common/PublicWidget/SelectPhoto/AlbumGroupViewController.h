//
//  AlbumGroupViewController.h
//  Common
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@protocol AlbumPhotoSelectedDelage <NSObject>

-(void)selectPhotos:(NSArray*)photoInfoArray;

@end

// AlbumPhotoSelectedDelage : <#superclass#>

//@end


@interface AlbumGroupViewController : UIViewController

@property(nonatomic,assign)int maxSelectCount;
@property(nonatomic,strong)UITableView* albumGroupTable;
@property(nonatomic,strong)NSMutableArray* assetGroups;

@property(nonatomic,strong)ALAssetsLibrary *assetLibrary;

@property (nonatomic, assign)id<AlbumPhotoSelectedDelage> selectedDelegate;



@end
