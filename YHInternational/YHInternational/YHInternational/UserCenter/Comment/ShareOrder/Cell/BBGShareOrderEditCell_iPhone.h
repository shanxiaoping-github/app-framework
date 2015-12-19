//
//  BBGShareOrderEditCell_iPhone.h
//  YHInternational
//
//  Created by yousai on 15/10/21.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGShareOrder.h"

@protocol BBGShareOrderEditCellDelegate <NSObject>

- (void)changeTable:(NSInteger)type str:(NSString *)str isAnonymous:(BOOL)isAnonymous;

@end

/**
 *  晒单CELL
 */
@interface BBGShareOrderEditCell_iPhone : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIView *topicView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topicHeight;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *viewText;

@property (weak, nonatomic) IBOutlet UIButton *btn_topic;

@property (strong, nonatomic) NSIndexPath *tableIndexPath;

@property (nonatomic, assign) NSMutableArray *shareOrderArray;

//是否展开
@property (nonatomic) BOOL isOpenUp;

@property (weak, nonatomic) id<BBGShareOrderEditCellDelegate> delegate;

- (void)displayTextContent:(NSString *)text isAnonymous:(BOOL)isAnonymous;

@property (strong,nonatomic) NSArray *strArray;

-(void)setTopicData:(NSMutableArray *)array indexPaht:(NSIndexPath *)path;

@end
