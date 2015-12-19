//
//  BBGMyCommentImageCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyCommentImageCell.h"
#import "UIImage+Stretch.h"


@implementation BBGMyCommentImageCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
    _userImageView.layer.masksToBounds = YES;
    _bgImageView.image = [[UIImage imageNamed:@"三个描边"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1,1) resizingMode:UIImageResizingModeStretch];
    _bgImageView.highlightedImage = [[UIImage imageNamed:@"三个描边-点击反馈"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1,1) resizingMode:UIImageResizingModeStretch];

    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;
    _imageCollectionView.scrollEnabled = NO;
    
    [_imageCollectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    
    _imgListArr = [NSMutableArray array];
    _bigImgArray = [NSMutableArray array];
}

+ (CGFloat)cellHeignt:(BBGComment *)comment{
    
    CGSize size1 = [comment.commentText sizeWithStringFont:APP_FONT(14.0) constrainedToSize:CGSizeMake(IPHONE_WIDTH-99-20, 10000) lineSpacing:8];
    CGFloat height = (IPHONE_WIDTH - 99 - 20)/3;
    if ([comment.imgUrlListArray count] > 3) {
        return size1.height + height*2 + 57;
    }else{
        return size1.height + height + 57;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }else{
//        self.selectionStyle = UITableViewCellSelectionStyleGray;
//        
//    }
}

- (void)updateCell:(BBGComment *)comment{
    
    CGSize replySize = [comment.commentText sizeWithStringFont:APP_FONT(14.0) constrainedToSize:CGSizeMake(IPHONE_WIDTH-99-20, 10000) lineSpacing:8];
    _replyHeightConstrains.constant = replySize.height;
    
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:comment.profileImgUrl] placeholderImage:[UIImage imageNamed:@"头像默认"]];
    _commentNameLabel.text = comment.nickName;
    _commentTimeLabel.text = comment.commentTime;
    if ([comment.hasOrder isEqualToString:@"true"]) {
        _isBuyImageView.image = [UIImage imageNamed:@"已购买标签"];
    }else{
        _isBuyImageView.image = nil;
    }
    
    //    _isESC = YES;
    if (comment.isESC) {
        _commentNameLabel.textColor = UIColorFromHexadecimalRGB(0xf8718c);
        _isBuyImageView.image = [UIImage imageNamed:@"ESC"];
    }
    
//    _commentLabel.text = comment.commentText;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:comment.commentText];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [comment.commentText length])];
    [_commentLabel setAttributedText:attributedString1];
    [_commentLabel sizeToFit];

    
    //小图
    _imgListArr = comment.imgUrlListArray;
    //点击的大图
    if ([comment.imgHdUrlListArray count] > 0) {
        for (int i = 0; i < comment.imgHdUrlListArray.count; i++) {
            [_bigImgArray addObject:[BBGPhotoModel photoWithURL:[NSURL URLWithString:[comment.imgHdUrlListArray objectAtIndex:i]]]];
        }
        [_imageCollectionView reloadData];
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.frame.size.width - 20)/3, (collectionView.frame.size.width - 20)/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0,5,5,0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_imgListArr COUNT];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    [cell updateCell:[_imgListArr ARRAY_OBJ_AT(indexPath.row)]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedImageViewCell:imageArray:)]) {
        [self.delegate didClickedImageViewCell:indexPath imageArray:_bigImgArray];
    }
}


@end
