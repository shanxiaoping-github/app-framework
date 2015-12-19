//
//  VSAddCartAnimation.m
//  Components
//
//  Created by Elvis on 14-4-17.
//  Copyright (c) 2014年 Vipshop Holdings Limited. All rights reserved.
//

#import "BBGAddCartAnimation.h"

@implementation BBGAddCartAnimation


-(void)addCartAnimationWithCartImg:(UIImageView *)cartImage cartButtonFrame:(CGRect)cartButtonFrame{

    __block CGRect addCartButtonFrame = cartButtonFrame;
    
    __block BBGAddCartAnimation *blockSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        cartImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 72, 72);
    }                completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            cartImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 60, 60);
        }                completion:^(BOOL finished) {
            addCartButtonFrame.origin.x = [UIScreen mainScreen].bounds.size.width  -35;
            addCartButtonFrame.origin.y += 10;
            addCartButtonFrame.size.height = addCartButtonFrame.size.width = 20;
            [UIView animateWithDuration:0.5 animations:^{
                cartImage.frame = addCartButtonFrame;
            }                completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    cartImage.alpha = 0;
                    cartImage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                }                completion:^(BOOL finished) {
                    
                    [blockSelf addCartAimationDone];
                }];
            }];
        }];
    }];


}

-(void)addCartAimationDone{

    if (self.delegate && [self.delegate respondsToSelector:@selector(addCartAimationDone)]) {
        [self.delegate addCartAimationDone];
    }
}

@end
