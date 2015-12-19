//
//  BBGContentFactory_iPhone.h
//  BuBuGao
//
//  Created by calvin on 14-8-14.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGContentProtocol.h"
@interface BBGContentFactory_iPhone : NSObject

+ (BBGContentFactory_iPhone *)sharedInstance;
- (UIViewController<BBGContentProtocol> *)buildContentByMenuItem:(BBGMenuItem *)item;

@end
