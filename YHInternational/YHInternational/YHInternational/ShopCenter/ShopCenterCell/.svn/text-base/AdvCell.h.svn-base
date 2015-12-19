//
//  AdvCell.h
//  YHInternational
//
//  Created by Damon on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGComponents.h"

@protocol AdvDelegate <NSObject>

- (void)didSelected:(int)currentPage;
@end

typedef void (^AdvBlock)();

@interface AdvCell : UITableViewCell
@property (nonatomic, strong) BBGAdvView * advView;
@property (nonatomic, weak) id<AdvDelegate> delegate;
- (void)updateCell:(id)response;
@end
