//
//  BBGOrderDetailLogisticsCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailLogisticsCell_iPhone.h"
@interface BBGOrderDetailLogisticsCell_iPhone()
@property (strong, nonatomic) IBOutlet UIImageView *nodeIcon;
@property (strong, nonatomic) IBOutlet UIImageView *topLine;
@property (strong, nonatomic) IBOutlet UIImageView *buttomLine;
@property (strong, nonatomic) IBOutlet UILabel *content;

@end
@implementation BBGOrderDetailLogisticsCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    self.topLine.image = _ResizeImage([UIImage imageNamed:@"物流时间线"]);
    self.buttomLine.image = _ResizeImage([UIImage imageNamed:@"物流时间线"]);
    self.nodeIcon.image = [UIImage imageNamed:@"物流状态小圆点"];
}

-(void)updateLogisticsDataWithTrack:(BBGOrderTrack *)orderTrack isLast:(BOOL)isLast isFirst:(BOOL)isFirst{
    
    if (orderTrack) {
        self.topLine.hidden = NO;
        self.buttomLine.hidden = NO;
        self.nodeIcon.hidden = NO;
        self.nodeIcon.image = [UIImage imageNamed:@"物流状态小圆点"];
        self.content.textColor = UIColorFromHexadecimalRGB(0x666666);
        if (isFirst && isLast) {
            self.topLine.hidden = YES;
            self.buttomLine.hidden = YES;
            self.content.textColor = UIColorFromRGB(236, 43, 86);
            self.nodeIcon.image = [UIImage imageNamed:@"物流状态小圆点-红"];
        }else if (isFirst) {
            self.topLine.hidden = YES;
            self.buttomLine.hidden = NO;
            self.content.textColor = UIColorFromRGB(236, 43, 86);
            self.nodeIcon.image = [UIImage imageNamed:@"物流状态小圆点-红"];
        }else if (isLast) {
            self.topLine.hidden = NO;
            self.buttomLine.hidden = YES;
        }
        
        NSString *time = [self stringFromDate:orderTrack.trackTime];
        self.content.text = [NSString stringWithFormat:@"%@\n%@",orderTrack.trackInfo,time];

    }else{
        
        self.topLine.hidden = YES;
        self.buttomLine.hidden = YES;
        self.nodeIcon.hidden = YES;
        self.content.text =@"暂无物流信息";
    }
    
    
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
