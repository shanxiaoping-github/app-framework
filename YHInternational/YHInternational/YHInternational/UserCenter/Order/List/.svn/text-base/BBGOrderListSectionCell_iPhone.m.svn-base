//
//  BBGOrderListSectionCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderListSectionCell_iPhone.h"
#import "BBGCountdownManager.h"
@interface BBGOrderListSectionCell_iPhone()<BBGCountdownObserver>
@property (strong, nonatomic) IBOutlet UILabel *statusLbl;
@property (strong, nonatomic) IBOutlet UILabel *createTimeLbl;
@property (nonatomic, assign) NSInteger leftSeconds;
@property (nonatomic,assign)BOOL isCountDown;
@end
@implementation BBGOrderListSectionCell_iPhone

-(void)awakeFromNib{
    
    self.statusLbl.textColor = UIColorFromHexadecimalRGB(0xf03468);
    self.createTimeLbl.textColor = UIColorFromHexadecimalRGB(0x999999);
    self.backgroundColor = UIColorFromRGB(236, 235, 232);
    [[BBGCountdownManager sharedInstance] addObserver:self];
}
-(void)updateSectionViewWithOrderInfo:(BBGOrderInfo *)orderInfo;{
    self.statusLbl.text = nil;
    self.createTimeLbl.text = [self stringFromDate:orderInfo.orderCreateTime];
    if ([orderInfo.viewStatus compare:@"wait_pay"]== NSOrderedSame)
    {
        NSDate *nowDate = [[BBGConfiguration sharedInstance] getCurrentServerTime];
        NSDate *createDate = orderInfo.orderCreateTime;
        NSInteger cancelSeconds = orderInfo.orderCancelTimeout/1000;
        _leftSeconds = cancelSeconds - [nowDate timeIntervalSinceDate:createDate];
        if (_leftSeconds <= 0) {
            self.isCountDown = NO;
        }else{
            self.isCountDown = YES;
        }
        
    }else{
        self.isCountDown = NO;
        self.statusLbl.text = orderInfo.statusName;
    }
}

- (void)countdown {
    if (self.isCountDown) {
        NSInteger hour = _leftSeconds / 3600;
        NSInteger minute = _leftSeconds % 3600 / 60;
        NSInteger seconds = _leftSeconds % 60;
        self.statusLbl.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld后自动取消",(long)hour,(long)minute,(long)seconds];
        _leftSeconds --;
        if (_leftSeconds < 0) {
            self.isCountDown = NO;
            self.statusLbl.text = nil;
            if (self.delegate && [self.delegate respondsToSelector:@selector(countdownFinished)]) {
                [self.delegate countdownFinished];
            }
        }
    }
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


-(void)dealloc{
    [[BBGCountdownManager sharedInstance] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
