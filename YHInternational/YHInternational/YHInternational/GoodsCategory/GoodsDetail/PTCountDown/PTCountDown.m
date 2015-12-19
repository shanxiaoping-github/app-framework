//
//  PTCountDown.m
//  PTDemo
//
//  Created by 彭腾 on 15/6/9.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import "PTCountDown.h"

@implementation PTCountDown

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (void)initObject {
    self.countDown = [UILabel new];
    self.bgImage = [UIImageView new];
    self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:self.bgImage];
    [self addSubview:self.countDown];
    [self addSubview:self.clickBtn];
}

- (void)layoutSubviews {
    self.clickBtn.frame = self.bounds;
    self.bgImage.frame = self.bounds;
    [self.bgImage setImage:[UIImage imageNamed:@"shareRed"]];
    [self.clickBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.countDown.frame = CGRectMake(18, 0, self.bounds.size.width, 20);
    self.countDown.contentMode = NSTextAlignmentCenter;
    self.countDown.textColor = [UIColor redColor];
    __block int timeout=[self.overTime intValue]/1000;
    	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    	dispatch_source_set_event_handler(_timer, ^{
        	    if(timeout<=0){
            	        dispatch_source_cancel(_timer);
            	        dispatch_async(dispatch_get_main_queue(), ^{
                            [self removeFromSuperview];
                            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                            [userDefaults removeObjectForKey:@"redPaper"];
                            [userDefaults synchronize];
                	        });
            	    }else{
                	        int minutes = timeout / 60;
                	        int seconds = timeout % 60;
                            NSString *min;
                            NSString *sec;
                            if (minutes<10) {
                                min = [NSString stringWithFormat:@"0%d",minutes];
                            }else {
                                min = [NSString stringWithFormat:@"%d",minutes];
                            }
                            if (seconds<10) {
                                sec = [NSString stringWithFormat:@"0%d",seconds];
                            }else {
                                sec = [NSString stringWithFormat:@"%d",seconds];
                            }
                	        dispatch_async(dispatch_get_main_queue(), ^{
                                self.countDown.text = [NSString stringWithFormat:@"%@:%@",min,sec];

                    	        });
                	        timeout--;
                	 
                	    }
        	});
    	dispatch_resume(_timer);

}

- (void)handlerButtonAction:(ClickButton)block {
    self.button = block;
}

- (void)btnClick {
    if (self.button) {
        self.button();
    }
}

@end
