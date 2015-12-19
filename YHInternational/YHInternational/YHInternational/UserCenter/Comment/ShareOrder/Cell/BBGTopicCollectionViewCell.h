//
//  BBGTopicCollectionViewCell.h
//  YHInternational
//
//  Created by bbgds on 15/11/17.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGTopicCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *borderView;

@property (weak, nonatomic) IBOutlet UILabel *topic;

//选中状态
-(void)clickSelect;
//取消状态
-(void)clickCancle;

@end
