//
//  BBGDetailGiftCell.h
//  YHInternational
//
//  Created by 彭腾 on 15/6/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionButton)();

@interface BBGDetailGiftCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIView *whiteView;
@property (strong, nonatomic) IBOutlet UIView *blackView;
@property (strong, nonatomic) IBOutlet UILabel *finishLab;
@property (strong, nonatomic) IBOutlet UILabel *specLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numLabWidth;
@property (nonatomic, copy) ActionButton button;
- (void)handlerButtonAction:(ActionButton)block;

@end
