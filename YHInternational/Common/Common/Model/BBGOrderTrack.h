//
//  BBGOrderTrack.h
//  Common
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGOrderTrack : BBGResponseDataHandler

@property (nonatomic,strong)NSDate *trackTime;
@property (nonatomic,strong)NSString *trackInfo;
@property (nonatomic,strong)NSString *type;
@end
