//
//  ImageCollectionViewCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/30.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    
}

- (void)updateCell:(NSString *)imgUrlString{
    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"goodsDefault"]];

}
@end
