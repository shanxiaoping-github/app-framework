//
//  BBGTopicExplain.m
//  Components
//
//  Created by 黄 灿 on 15/10/21.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGTopicExplainView.h"
#import "NSString+TitleSize.h"
#import "BBGTools.h"
#import "BBGMacro.h"
//左右可空得固定宽度
#define TOPIC_WIDTH 5
//上下可空得固定高度
#define TOPIC_HEIGHT 5
//button间隔
#define TOPIC_SPACE 5
//button高度
#define TOPIC_BUTTON_HEIGHT 24

//右边点击区域宽度
#define TOPIC_CLICK  40
@implementation BBGTopicExplainView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        scrollerView = [[UIScrollView alloc]init];
        [self addSubview:scrollerView];
        scrollerView.backgroundColor = UIColorFromHexadecimalRGB(0xf8f8f8);
        [self reloadSubViews];
        [self.layer setMasksToBounds:YES];
        
        __weak BBGTopicExplainView *weakSelf = self;
        
        rightView = [[UIView alloc]init];
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.size.mas_equalTo(CGSizeMake(35, 2*TOPIC_HEIGHT+TOPIC_BUTTON_HEIGHT +10));
        }];
        
        
        rightButtonImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"topicUp"]];
        [rightView addSubview:rightButtonImageView];
        [rightButtonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(rightView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClicked:)];
        [rightView addGestureRecognizer:gesture];
        
        //顶部画一条线
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = UIColorFromHexadecimalRGB(0xfcccccc);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf);
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.height.mas_equalTo(@0.5);
        }];
    }
    return self;
}

//后面的+10 代表着控件顶部与底部 的间距比button上下间距一共大10  于是为了保证scrollerview里面间距统一  我把scrollerView上下都与外层间隔5

-(void)reloadSubViews{

    __weak BBGTopicExplainView *WeakSelf = self;
    [scrollerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WeakSelf.mas_top).offset(5);
        make.left.equalTo(WeakSelf);
        make.right.equalTo(WeakSelf.mas_right).offset(-TOPIC_CLICK);
        make.bottom.equalTo(WeakSelf.mas_bottom).offset(-5);
    }];
    //当前button所处的高度和前置空间长度以及当前button 所需要的长度
    float nowX =TOPIC_WIDTH,nowY =TOPIC_HEIGHT ,buttonWidth;
    numberLines = 1;
    for (int i =0; i<[_dataArray count]; i++) {
        UIButton *bu = [[UIButton alloc]init];
        bu.tag = 1000+i;
        [bu setTitle:_dataArray[i] forState:UIControlStateNormal];
        [bu setTitleColor: UIColorFromHexadecimalRGB(0xf333333) forState:UIControlStateNormal];
        bu.titleLabel.font = APP_FONT(12);
        [bu setBackgroundColor:[UIColor whiteColor]];
        bu.layer.borderWidth =0.5;
        bu.layer.borderColor = [UIColorFromHexadecimalRGB(0xfe5e5e5)CGColor];
        bu.layer.cornerRadius =TOPIC_BUTTON_HEIGHT/2;
        [bu addTarget:self action:@selector(topicClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollerView addSubview:bu];
        //计算出当前button 所需要的长度
        NSString *string =_dataArray[i];
        buttonWidth = [string sizeWithStringFont:[UIFont fontWithName:@"Arial" size:12]].width+10;
        if (self.frame.size.width-TOPIC_CLICK -nowX-TOPIC_SPACE-TOPIC_WIDTH>buttonWidth ) {
            //即当当前行所剩的长度足够容纳此button
            [bu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(scrollerView.mas_top).offset(nowY);
                make.left.equalTo(scrollerView.mas_left).offset(nowX+TOPIC_SPACE);
                make.width.mas_equalTo(buttonWidth);
                make.height.mas_equalTo(TOPIC_BUTTON_HEIGHT);
            }];
            nowX = nowX + TOPIC_SPACE +buttonWidth;
        }else{
            //即当当前行所剩的长度不足够容纳此button 得换行
            nowY = nowY +TOPIC_HEIGHT +TOPIC_BUTTON_HEIGHT;
            nowX = TOPIC_WIDTH;
            [bu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(scrollerView.mas_top).offset(nowY);
                make.left.equalTo(scrollerView.mas_left).offset(nowX+TOPIC_SPACE);
                make.width.mas_equalTo(buttonWidth);
                make.height.mas_equalTo(TOPIC_BUTTON_HEIGHT);
            }];
            nowX = nowX + TOPIC_SPACE +buttonWidth;
            numberLines ++;
            
        }
        scrollerView.contentSize =CGSizeMake(scrollerView.frame.size.width,nowY+TOPIC_HEIGHT+TOPIC_BUTTON_HEIGHT);
        [self.tempArray addObject:@"0"];
    }
    self.frame = CGRectMake(0
                            , self.frame.origin.y-2*TOPIC_HEIGHT+TOPIC_BUTTON_HEIGHT-10, IPHONE_WIDTH, 2*TOPIC_HEIGHT+TOPIC_BUTTON_HEIGHT +10);
    
    scrollerView.scrollEnabled=NO;
    
}

-(void)buttonClicked:(UIButton *)sender{
    scrollerView.contentOffset=CGPointMake(0, 0);
    __weak BBGTopicExplainView *weakSelf = self;
    //展开高度
    float height;
    if (numberLines>3) {
        height = 2*(TOPIC_BUTTON_HEIGHT+TOPIC_HEIGHT);
    }else{
        height = (numberLines-1)*(TOPIC_BUTTON_HEIGHT+TOPIC_HEIGHT);
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (isUnfurl) {
            
            weakSelf.frame = CGRectMake(0
                                        , weakSelf.frame.origin.y+height, IPHONE_WIDTH, 2*TOPIC_HEIGHT+TOPIC_BUTTON_HEIGHT+10);
            
            scrollerView.scrollEnabled=NO;
            
            isUnfurl =NO;
            rightButtonImageView.image = [UIImage imageNamed:@"topicUp"];
        }else{
            weakSelf.frame = CGRectMake(0
                                        , weakSelf.frame.origin.y-height, IPHONE_WIDTH, 2*TOPIC_HEIGHT+TOPIC_BUTTON_HEIGHT+height+10);
            isUnfurl =YES;
            scrollerView.scrollEnabled=YES;
            rightButtonImageView.image = [UIImage imageNamed:@"topicDown"];
        }
        
        
    }];
    
    
}
- (void)topicClicked:(UIButton *)sender{
    if ([[self.tempArray ARRAY_OBJ_AT(sender.tag-1000)] isEqualToString:@"0"]) {
        sender.backgroundColor = UIColorFromHexadecimalRGB(0xf03468);
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.tempArray[sender.tag-1000]=@"1";
        
    }else{
        sender.backgroundColor = UIColorFromHexadecimalRGB(0xffffff);
        [sender setTitleColor:UIColorFromHexadecimalRGB(0xf333333) forState:UIControlStateNormal];
        self.tempArray[sender.tag-1000]=@"0";
    }
    
}
//往上移动  动画的时间
-(void)moveViewWithDistance:(float)newY animationTime:(float)animationTime{
    [UIView animateWithDuration:animationTime animations:^{
        self.frame =CGRectMake(self.frame.origin.x, newY-self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
}
- (NSArray *)tempArray{
    if (!_tempArray) {
        _tempArray = [[NSMutableArray alloc]init];
    }
    return _tempArray;
}
@end
