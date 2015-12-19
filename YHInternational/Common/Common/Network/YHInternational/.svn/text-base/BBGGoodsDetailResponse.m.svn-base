//
//  BBGGoodsDetailResponse.m
//  Common
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsDetailResponse.h"
#import "BBGPraiseMembs.h"
#import "BBGGoodsTip.h"
#import "BBGPromotionActivities.h"
#import "BBGGoodsDetailImages.h"
#import "BBGGoodsBasicInfo.h"
#import "BBGGoodsSpecQuery.h"
#import "BBGComment.h"

@implementation BBGGoodsDetailResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        BBGResponseData *data1;
        DATA_FOR_KEY(data1, @"data")
        
        if ([data1 count]) {
            _basicInfo = [NSMutableArray arrayWithCapacity:[data1 count]] ;
            
            BBGGoodsBasicInfo *bbgGoodsBasicInfo = [[BBGGoodsBasicInfo alloc]initWithHandler:self responseData:data1] ;
            [_basicInfo addObject:bbgGoodsBasicInfo] ;
        }

        
        BBGResponseData *praiseMembsList ;
        DATA_FOR_KEY_DATA(praiseMembsList, @"praiseMembs", data1)
        
        if ([praiseMembsList count]) {
            _praiseMembsArr = [NSMutableArray arrayWithCapacity:[praiseMembsList count]] ;
            
            for (NSInteger i = 0; i < [praiseMembsList count]; i++) {
                BBGResponseData *praiseMembs ;
                DATA_FOR_INDEX_DATA(praiseMembs, i, praiseMembsList)

                BBGPraiseMembs *bbgPraiseMembs = [[BBGPraiseMembs alloc]initWithHandler:self responseData:praiseMembs] ;
                [_praiseMembsArr addObject:bbgPraiseMembs] ;
            }
        }
        
        BBGResponseData *goodsTipList ;
        DATA_FOR_KEY_DATA(goodsTipList, @"goodsTip", data1)
        
        if ([goodsTipList count]) {
            _goodsTipArr = [NSMutableArray arrayWithCapacity:[goodsTipList count]] ;
            
            for (NSInteger i = 0; i < [goodsTipList count]; i++) {
                BBGResponseData *goodsTip ;
                DATA_FOR_INDEX_DATA(goodsTip, i, goodsTipList)
                
                BBGGoodsTip *bbgGoodsTip = [[BBGGoodsTip alloc]initWithHandler:self responseData:goodsTip] ;
                [_goodsTipArr addObject:bbgGoodsTip] ;
            }
        }
        
        BBGResponseData *promotionActivitiesList ;
        DATA_FOR_KEY_DATA(promotionActivitiesList, @"promotionActivities", data1)
    
        if ([promotionActivitiesList count]) {
            _promotionActivitiesArr = [NSMutableArray arrayWithCapacity:[promotionActivitiesList count]] ;
            
            for (NSInteger i = 0; i < [promotionActivitiesList count]; i++) {
                BBGResponseData *promotionActivities ;
                DATA_FOR_INDEX_DATA(promotionActivities, i, promotionActivitiesList)
                
                BBGPromotionActivities *bbgProAct = [[BBGPromotionActivities alloc]initWithHandler:self responseData:promotionActivities] ;
                [_promotionActivitiesArr addObject:bbgProAct] ;
            }
        }
        
        BBGResponseData *goodsImagesList ;
        DATA_FOR_KEY_DATA(goodsImagesList, @"goodsImages", data1)
        
        if ([goodsImagesList count]) {
            _goodsImagesArr = [NSMutableArray arrayWithCapacity:[goodsImagesList count]] ;
            
            for (NSInteger i = 0; i < [goodsImagesList count]; i++) {
                BBGResponseData *goodsImage ;
                DATA_FOR_INDEX_DATA(goodsImage, i, goodsImagesList)
                
                BBGGoodsDetailImages *bbgGoodsImages = [[BBGGoodsDetailImages alloc]initWithHandler:self responseData:goodsImage] ;
                [_goodsImagesArr addObject:bbgGoodsImages] ;
            }
        }
        
        BBGResponseData *commentList ;
        DATA_FOR_KEY_DATA(commentList, @"comments", data1)
        
        if ([commentList count]) {
            _commentListArr = [NSMutableArray arrayWithCapacity:[commentList count]] ;
            
            for (NSInteger i = 0; i < [commentList count]; i++) {
                BBGResponseData *comment ;
                DATA_FOR_INDEX_DATA(comment, i, commentList)
                
                BBGComment *bbgComment = [[BBGComment alloc]initWithHandler:self responseData:comment] ;
                [_commentListArr addObject:bbgComment] ;
            }
        }
        
        BBGResponseData *goodsSpecsList ;
        DATA_FOR_KEY_DATA(goodsSpecsList, @"skuNames", data1)
        
        if ([goodsSpecsList count]) {
            _goodsSpecsListArr = [NSMutableArray arrayWithCapacity:[goodsSpecsList count]] ;
            
            for (NSInteger i = 0; i < [goodsSpecsList count]; i++) {
                BBGResponseData *goodsSpecs ;
                DATA_FOR_INDEX_DATA(goodsSpecs, i, goodsSpecsList)
                
                BBGGoodsSpecQuery *bbgSpecQuery = [[BBGGoodsSpecQuery alloc]initWithHandler:self responseData:goodsSpecs] ;
                [_goodsSpecsListArr addObject:bbgSpecQuery] ;
            }
        }
    }
    return self ;
}

@end
