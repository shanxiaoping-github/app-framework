//
//  BBGIndexCenterTitleTableViewCell.h
//  YHInternational
//
//  Created by 黄 灿 on 15/10/23.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGIndexCenterTitleTableViewCell : UITableViewCell
{
    //左右图片
    UIImageView *leftImageView,*rightImageView;

    //中间文字
    UILabel *centerLabel;
}
- (void)updateCell:(id)response;
- (void)setSeckillTitleCell;
@end
