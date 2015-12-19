//
//  BBGOrderDetailStatusCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailStatusCell_iPhone.h"
#import "BBGCountdownManager.h"
@interface BBGOrderDetailStatusCell_iPhone()<BBGCountdownObserver>

//横线
@property (strong, nonatomic) UIImageView *redLineImageView;

//待付款
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLbl1;
//待发货
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLbl2;
//待收货
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLbl3;
//已收货
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLbl4;
//已完成
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLbl5;

//各状态对应的是实心点还是空心点
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView1;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView2;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView3;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView4;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView5;

@property (strong, nonatomic) IBOutlet UITextView *orderNumTextView;
@property (strong, nonatomic) IBOutlet UILabel *orderCreateTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *countDownLbl;
@property (nonatomic,assign) NSInteger timeout;
@property (nonatomic,assign) BOOL isCountDown;
@end


@implementation BBGOrderDetailStatusCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    [[BBGCountdownManager sharedInstance] addObserver:self];
    self.redLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH/10, 38, (IPHONE_WIDTH/10)*8 , 2)];
    self.redLineImageView.image = [UIImage imageNamed:@"red_line"];
    
    //insertSubView:bellowView 在iOS8.4下生效
    [self addSubview:self.redLineImageView];
    [self sendSubviewToBack:self.redLineImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateStatusCellWithOrderInfo:(BBGOrderInfo *)orderInfo{
    
    self.countDownLbl.hidden = YES;
    self.orderStatusLbl1.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
    self.orderStatusLbl2.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
    self.orderStatusLbl3.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
    self.orderStatusLbl4.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
    self.orderStatusLbl5.textColor = UICOLOR_FONT_IMPORTANT_BLACK;

    if ([orderInfo.viewStatus compare:@"wait_pay"] == NSOrderedSame) {
        //待付款
        self.iconImageView1.image = [UIImage imageNamed:@"full_red"];
        self.orderStatusLbl1.textColor = UICOLOR_FONT_IMPORTANT_RED;

        [self runCountDownWithCancelTime:orderInfo.orderCancelTimeout createTime:orderInfo.orderCreateTime];
        self.countDownLbl.hidden = NO;
    }else if ([orderInfo.viewStatus compare:@"paid"] == NSOrderedSame){
        //待发货
        self.iconImageView1.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView2.image = [UIImage imageNamed:@"full_red"];
        self.orderStatusLbl2.textColor = UICOLOR_FONT_IMPORTANT_RED;

        
    }else if ([orderInfo.viewStatus compare:@"finish_send_goods"] == NSOrderedSame ||
              [orderInfo.viewStatus compare:@"wait_self_take"] == NSOrderedSame || [orderInfo.viewStatus compare:@"finish_sign"] == NSOrderedSame){
        //待收货
        self.iconImageView1.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView2.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView3.image = [UIImage imageNamed:@"full_red"];
        self.orderStatusLbl3.textColor = UICOLOR_FONT_IMPORTANT_RED;

    }else if ([orderInfo.viewStatus compare:@"ship_success"] == NSOrderedSame){
        //已收货
        self.iconImageView1.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView2.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView3.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView4.image = [UIImage imageNamed:@"full_red"];
        self.orderStatusLbl4.textColor = UICOLOR_FONT_IMPORTANT_RED;


    }else if ([orderInfo.viewStatus compare:@"trade_success"] == NSOrderedSame){
        //已完成
        self.iconImageView1.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView2.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView3.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView4.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView5.image = [UIImage imageNamed:@"full_red"];
        self.orderStatusLbl5.textColor = UICOLOR_FONT_IMPORTANT_RED;
        
    }else if ([orderInfo.viewStatus compare:@"reject_sign"] == NSOrderedSame ||
             [orderInfo.viewStatus compare:@"ship_failed"] == NSOrderedSame ||
             [orderInfo.viewStatus compare:@"trade_failed"] == NSOrderedSame||
             [orderInfo.viewStatus compare:@"canceling"] == NSOrderedSame||
             [orderInfo.viewStatus compare:@"canceled"] == NSOrderedSame){
        //订单取消或者订单失败状态
        self.orderStatusLbl3.text = orderInfo.statusName;
        self.orderStatusLbl3.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT;
        self.orderStatusLbl2.text = nil;
        self.orderStatusLbl1.text = nil;
        self.orderStatusLbl4.text = nil;
        self.orderStatusLbl5.text = nil;
        self.iconImageView1.hidden= YES;
        self.iconImageView2.hidden= YES;
        self.iconImageView3.hidden= NO;
        self.iconImageView4.hidden= YES;
        self.iconImageView5.hidden= YES;
        self.iconImageView3.image = [UIImage imageNamed:@"cancel_gray"];
        self.redLineImageView.image = [UIImage imageNamed:@"gray_line"];

    }else{
        //默认显示图标
        self.iconImageView5.image = [UIImage imageNamed:@"full_red"];
        self.iconImageView1.image = [UIImage imageNamed:@"hollow_red"];
        self.iconImageView2.image = [UIImage imageNamed:@"hollow_red"];
        self.iconImageView3.image = [UIImage imageNamed:@"hollow_red"];
        self.iconImageView4.image = [UIImage imageNamed:@"hollow_red"];

    }
    
    self.orderNumTextView.text = orderInfo.orderId;
    self.orderCreateTimeLbl.text = [self stringFromDate:orderInfo.orderCreateTime];
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)runCountDownWithCancelTime:(NSInteger)cancelTime createTime:(NSDate *)createTime{
    //    _timeout = (int)(ceil([initialEndDate timeIntervalSinceDate:[NSDate date]]));
    NSInteger cancelSeconds = cancelTime/1000;
    NSDate *nowDate = [[BBGConfiguration sharedInstance] getCurrentServerTime];
    _timeout =(int)(cancelSeconds - [nowDate timeIntervalSinceDate:createTime]);
    if (_timeout >= 0) {
        NSInteger hour = _timeout / (60 * 60);
        NSInteger minute = (_timeout % (60 * 60)) / 60;
        NSInteger seconds = (_timeout % (60 * 60)) % 60;
        _countDownLbl.text = [NSString stringWithFormat:@"%ld%ld:%ld%ld:%ld%ld自动取消",(long)hour/10,(long)hour%10,(long)minute/10,(long)minute%10,(long)seconds/10,(long)seconds%10];
        self.isCountDown = YES;
    }
}

#pragma mark -
- (void)countdown{
    
    if (self.isCountDown) {
        if (_timeout <= 0) {
            self.isCountDown = NO;
            if (self.delegate && [self.delegate respondsToSelector:@selector(countdownFinished)]) {
                [self.delegate countdownFinished];
            }
        }
        NSInteger hour = _timeout / (60 * 60);
        NSInteger minute = (_timeout % (60 * 60)) / 60;
        NSInteger seconds = (_timeout % (60 * 60)) % 60;
        _countDownLbl.text = [NSString stringWithFormat:@"%ld%ld:%ld%ld:%ld%ld自动取消",(long)hour/10,(long)hour%10,(long)minute/10,(long)minute%10,(long)seconds/10,(long)seconds%10];
        _timeout--;
    }
    
    
}



-(void)dealloc{
    [[BBGCountdownManager sharedInstance] removeObserver:self];
}

@end
