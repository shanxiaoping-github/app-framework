//
//  BBGPhraseAssociationResponse.h
//  Common
//
//  Created by Holyjoy on 15/3/23.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGPhraseAssociation.h"

@interface BBGPhraseAssociationResponse : BBGResponse

/**
 *  @author holyjoy, 15-03-23 15:03:38
 *
 *  自动补全的关键词信息列表
 */
@property (strong,nonatomic) NSMutableArray *phraseAssociationArray;
@end
