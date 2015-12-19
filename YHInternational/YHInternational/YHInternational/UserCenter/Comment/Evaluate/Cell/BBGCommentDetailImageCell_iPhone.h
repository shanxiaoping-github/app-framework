//
//  BBGCommentDetailImageCell_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGCommentDetailImageCell_iPhone : UITableViewCell

@property (strong, nonatomic) IBOutlet UICollectionView *imageViewCollection;
@property (nonatomic,strong) NSMutableArray *imgListArr;

@end
