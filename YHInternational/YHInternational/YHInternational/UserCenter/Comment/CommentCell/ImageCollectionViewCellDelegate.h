//
//  ImageCollectionViewCellDelegate.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

@protocol ImageCollectionViewCellDelegate <NSObject>

- (void)didClickedImageViewCell:(NSIndexPath *)indexPath imageArray:(NSMutableArray *)imageArray;

@end
