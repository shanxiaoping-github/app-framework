//
//  BBGPhraseAssociationRequest.h
//  Common
//
//  Created by Holyjoy on 15/3/23.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGRequest.h"
/**
 *  @author holyjoy, 15-03-23 15:03:46
 *
 *  搜索关键词联想
 */
@interface BBGPhraseAssociationRequest : BBGRequest

/**
 *  @author holyjoy, 15-03-23 15:03:05
 *
 *  已输入的关键字
 */
@property (nonatomic,strong) NSString *keywords;
@end
