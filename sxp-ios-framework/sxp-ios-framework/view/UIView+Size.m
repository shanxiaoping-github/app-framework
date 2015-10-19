//
//  UIView+Size.m
//  sxp-ios-framework
//
//  Created by 单小萍 on 15/9/14.
//  Copyright (c) 2015年 womaif.beijin.com. All rights reserved.
//

#import "UIView+Size.h"
#import <objc/runtime.h>
static char* keyOldframe  = "oldframe";
static char* keyVisible = "visible";
@interface FrameObject : NSObject
@property(nonatomic,assign)CGRect frame;
-(instancetype)initFrame:(CGRect)frame;
@end
@implementation FrameObject
@synthesize frame=_frame;
-(instancetype)initFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.frame = frame;
    }
    return self;
}
@end

@interface NSDisplayObject : NSObject
@property(nonatomic,assign)NSDisplay display;
@end
@implementation NSDisplayObject
@synthesize display=_display;
@end

@implementation UIView (Size)
-(CGFloat)right{
    return self.frame.origin.x+self.frame.size.width;
}
-(CGFloat)left{
    return self.frame.origin.x;
}
-(CGFloat)top{
    return self.frame.origin.y;
}
-(CGFloat)bottom{
    return self.frame.origin.y+self.frame.size.height;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height;
}
-(FrameObject*)oldFrame{
    FrameObject* frameObject = (FrameObject*)objc_getAssociatedObject(self,&keyOldframe);
    return frameObject;
}
-(void)setOldFrame:(CGRect)oldFrame{
    if (![self oldFrame]) {
        objc_setAssociatedObject(self,&keyOldframe,[[FrameObject alloc]initFrame:oldFrame],OBJC_ASSOCIATION_RETAIN);
    }
}
-(void)setDisPlay:(NSDisplay)visible{
    NSDisplayObject* displayObject = [[NSDisplayObject alloc]init];
    displayObject.display  = visible;
    objc_setAssociatedObject(self,&keyVisible,displayObject,OBJC_ASSOCIATION_RETAIN);
}

-(void)setFrame:(CGRect)frame{
    self.frame = frame;
    [self setOldFrame:frame];
}




-(void)setVisible:(NSDisplay)visible orientation:(NSInteger)orientation{
    switch (visible) {
        case NSDisplayVisible:{
            self.frame = [self oldFrame].frame;
            self.hidden = NO;
        }
            break;
        case NSDisplayGone:{
            switch (orientation) {
                case HORIZONTAL:
                    self.frame =CGRectMake(self.frame.origin.x,self.frame.origin.y,0.f,self.frame.size.height);
                    break;
                case VERTICAL:
                    self.frame =CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,0.f);
                    break;
            }
            self.hidden = YES;
        }
            break;
        case NSDisplayInVisible:
            self.hidden = YES;
            break;
    }
    
    [self setDisPlay:visible];
    //if (self.superview){
    //    [self.superview layoutIfNeeded];
    //}
    
}
-(void)setVisible:(NSDisplay)visible{
    [self setVisible:visible orientation:VERTICAL];
}
-(NSDisplay)visible{
    NSDisplayObject* disPlayObject =  (NSDisplayObject*)objc_getAssociatedObject(self,&keyVisible);
    if(!disPlayObject){
        disPlayObject = [[NSDisplayObject alloc]init];
        disPlayObject.display = NSDisplayVisible;
        objc_setAssociatedObject(self,&keyVisible,disPlayObject,OBJC_ASSOCIATION_RETAIN);
    }
    return disPlayObject.display;
}

-(void)dealloc{
    objc_removeAssociatedObjects(self);
}

@end


