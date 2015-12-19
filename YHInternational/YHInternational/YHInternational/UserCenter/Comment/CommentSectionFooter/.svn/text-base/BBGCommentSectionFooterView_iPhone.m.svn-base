//
//  BBGCommentSectionFooterView_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentSectionFooterView_iPhone.h"
#import "UIImage+Stretch.h"

@implementation BBGCommentSectionFooterView_iPhone

- (void)awakeFromNib {
    [_allBtn setBackgroundImage:[[UIImage imageNamed:@"三个描边-查看全部"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1,1) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
}

- (IBAction)didClickedAllBtn:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

@end
