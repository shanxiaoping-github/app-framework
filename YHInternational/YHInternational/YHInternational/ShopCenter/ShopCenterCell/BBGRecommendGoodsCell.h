//
//  BBGRecommendGoodsCell.h
//  YHInternational
//
//  Created by 黄 灿 on 15/7/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBGRecommendCellDelegate <NSObject>

- (void)recommendIndexClicked:(NSIndexPath *)indexpath;

@end
@interface BBGRecommendGoodsCell : UITableViewCell{
    /**
     *  底层图片   购物车图片   分割线图片
     */
    UIImageView *backImageView,*cartImageView,*dashLineView;
    
    /**
     *  商品名字   付款价   划线价
     */
    UILabel *titleLabel,*payLable,*salePriceLabel;
    
    /**
     *  包含商品信息的一个View
     */
    UIView *infoView;
    
    //水印图片
    UIImageView *watermarkImageView;
}
@property (nonatomic,weak) id<BBGRecommendCellDelegate> delegate;

/**
 *  从table传入 点击购物车传出
 */
@property (nonatomic,strong) NSIndexPath *indexpath;
- (void)updateCell:(BBGRecommendProduct *)response isUp:(BOOL)isUp;
@end
