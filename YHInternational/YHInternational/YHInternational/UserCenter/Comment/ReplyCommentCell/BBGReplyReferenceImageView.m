//
//  BBGReplyReferenceImageView.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGReplyReferenceImageView.h"
#import "UIImage+Stretch.h"

@interface BBGReplyReferenceImageView ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelConstraint;

@end

@implementation BBGReplyReferenceImageView
- (void)awakeFromNib {
    
    _referenceImageCelletionView.delegate = self;
    _referenceImageCelletionView.dataSource = self;
    _referenceImageCelletionView.backgroundColor = UIColorFromHexadecimalRGB(0xfaf9f7);
    _referenceImageCelletionView.scrollEnabled = NO;
    [_referenceImageCelletionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    _imgListArr = [NSMutableArray array];
    _bigImageArr = [NSMutableArray array];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((collectionView.frame.size.width - 25)/3, (collectionView.frame.size.width - 25)/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0,5,5,0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_imgListArr count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:_imgListArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"goodsDefault"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedImageViewCell:imageArray:)]) {
        [self.delegate didClickedImageViewCell:indexPath imageArray:_bigImageArr];
    }
}

- (void)updateCell:(BBGReply *)reply {
    _referenceNameLabel.text = reply.nickName;
    if ([reply.hasOrder isEqualToString:@"true"]) {
        _buyLabel.image = [UIImage imageNamed:@"已购买标签"];
    }else{
        _buyLabel.image = nil;
    }
    
    //    _isESC = YES;
    if (reply.isESC) {
        _referenceNameLabel.textColor = UIColorFromHexadecimalRGB(0xf8718c);
        _buyLabel.image = [UIImage imageNamed:@"ESC"];
    }
    
    _buyDateLabel.text = reply.replyTime;
//    _referenceTextLabel.text = reply.replyText;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:reply.replyText];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [reply.replyText length])];
    [_referenceTextLabel setAttributedText:attributedString1];
    [_referenceTextLabel sizeToFit];

    
    _imgListArr = reply.imgUrlListArray;
    if ([reply.imgHdUrlListArray count] > 0) {
        for (int i = 0; i < reply.imgHdUrlListArray.count; i++) {
            [_bigImageArr addObject:[BBGPhotoModel photoWithURL:[NSURL URLWithString:[reply.imgHdUrlListArray objectAtIndex:i]]]];
        }
        [_referenceImageCelletionView reloadData];
    }
}


@end
