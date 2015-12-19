//
//  BBGUseCouponCell.h
//  YHInternational
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailButton)(NSInteger tag);

@interface BBGUseCouponCell : UITableViewCell

@property (nonatomic, copy) DetailButton button ;
@property (strong, nonatomic) IBOutlet UIImageView *instrBtn;
@property (strong, nonatomic) IBOutlet UIButton *couponBtn;
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) IBOutlet UIButton *inStrButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;


- (void)updateCell:(id)response;
- (void)buttonAction:(DetailButton)block;
@end
