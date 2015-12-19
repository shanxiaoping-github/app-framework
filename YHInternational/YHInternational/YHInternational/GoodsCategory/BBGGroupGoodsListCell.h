//
//  BBGGroupGoodsListCell.h
//  YHInternational
//
//  Created by 黄 灿 on 15/10/22.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGGoodsListCell_iPhone.h"
@interface BBGGroupGoodsListCell : UITableViewCell<GoodsListCellDelegate>{
    
    // 用当前View 来保存 contentView
    UIView *view;
    
    //可切换的View
    UIView *canChooseView;
    
    //包含produc的数组
    NSArray *productArray;
    NSMutableDictionary *selfDic;
    
    UIButton *btn1,*btn2,*btn3;
    
    //当前选择的是哪个
    NSInteger whichChoosed;
}
@property (nonatomic, assign) id<GoodsListCellDelegate> delegate;
@property (nonatomic ,strong)BBGGoodsListCell_iPhone *goodsListCell;
+(float)cellHeight;
/**
 *  刷新cell
 *
 *  @param array 商品 model array
 */
- (void)updateCellWith:(NSMutableDictionary *)dic;
@end
