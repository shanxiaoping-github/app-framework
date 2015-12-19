//
//  BBGPayButtonView_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayButtonView_iPhone.h"
#import "UIImageView+WebCache.h"
@interface BBGPayButtonView_iPhone ()
@property (strong, nonatomic) IBOutlet UIImageView *payIconImg;
@property (strong, nonatomic) IBOutlet UILabel *payNameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *selectedIconImg;
@property (strong, nonatomic) BBGPayType *payType;
@end

@implementation BBGPayButtonView_iPhone


-(instancetype)initWithFrame:(CGRect)frame{
    CGRect fixedFrame = CGRectMake(frame.origin.x, frame.origin.y, BUTTONWIDTH, BUTTONHEIGHT);
    self = [super initWithFrame:fixedFrame];
    if (self) {
        
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected{
    
    _isSelected = isSelected;
    if (_isSelected) {
        _payNameLbl.textColor = UIColorFromRGB(236, 43, 86);
        _selectedIconImg.hidden = NO;
    }else{
        _payNameLbl.textColor = UIColorFromHexadecimalRGB(0x666666);
        _selectedIconImg.hidden = YES;
    }
}

-(void)updatePayButtonViewWithPayType:(BBGPayType *)payType selectedPayType:(BBGPayType *)selectedPayType{
    WS(weakSelf);
    self.payType = payType;
    [_payIconImg sd_setImageWithURL:[NSURL URLWithString:payType.iconUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [weakSelf.payIconImg setFadeInWithDefaultTime];
        }
    }];
    _payNameLbl.text = payType.payName;
    
    if ([selectedPayType.payCode isEqualToString:payType.payCode]) {
        self.isSelected = YES;
    }else{
        self.isSelected = NO;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.delegate && [self.delegate respondsToSelector:@selector(payButtonDidChange:)]) {
        [self.delegate payButtonDidChange:self.payType];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
