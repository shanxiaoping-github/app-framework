//
//  BBGPraiseView.m
//  YHInternational
//
//  Created by yangjie on 15/5/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPraiseView.h"

#define PraiseViewUserHeadeImgGap 2

@interface BBGPraiseView ()

@property (nonatomic,strong)UITableView *userHeaderTableView;
@property (nonatomic,strong)NSMutableArray *userModelArray;
@property (nonatomic,strong)UIButton *praiseButton;
@property (nonatomic,assign)bool isPraise;

@end

@implementation BBGPraiseView


- (id)initWithFrame:(CGRect)frame userArray:(NSMutableArray *)userArray isPraise:(bool)isPraise{
    self = [super initWithFrame:frame];
    if (self) {
        _userModelArray = [[NSMutableArray alloc] initWithCapacity:10];
        [_userModelArray ARRAY_ADD_OBJS_FROM_ARRAY(userArray)];
        
        _isPraise = isPraise;
        
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseButton setImage:[UIImage imageNamed:@"parise"] forState:UIControlStateNormal];
        [_praiseButton sizeToFit];
        [_praiseButton addTarget:self action:@selector(praiseButtonPressed:) forControlEvents:UIControlEventTouchDown];
        CGRect rect = _praiseButton.frame;
        rect.origin.x = frame.size.width - rect.size.width - 5;;
        [_praiseButton setFrame:rect];
        [_praiseButton setCenter:CGPointMake(_praiseButton.center.x, frame.size.height/2.0)];
        [self addSubview:_praiseButton];
        
        _userHeaderTableView = [[UITableView alloc] init];
        [_userHeaderTableView setRowHeight:frame.size.height+PraiseViewUserHeadeImgGap];
        //[_userHeaderTableView setBackgroundColor:[UIColor redColor]];
        [_userHeaderTableView setScrollEnabled:NO];
        _userHeaderTableView.transform = CGAffineTransformMakeRotation(-M_PI /2.0);
        [_userHeaderTableView setFrame:CGRectMake(0,0, frame.size.width-FRAMEW(_praiseButton)-10, frame.size.height)];
        [_userHeaderTableView setDelegate:self];
        [_userHeaderTableView setDataSource:self];
        [_userHeaderTableView setShowsHorizontalScrollIndicator:NO];
        [_userHeaderTableView setShowsVerticalScrollIndicator:NO];
        [_userHeaderTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self addSubview:_userHeaderTableView];
        
        [self bringSubviewToFront:_praiseButton];
        
        
    }
    return self;
}

- (void)reloadPraiseViewWithUserArray:(NSMutableArray*)userArray isPraise:(bool)isPraise{
    _isPraise = isPraise;
    [_userModelArray removeAllObjects];
    [_userModelArray ARRAY_ADD_OBJS_FROM_ARRAY(userArray)];
    [_userHeaderTableView reloadData];
}


- (void)praiseButtonPressed:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(praiseViewBtnclick:)]) {
        [self.delegate praiseViewBtnclick:self];
    }
}



- (void)praiseSuccess:(BBGUserDetailInfo*)userModel{
    [self praiseButtonAnimation];
    [_userModelArray insertObject:userModel atIndex:0];
    
    [_userHeaderTableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_userHeaderTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [_userHeaderTableView endUpdates];
}

- (void)canclePraiseSuccess:(BBGUserDetailInfo*)userModel{
    [self praiseButtonAnimation];
    NSInteger row = 0;
    
    NSInteger userID = userModel.memberId;
    for (int i=0; i<[_userModelArray COUNT]; i++) {
        BBGUserDetailInfo *tempUserModel = [_userModelArray ARRAY_OBJ_AT(i)];
        if (userID == tempUserModel.memberId) {
            row = i;
            break;
        }
    }
    
    [_userModelArray removeObjectAtIndex:row];
    
    
    [_userHeaderTableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [_userHeaderTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [_userHeaderTableView endUpdates];
}

- (void)praiseButtonAnimation{
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = 0.25;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.byValue = [NSNumber numberWithFloat:0.2];
    animation.toValue = [NSNumber numberWithFloat:2.0];
    [_praiseButton.layer addAnimation:animation forKey:@"SHOW"];
}

#pragma mark collectionView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int row = 0;
    row = [_userModelArray COUNT];
    return row;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIndex = @"userHeaderTableViewCellIndex";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndex];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FRAMEH(self), FRAMEH(self))];
        headerImgView.tag = 1000;
        [cell.contentView addSubview:headerImgView];
    }
    BBGUserDetailInfo *userModel = [_userModelArray ARRAY_OBJ_AT(indexPath.row)];
    UIImageView *headerImgView = (UIImageView*)[cell viewWithTag:1000];
    [headerImgView sd_setImageWithURL:[NSURL URLWithString:userModel.headImg]];
    return cell;
}

@end