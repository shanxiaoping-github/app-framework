//
//  AdvCell.m
//  YHInternational
//
//  Created by Damon on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "AdvCell.h"
#import "BBGAdvProduct.h"
@interface AdvCell ()<BBGAdvViewDataSource,BBGAdvViewDelegate>
@property (nonatomic, strong) NSArray * advArray;
@end

@implementation AdvCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (IPHONE_WIDTH == 320) {
            _advView = [[BBGAdvView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 133)];
        }else if (IPHONE_WIDTH == 375){
            _advView = [[BBGAdvView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 155)];
        }else{
            _advView = [[BBGAdvView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 171)];
        }
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        
        _advView.dataSource = self;
        _advView.delegate = self;
        _advView.focusImage = [UIImage imageNamed:@"openStoreSelect"];
        _advView.pageImage = [UIImage imageNamed:@"openStoreNoSelect"];
        [self addSubview:_advView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCell:(id)response{
//    _advView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.advArray = response;
    [self.advView reloadData];
}

#pragma mark -- BBGAdvViewDataSource,BBGAdvViewDelegate
- (NSInteger)numberOfPagesInAdvView:(BBGAdvView *)advView{
    if (self.advArray) {
        return self.advArray.count;
    }
    return 0;
}

- (UIView *)advView:(BBGAdvView *)advView viewForAdvViewAtPage:(NSInteger)page{
    if (self.advArray) {
        BBGAdvProduct * advProduct = [self.advArray ARRAY_OBJ_AT(page)];
        UIImageView * imageView;
        if (IPHONE_WIDTH == 320) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 133)];
        }else if (IPHONE_WIDTH == 375){
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 155)];
        }else{
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 171)];
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:advProduct.adImg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (cacheType ==SDImageCacheTypeNone) {
                [imageView setFadeInWithDefaultTime];
            }
        }];

        return imageView;
    }
    return nil;
}

- (CGFloat)advView:(BBGAdvView *)advView heightForViewAtPage:(NSInteger)page{
    if (IPHONE_WIDTH == 320) {
        return 133;
    }else if (IPHONE_WIDTH == 375){
        return 155;
    }else{
        return 171;
    }
}

- (void)advView:(BBGAdvView *)advView didSelectViewAtPage:(NSInteger)page{
    [self.delegate didSelected:(int)page];
}

@end
