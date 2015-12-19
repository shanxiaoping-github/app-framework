//
//  BBGLineView.h
//  BBGAlertView
//
//  Created by yangjie on 15/4/21.
//  Copyright (c) 2015年 yangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum BBGLineTypeType{
    none,
    horizon,
    vertical
}BBGLineType;

@interface BBGLineView : UIView

@property(nonatomic,assign)BBGLineType lineType;
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)float length;
@property(nonatomic,assign)float width;
@property(nonatomic,retain)UIColor* color;

+(BBGLineView*)horizonlineWithStart:(CGPoint)start len:(float)len width:(float)width color:(UIColor*)color;
+(BBGLineView*)verticallineWithStart:(CGPoint)start len:(float)len width:(float)width color:(UIColor*)color;

@end
