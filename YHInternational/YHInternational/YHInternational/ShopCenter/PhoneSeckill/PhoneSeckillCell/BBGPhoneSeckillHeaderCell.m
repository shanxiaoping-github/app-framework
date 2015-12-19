//
//  PhoneSeckillHeaderCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillHeaderCell.h"

@interface BBGPhoneSeckillHeaderCell (){
    CountDownView *cView;
}
@end

@implementation BBGPhoneSeckillHeaderCell

- (void)awakeFromNib {
    // Initialization code

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-0.5f, IPHONE_WIDTH, 0.5f);
    bottomBorder.backgroundColor = [UIColorFromRGB(229,229,229) CGColor];
    [self.layer addSublayer:bottomBorder];
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, IPHONE_WIDTH, 0.5f);
    topBorder.backgroundColor = [UIColorFromRGB(229,229,229) CGColor];
    [self.layer addSublayer:topBorder];
    
    cView = [[CountDownView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH-80, self.timeView.frame.size.height)];
    cView.delegate = self;
    [self.timeView addSubview:cView];
    
    cView.presentColor = UIColorFromHexadecimalRGB(0xc7c1c2);
    cView.backColor = UIColorFromHexadecimalRGB(0xf3517e);
}

- (void)updateCellWith:(BBGPhoneSeckillModel *)model {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter dateFromString:model.startDate];
    NSDate *modifyDate = [formatter dateFromString:model.modifyDate];
    NSTimeInterval start = [startDate timeIntervalSince1970];
    NSTimeInterval modify = [modifyDate timeIntervalSince1970];
    
    cView.percent=0;

    cView.contentStr = @"";
    cView.beginTime = modify;
    cView.endTime = start;
    cView.isCountDown = YES;
}

- (void)countDowningStr:(NSString *)str {
    cView.contentStr = str;
}

- (void)countdownFinished {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PhoneSeckillReload" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
