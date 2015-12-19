//
//  ShareOrderTopicView.m
//  YHInternational
//
//  Created by bbgds on 15/11/16.
//  Copyright © 2015年 Bubugao. All rights reserved.
//  话题分享视图

#import "BBGShareOrderTopicView.h"
#import "BBGShareOrderTopicLayout.h"
#import "BBGTopicCollectionViewCell.h"

@interface BBGShareOrderTopicView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

//箭头
@property (nonatomic,strong) UIButton *btn_arrow;

@end

@implementation BBGShareOrderTopicView

//-(id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if(self)
//    {
//
//        [_collectionView reloadData];//        NSLog(@"%f",_collectionView.frame);
//    }
//    
//    return self;
//}

-(void)initCollectionView
{
    BBGShareOrderTopicLayout *layout = [[BBGShareOrderTopicLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[BBGTopicCollectionViewCell class] forCellWithReuseIdentifier:@"BBGTopicCollectionViewCell"];
    NSArray *strArray = @[@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"大海",@"天空灰",@"赞",@"大赞",@"真心赞",@"啦啦啦",@"嘿嘿嘿"];
    _strArray = strArray;
    layout.strArray = strArray;
    _btn_arrow = [[UIButton alloc] initWithFrame:CCR(0, 0, 16*2, 35)];
    [_btn_arrow setTitle:@"取消" forState:UIControlStateNormal];
    [_btn_arrow.titleLabel setFont:APP_FONT(16)];
    [_btn_arrow setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //        [_btn_arrow addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    //        [_collectionView setCollectionViewLayout:layout];
    //        [_collectionView setBackgroundColor:[UIColor redColor]];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.size.equalTo(self);
     }];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _strArray.count;
}
//定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 0;
//}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"BBGTopicCollectionViewCell";
    BBGTopicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.topic.text = [_strArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//        return CGSizeMake([self jisuanWidth:indexPath], 30);
//}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)jisuanWidth:(NSIndexPath *)path
{
    //    _strArray = @[@"sdfsdf",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否",@"是对方是否"];
    NSString *str = [_strArray objectAtIndex:path.row];
    return [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}].width;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
