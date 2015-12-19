//
//  BBGPickerView.h
//  Components
//
//  Created by Damon on 15/5/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PickerAction)(id response);

typedef void (^AddressViewCallBack) (BOOL selected,NSString *p,NSString *c,NSString *d,NSString *s,NSString *pID,NSString *cID,NSString *dID,NSString *sID);

@interface BBGPickerView : UIView

+(BBGPickerView *)sharedInstance;

- (void)showWithDone:(PickerAction)block;

@end
