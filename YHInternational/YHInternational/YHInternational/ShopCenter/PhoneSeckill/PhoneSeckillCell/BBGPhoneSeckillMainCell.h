//
//  BBGPhoneSeckillMainCell.h
//  YHInternational
//
//  Created by 彭腾 on 15/9/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGSecKillProduct.h"
#import "BBGPhoneSeckillModel.h"
#import "BBGCountdownManager.h"

@protocol BBGPhoneSeckillMainDelegate <NSObject>

- (void)reload;

- (void)animationFinish:(NSInteger)section;

@end

@interface BBGPhoneSeckillMainCell : UITableViewCell<BBGCountdownObserver>

@property (weak, nonatomic) IBOutlet UIImageView *lightningView;
@property (weak, nonatomic) IBOutlet UILabel *lightningLab;

@property (nonatomic, assign) id<BBGPhoneSeckillMainDelegate> delegate;

- (void)updateCellWith:(BBGSecKillProduct *)model
                  Time:(BBGPhoneSeckillModel *)time
                  sign:(NSString *)sign
               section:(NSInteger)section;

@end
