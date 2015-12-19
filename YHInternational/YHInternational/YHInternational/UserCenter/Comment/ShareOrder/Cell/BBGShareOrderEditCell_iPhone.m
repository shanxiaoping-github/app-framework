//
//  BBGShareOrderEditCell_iPhone.m
//  YHInternational
//
//  Created by yousai on 15/10/21.
//  Copyright © 2015年 Bubugao. All rights reserved.
//  

#import "BBGShareOrderEditCell_iPhone.h"
#import "ImageCollectionViewCell.h"
#import "BBGShareOrderTopicLayout.h"
#import "BBGTopicCollectionViewCell.h"
#import <Common/Common.h>
@interface BBGShareOrderEditCell_iPhone ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

    @property (strong, nonatomic) IBOutlet UIButton *anonymousBtn;
    @property (strong, nonatomic) IBOutlet UILabel *commentNum;
    @property (strong, nonatomic) IBOutlet UIImageView *bgView;

@end

@implementation BBGShareOrderEditCell_iPhone

- (void)awakeFromNib
{
    /*************************编辑晒单评论*********************************/
    self.commentNum.text = @"0/500";
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.tintColor = UIColorFromHexadecimalRGB(0xf03468);
//    self.bgView.image = _ResizeImage([UIImage imageNamed:@"universal_input_bg"]);
    
    
    BBGShareOrderTopicLayout *layout = [[BBGShareOrderTopicLayout alloc] init];
    [_collectionView setCollectionViewLayout:layout];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [_collectionView registerClass:[BBGTopicCollectionViewCell class] forCellWithReuseIdentifier:@"BBGTopicCollectionViewCell"];
//    NSArray *strArray = @[@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"大海",@"天空灰",@"赞",@"大赞",@"真心赞",@"啦啦啦",@"嘿嘿嘿"];
//    BBGShareOrder *share = (BBGShareOrder *)[_shareOrderArray objectAtIndex:_tableIndexPath.row];
//    _strArray = share.topicArray;
//    shareOrder.topicArray = strArray;
    
//    _strArray = strArray;
//    layout.strArray = strArray;
//    _btn_arrow = [[UIButton alloc] initWithFrame:CCR(0, 0, 16*2, 35)];
//    [_btn_arrow setTitle:@"取消" forState:UIControlStateNormal];
//    [_btn_arrow.titleLabel setFont:APP_FONT(16)];
//    [_btn_arrow setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
}

-(void)setTopicData:(NSMutableArray *)array indexPaht:(NSIndexPath *)path
{
    _shareOrderArray = array;
    _tableIndexPath = path;
    BBGShareOrder *share = (BBGShareOrder *)[_shareOrderArray objectAtIndex:_tableIndexPath.row];
    
    ((BBGShareOrderTopicLayout*)_collectionView.collectionViewLayout).strArray = share.topicArray;
    _strArray = share.topicArray;
    [_collectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)topicAction:(id)sender
{
    BBGShareOrder *share = (BBGShareOrder *)[_shareOrderArray objectAtIndex:_tableIndexPath.row];
    if(share.isOpenTopic)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            _topicHeight.constant = share.openTopicHeight < 82 ? share.openTopicHeight : 82;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if(finished){
            share.isOpenTopic = !share.isOpenTopic;
            [(UITableView *)[[self superview] superview] reloadData];
            }
        }];
        
        [_btn_topic setImage:[UIImage imageNamed:@"topicDown"] forState:UIControlStateNormal];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _topicHeight.constant = share.defaultTopicHeight;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if(finished){
                share.isOpenTopic = !share.isOpenTopic;
                [(UITableView *)[[self superview] superview] reloadData];
            }
        }];
        [_btn_topic setImage:[UIImage imageNamed:@"topicUp"] forState:UIControlStateNormal];
    }
    
    
    
}



#pragma mark =========================文本域编辑框===============================
- (void)displayTextContent:(NSString *)text isAnonymous:(BOOL)isAnonymous{
    self.textView.text = text;
    
    self.commentNum.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)text.length];
    self.anonymousBtn.selected = isAnonymous;
}

- (void)textViewDidChange:(UITextView *)textView{
    //该判断用于联想输入
    if (textView.text.length > 500)
    {
        textView.text = [textView.text substringToIndex:500];
    }
    
    self.commentNum.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.commentNum.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(changeTable:str:isAnonymous:)]) {
        [self.delegate changeTable:self.tag str:@"" isAnonymous:NO];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeTable:str:isAnonymous:)]) {
        [self.delegate changeTable:self.tag str:textView.text isAnonymous:self.anonymousBtn.selected];
    }
    return YES;
}

- (IBAction)anonymousComment:(id)sender
{
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeTable:str:isAnonymous:)]) {
        [self.delegate changeTable:self.tag str:self.textView.text isAnonymous:self.anonymousBtn.selected];
    }
    
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
    
    BBGShareOrder *order = (BBGShareOrder*)[_shareOrderArray objectAtIndex:_tableIndexPath.row];
    if([[order.topicIsSelectArray objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        [cell clickSelect];
    }else
    {
        [cell clickCancle];
    }
    
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
    NSString *str = [_strArray objectAtIndex:path.row];
    return [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}].width;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *strIndexPahth = [NSString stringWithFormat:@"%i",(int)indexPath.row];
    
//    NSLog(@"strIndexPahth:%@",strIndexPahth);
    BBGShareOrder *order = (BBGShareOrder*)[_shareOrderArray objectAtIndex:_tableIndexPath.row];
    if([[order.topicIsSelectArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        [order.topicIsSelectArray setObject:@"1" atIndexedSubscript:indexPath.row];
    }else
    {
        [order.topicIsSelectArray setObject:@"0" atIndexedSubscript:indexPath.row];
    }
    
    [_collectionView reloadData];
//    if([order.topicIsSelectArray containsObject:strIndexPahth])
//    {
//        
//    }else
//    {
//        
//    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
