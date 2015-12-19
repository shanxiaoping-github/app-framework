//
//  BBGPhotoBrowserEditViewController.h
//  Common
//
//  Created by yangjie on 15/10/20.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@class BBGPhotoBrowserEditViewController;
@protocol BBGPhotoBrowserEditDelegate <NSObject>

- (void)finishEdit:(BBGPhotoBrowserEditViewController*)con imageArray:(NSMutableArray*)imgArray;

@end


@interface BBGPhotoBrowserEditViewController : BBGViewController

@property (nonatomic,strong)NSMutableArray *imgArray;

@property (nonatomic,assign) id<BBGPhotoBrowserEditDelegate> delegate;

@end
