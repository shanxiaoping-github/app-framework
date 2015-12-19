//
//  BBGOrderDetailActiveCell_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBGOrderDetailActiveCell_iPhone : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *payTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderActiveLbl;
+(CGFloat)cellHeightWithContent:(NSString *)content;
@end
