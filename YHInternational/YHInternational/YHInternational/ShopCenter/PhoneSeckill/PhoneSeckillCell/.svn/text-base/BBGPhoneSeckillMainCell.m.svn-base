//
//  BBGPhoneSeckillMainCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/9/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillMainCell.h"
#import "BBGPTPriceView.h"

@interface BBGPhoneSeckillMainCell () {
    CAKeyframeAnimation *animation;
    NSTimer *timer;
    NSTimer *countDownTimer;
    NSInteger num;
}

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet BBGPTPriceView *priceView;
@property (nonatomic, assign) NSTimeInterval allTime;

@end

@implementation BBGPhoneSeckillMainCell

- (void)updateCellWith:(BBGSecKillProduct *)model Time:(BBGPhoneSeckillModel *)time sign:(NSString *)sign section:(NSInteger)section{
    num = section;
//    timer = [NSTimer scheduledTimerWithTimeInterval:1.35f
//                                             target:self
//                                           selector:@selector(addAnimation)
//                                           userInfo:nil
//                                            repeats:NO];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    if ([sign isEqualToString:@"0"]) {
        [self addAnimation];
    }
    WS(weakSelf);
    NSArray *timeArr = [time.startDate componentsSeparatedByString:@" "];
    NSArray *yearArr = [[timeArr ARRAY_OBJ_AT(0)] componentsSeparatedByString:@"-"];
    NSArray *hourArr = [[timeArr ARRAY_OBJ_AT(1)] componentsSeparatedByString:@":"];
    self.lightningLab.text = [NSString stringWithFormat:@"%@日%@时开抢",[yearArr ARRAY_OBJ_AT(2)],[hourArr ARRAY_OBJ_AT(0)]];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [weakSelf.goodsImage setFadeInWithDefaultTime];
        }
    }];

    self.goodsName.text = model.productName;
    self.priceView.unCrossPrice = model.unCrosedPrice;
    self.priceView.crossPrice = model.crossedPrice;
    [self.priceView layoutSubviews];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter dateFromString:time.startDate];
    NSDate *sysDate = [[BBGConfiguration sharedInstance]getCurrentServerTime];
    NSTimeInterval start = [startDate timeIntervalSince1970];
    NSTimeInterval sys = [sysDate timeIntervalSince1970];
    [self countDown:sys andStart:start];
}

- (void)addAnimation {
    self.lightningView.image = [UIImage imageNamed:@"shandian0027"];
    NSMutableArray *animationArr = [NSMutableArray array];
    for(NSUInteger i = 1;i < 28; i++) {
        NSString *string;
        if (i < 10) {
            string = [NSString stringWithFormat:@"shandian000%ld",(long)i];
        }else {
            string = [NSString stringWithFormat:@"shandian00%ld",(long)i];
        }
        UIImage *image = [UIImage imageNamed:string];
        CGImageRef cgImageRef = image.CGImage;
        [animationArr addObject:(__bridge UIImage *)cgImageRef];
    }
    animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.duration = 1.35;
    animation.delegate = self;
    animation.values = animationArr;
    [self.lightningView.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        self.lightningLab.hidden = NO;
        animation.delegate = nil;
        animation.values = nil;
        [self.lightningView.layer removeAllAnimations];
//        [timer invalidate];
//        timer = nil;
        [self.delegate animationFinish:num];
    }
}

- (void)countDown:(NSTimeInterval)sys andStart:(NSTimeInterval)start {
    self.allTime = start - sys;
    [[BBGCountdownManager sharedInstance]addObserver:self];
}

- (void)countdown {
    self.allTime -= 1;
    if (self.allTime < 0) {
        [self.delegate reload];
    }
}

- (void)awakeFromNib {
    // Initialization code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(135.0f, self.frame.size.height-0.5f, IPHONE_WIDTH-135.0f, 0.5f);
    bottomBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
    [self.layer addSublayer:bottomBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [[BBGCountdownManager sharedInstance]removeObserver:self];
}

@end
