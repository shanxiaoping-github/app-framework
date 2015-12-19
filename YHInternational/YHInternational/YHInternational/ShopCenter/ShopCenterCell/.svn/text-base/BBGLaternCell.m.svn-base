//
//  BBGLaternCell.m
//  YHInternational
//
//  Created by Damon on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLaternCell.h"

@interface BBGLaternCell ()
@property (nonatomic, strong) UIImageView * loundSpeckImageView;
@end

@implementation BBGLaternCell

- (void)updateCell:(id)response{
    
    NSArray * array = response;
    _boardView.contentArray = (NSMutableArray *)array;
    _boardView.backgroundColor = [UIColor whiteColor];
    [_boardView startAnimation];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _loundSpeckImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 15, 15)];
        [_loundSpeckImageView setImage:[UIImage imageNamed:@"Loudspeaker"]];
        [self addSubview:_loundSpeckImageView];
        _boardView = [[GSNoticeBoardView alloc]initWithFrame:CGRectMake(25, 4, IPHONE_WIDTH - 30, 25)];
        [self addSubview:_boardView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
