//
//  BBGLogisticsSection.h
//  YHInternational
//
//  Created by Damon on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGLogisticsSection : UITableViewCell
@property (nonatomic, assign) BOOL isSpread;

- (void)updateSection:(id)response;
@end
