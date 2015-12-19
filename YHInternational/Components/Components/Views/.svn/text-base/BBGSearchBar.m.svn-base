//
//  BBGSearchBar.m
//  Components
//
//  Created by calvin on 14-8-27.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSearchBar.h"
#import "UIImage+Stretch.h"
#import "BBGMacro.h"

@interface BBGSearchBar ()

@property (nonatomic, assign) BOOL didSetBackground;

@end

@implementation BBGSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tintColor = UIColorFromRGB(252, 69, 86);
        _placeholderTextColor = UIColorFromHexadecimalRGB(0x999999);
        _searchBarBgImage = [[UIImage imageNamed:@"SearchBarBg"] stretchImage];
        _searchLeftViewImage = [UIImage imageNamed:@"SearchIcon"];
    }
    return self;
}
- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor{
    _placeholderTextColor = placeholderTextColor;
    [self setNeedsLayout];
}

- (void)setSearchBarBgImage:(UIImage *)searchBarBgImage{
    _searchBarBgImage = searchBarBgImage;
    [self setNeedsLayout];
}

- (void)setSearchLeftViewImage:(UIImage *)searchLeftViewImage{
    _searchLeftViewImage = searchLeftViewImage;
    [self setNeedsLayout];
}



-(void) layoutSubviews
{
    UITextField *searchField;
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[UITextField class]] && !_didSetBackground) {
            //_didSetBackground = YES;
            searchField = (UITextField *)subView;
            UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
            [self insertSubview:bgView belowSubview:searchField];
            break;
        }else{
            for (UIView *sv in subView.subviews) {
                if([sv isKindOfClass:[UITextField class]] && !_didSetBackground) {
                   // _didSetBackground = YES;
                    searchField = (UITextField *)sv;
                    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
                    [subView insertSubview:bgView belowSubview:searchField];
                    break;
                }
            }
        }
    }
    if(!(searchField == nil)) {
        searchField.textColor = UIColorFromHexadecimalRGB(0x333333);
        [searchField setBackground: _searchBarBgImage];
        [searchField setBorderStyle:UITextBorderStyleNone];
        searchField.leftView = [[UIImageView alloc] initWithImage:_searchLeftViewImage];
        [searchField setValue:_placeholderTextColor forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setFont:APP_FONT(14)];
    }
    
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
