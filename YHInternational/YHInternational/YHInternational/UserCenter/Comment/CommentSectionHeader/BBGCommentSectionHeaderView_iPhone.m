//
//  BBGCommentSectionHeaderView_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentSectionHeaderView_iPhone.h"
#import "UIImage+Stretch.h"

@implementation BBGCommentSectionHeaderView_iPhone

- (void)awakeFromNib {
    
}

- (IBAction)tapHeaderVeiwAction:(UITapGestureRecognizer *)sender {
    
    if (_headerBlock) {
        _headerBlock();
    }
}


@end
