//
//  BBGPayTypeCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayTypeCell_iPhone.h"
#import "BBGPayButtonView_iPhone.h"
#import "BBGPayTypeButtonCVCell_iPhone.h"

#define BUTTONWIDTH 80
#define BUTTONHEIGHT 85


@interface BBGPayTypeCell_iPhone ()<BBGPayButtonViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    BOOL isShowOtherPayType;
}

//@property (nonatomic,strong)BBGPayButtonView_iPhone *payButtonView_1;
//@property (nonatomic,strong)BBGPayButtonView_iPhone *payButtonView_2;
//@property (nonatomic,strong)BBGPayButtonView_iPhone *payButtonView_3;
@property (nonatomic,strong)BBGPayType *payType;

@property (nonatomic,strong) NSString *selectPayCode;

@property (nonatomic,strong) NSArray *payTypes;

@property (nonatomic,strong) NSMutableArray *muPayTypes;


//支付类型的CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *payTypeCollectionView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cv_trailing;

@end
@implementation BBGPayTypeCell_iPhone

- (void)awakeFromNib {
    
    _cv_trailing.constant = -IPHONE_WIDTH;
    [_payTypeCollectionView registerClass:[BBGPayTypeButtonCVCell_iPhone class] forCellWithReuseIdentifier:@"BBGPayTypeButtonCVCell_iPhone"];
    _payTypeCollectionView.delegate = self;
    _payTypeCollectionView.dataSource = self;
    _payTypeCollectionView.scrollEnabled = NO;
    _payTypeCollectionView.backgroundColor = [UIColor whiteColor];
//    _payTypeCollectionView.frame = CGRectMake(_payTypeCollectionView.frame.origin.x, _payTypeCollectionView.frame.origin.y, IPHONE_WIDTH*2, _payTypeCollectionView.frame.size.height);
    

}

-(void)updatePayTypeCellWithPayTypes:(NSMutableArray *)payTypes selectedPayType:(BBGPayType *)selectedPayType
{
    _payTypes = payTypes;
    _selectPayCode = selectedPayType.payCode;
    _muPayTypes = [[NSMutableArray alloc] initWithArray:_payTypes];
    
    if(!isShowOtherPayType && _muPayTypes != nil && _muPayTypes.count > 1)
    {
        BBGPayType *more = [[BBGPayType alloc] init];
        more.payCode = @"MORE";
        more.payName = @"更多";
        [_muPayTypes insertObject:more atIndex:1];
    }else
    {
        isShowOtherPayType = YES;
    }
    [_payTypeCollectionView reloadData];
}


-(void)updateSubViewsFrameWithWidth:(CGFloat)width
{
   
}


-(BBGPayButtonView_iPhone *)creatFiterButton:(CGRect)frame{
    
    BBGPayButtonView_iPhone *payButton = [[[NSBundle mainBundle] loadNibNamed:@"BBGPayButtonView_iPhone" owner:nil options:nil] firstObject];
    payButton.frame = frame;
    payButton.delegate = self;
    return payButton;
}

- (void)payButtonDidChange:(BBGPayType *)payType
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(payTypeDidChange:)]) {
        [self.delegate payTypeDidChange:payType];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_muPayTypes == nil)return 0;
    return _muPayTypes.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"BBGPayTypeButtonCVCell_iPhone";
    BBGPayTypeButtonCVCell_iPhone * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    BBGPayType *payType = [_muPayTypes objectAtIndex:indexPath.row];
    [cell.payIconImg sd_setImageWithURL:[NSURL URLWithString:payType.iconUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [cell.payIconImg setFadeInWithDefaultTime];
        }
    }];

    cell.payNameLbl.text = payType.payName;
    if([_selectPayCode isEqualToString:payType.payCode])
    {
        cell.selectedIconImg.hidden = NO;
        cell.payNameLbl.textColor = UIColorFromRGB(236, 43, 86);
    }else
    {
        cell.selectedIconImg.hidden = YES;
        cell.payNameLbl.textColor = UIColorFromHexadecimalRGB(0x666666);
    }
    
    if([payType.payCode isEqualToString:@"MORE"])
    {
        [cell.payIconImg setImage:[UIImage imageNamed:@"支付更多"]];
    }
    
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [_payTypeCollectionView beginInteractiveMovementForItemAtIndexPath:<#(nonnull NSIndexPath *)#>];
    if(isShowOtherPayType)
    {
        return CGSizeMake(self.frame.size.width/_muPayTypes.count, 80);
    }else
    {
        return CGSizeMake(self.frame.size.width/2, 80);
    }
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    CGFloat totalSpaceWidth = width-(3*BUTTONWIDTH);
//    CGFloat space = totalSpaceWidth/4;//间距
    CGFloat topSpace = (self.frame.size.height-BUTTONHEIGHT)*0.5;//上间距
    return UIEdgeInsetsMake(topSpace, 0, 0, 0);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BBGPayType *type = [_muPayTypes objectAtIndex:indexPath.row];
    if([type.payCode isEqualToString:@"MORE"])
    {
        [_muPayTypes removeObjectAtIndex:1];
        [_payTypeCollectionView reloadData];
        isShowOtherPayType = YES;
        return;
    }
    [self payButtonDidChange:[_muPayTypes objectAtIndex:indexPath.row]];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
