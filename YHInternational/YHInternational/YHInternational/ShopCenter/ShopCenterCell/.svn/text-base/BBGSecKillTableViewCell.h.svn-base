//
//  BBGSecKillCellTableViewCell.h
//  YHInternational
//
//  Created by 黄 灿 on 15/9/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGCountdownManager.h"
@protocol BBGSecKillDelegate <NSObject>

- (void)indexClicked:(NSIndexPath *)indexpath;


@end
@interface BBGSecKillTableViewCell : UITableViewCell<BBGCountdownObserver>
{
    //右边的详情View
    UIView *rightInfoView,*leftInfoView;
    //新增一个rightInitView  用来包含商品信息  根据内容自动扩大，居中
    UIView *rightInitView;

    UILabel *titleLabel,*leftTimeLabel,*rightTimeLabel,*unCroosedPrice,*croosedPrice;
    
    UIImageView *mainImageView,*cartImage,*topRightImage,*watermarkImageView;
    
    
    NSString *hour,*min,*second;
    
    //剩余时间
    NSInteger time;
    
    UIView *lineView;
    
}
@property (nonatomic, strong)BBGSecKillProduct *secProduct;
@property (nonatomic,strong)NSIndexPath *indexpath;
@property (nonatomic,weak) id<BBGSecKillDelegate> delegate;
@property(nonatomic, copy) void (^timerDone)();
- (void)updateCell:(BBGSecKillProduct *)seckill isUp:(BOOL)isUp;

@end


