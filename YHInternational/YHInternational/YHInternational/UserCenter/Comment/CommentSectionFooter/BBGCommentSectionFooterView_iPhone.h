//
//  BBGCommentSectionFooterView_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/4/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FooterActionBlock)();

@interface BBGCommentSectionFooterView_iPhone : UIView

@property (strong, nonatomic) IBOutlet UIButton *allBtn;

@property (copy, nonatomic) FooterActionBlock block;

@end
