//
//  PTFlowLayout.m
//  testDemo
//
//  Created by 彭腾 on 15/8/12.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import "PTFlowLayout.h"

NSString *const PTCollectionViewHeader = @"PTCollectionViewHeader";
NSString *const PTCollectionViewFooter = @"PTCollectionViewFooter";
NSString *const PTCollectionViewCell = @"PTCollectionViewCell";

@interface PTFlowLayout (){
    CGSize totalSize;
}
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSDictionary *layoutInfo;
@end

@implementation PTFlowLayout

- (id)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 5;
        self.minimumLineSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return self;
}

- (id)initWithSectionNum:(NSInteger)sectionNum {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 11.0f;
        self.minimumLineSpacing = 11.0f;
        self.sectionInset = UIEdgeInsetsMake(11, 11, 11, 11);
        self.section = sectionNum;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    NSMutableDictionary *mainLayoutDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *headerLayoutDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *footerLayoutDictionary = [NSMutableDictionary dictionary];
    NSMutableArray *sectionHeightArray = [NSMutableArray arrayWithCapacity:self.section];
    NSMutableArray *sectionTotalHeightArray = [NSMutableArray arrayWithCapacity:self.section];
    
    for (NSInteger section = 0; section<self.section; section++) {
        CGFloat xNextOffset = self.sectionInset.left;
        CGFloat xOffset = self.sectionInset.left;
        CGFloat yOffset;
        if (section == 0) {
            yOffset = 0;
        }else {
            //            NSNumber *num = sectionHeightArray[section-1];
            NSNumber *num = sectionTotalHeightArray[section-1];
            CGFloat f = [num floatValue];
            yOffset = self.sectionInset.top+f;
        }
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item<itemCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            if (indexPath.item == 0) {
                if ([self.delegate conformsToProtocol:@protocol(PTFlowLayoutDelegate)]&&[self.delegate respondsToSelector:@selector(collectionView:layout:estimatedSizeForHeaderInSection:)] ) {
                    CGSize size = [self.delegate collectionView:self.collectionView layout:self estimatedSizeForHeaderInSection:section];
                    
                    UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:PTCollectionViewHeader withIndexPath:indexPath];
                    headerAttributes.frame = CGRectMake(0, 0+yOffset, size.width, size.height);
                    yOffset += size.height;
                    headerLayoutDictionary[indexPath] = headerAttributes;
                }
            }
            //            NSLog(@"%f",self.minimumInteritemSpacing);
            xNextOffset += (self.minimumInteritemSpacing + itemSize.width);
            if (xNextOffset > [self collectionView].bounds.size.width /*- self.sectionInset.right*/) {
                xOffset = self.sectionInset.left;
                xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width);
                yOffset += (itemSize.height + self.minimumLineSpacing);
            }
            else
            {
                xOffset = xNextOffset - (self.minimumInteritemSpacing + itemSize.width);
            }
            
            UICollectionViewLayoutAttributes *layoutAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            layoutAttributes.frame = CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height);
            
            if (item == itemCount - 1) {
                yOffset = yOffset + itemSize.height;
            }
            
            cellLayoutDictionary[indexPath] = layoutAttributes;
            
            if ([self theLastItemAtIndexPath:indexPath]) {
                if ([self.delegate conformsToProtocol:@protocol(PTFlowLayoutDelegate)]&&[self.delegate respondsToSelector:@selector(collectionView:layout:estimatedSizeForFooterInSection:)]) {
                    CGSize size = [self.delegate collectionView:self.collectionView layout:self estimatedSizeForFooterInSection:section];
                    
                    UICollectionViewLayoutAttributes *footerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:PTCollectionViewFooter withIndexPath:indexPath];
                    footerAttributes.frame = CGRectMake(0, yOffset+itemSize.height-30.0f, size.width, size.height);
                    yOffset += size.height;
                    footerLayoutDictionary[indexPath] = footerAttributes;
                }
            }
        }
        
        NSNumber *num = [NSNumber numberWithDouble:yOffset];
        sectionTotalHeightArray[section] = num;
        
        if (section == 0) {
            NSNumber *num = [NSNumber numberWithDouble:yOffset];
            sectionHeightArray[section] = num;
        }else {
            NSNumber *differ = sectionTotalHeightArray[section-1];
            CGFloat number = 0;
            number = yOffset;
            number -= [differ floatValue];
            NSNumber *num = [NSNumber numberWithDouble:number];
            sectionHeightArray[section] = num;
        }
    }
    mainLayoutDictionary[PTCollectionViewCell] = cellLayoutDictionary;
    mainLayoutDictionary[PTCollectionViewHeader] = headerLayoutDictionary;
    mainLayoutDictionary[PTCollectionViewFooter] = footerLayoutDictionary;
    
    self.layoutInfo = mainLayoutDictionary;
    
    
    CGFloat totalHeight=0;
    
    for (NSInteger i=0; i<sectionHeightArray.count; i++) {
        NSNumber *num = sectionHeightArray[i];
        totalHeight += [num floatValue];
    }
    
    totalHeight += 35.0f;
    
    totalSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, totalHeight);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[PTCollectionViewCell][indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[kind][indexPath];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *stop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (NSInteger)itemCountAtSection:(NSInteger)section {
    return [[self collectionView] numberOfItemsInSection:section];
}

- (BOOL)theLastItemAtIndexPath:(NSIndexPath *)indexPath {
    if((indexPath.row + 1) == [self itemCountAtSection:indexPath.section]) {
        return YES;
    }
    
    return NO;
}

- (CGSize)collectionViewContentSize {
    return totalSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return NO;
}

@end
