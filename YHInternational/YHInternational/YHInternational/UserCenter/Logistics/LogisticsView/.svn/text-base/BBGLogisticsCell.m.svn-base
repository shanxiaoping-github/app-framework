//
//  BBGLogisticsCell.m
//  YHInternational
//
//  Created by Damon on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLogisticsCell.h"
#import "BBGOrderTrack.h"
#import "BBGTools.h"
@interface BBGLogisticsCell()
@property (strong, nonatomic) IBOutlet UIImageView *headerView;
@property (strong, nonatomic) IBOutlet UIImageView *footerView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIImageView *downArrow;

@end

@implementation BBGLogisticsCell

- (void)openArrow:(BOOL)openArrow{
    if (openArrow) {
        self.downArrow.hidden = NO;
    }else{
        self.downArrow.hidden = YES;
    }
}

- (void)spreadAction:(BOOL)isSpread{
    __weak BBGLogisticsCell * weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (isSpread) {
            weakSelf.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            weakSelf.downArrow.transform = CGAffineTransformIdentity;

        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)updateCell:(id)response{
    BBGOrderTrack * orderTrack = response;
    _contentLabel.text = [NSString stringWithFormat:@"%@ %@",orderTrack.trackInfo,[BBGTools timeToString:orderTrack.trackTime.timeIntervalSince1970 Format:@"YYYY-MM-dd HH:mm:ss"]];
}

- (void)awakeFromNib {
    // Initialization code
    self.downArrow.hidden = YES;
    self.headerView.hidden = YES;
    self.footerView.hidden = YES;
}

- (void)setType:(LogisticsCellType)type{
    _type = type;
    if (type == HeaderType) {
        self.headerView.hidden = NO;
        self.footerView.hidden = YES;
    }
    if (type == FooterType) {
        self.footerView.hidden = NO;
        self.headerView.hidden = YES;
    }
    if (type == AllType) {
        self.footerView.hidden = NO;
        self.headerView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
