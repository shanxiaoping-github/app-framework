//
//  FontColorString.h
//  TestCustomerLabel
//  Created by 单小萍 on 15/12/3.
//  Copyright © 2015年 单小萍. All rights reserved.
//  待属性的字符串
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FontColorString : NSObject
//字体
@property(nonatomic,strong)UIFont* font;
//颜色
@property(nonatomic,strong)UIColor* color;
//文字
@property(nonatomic,copy)NSString* textStr;
//偏移
@property(nonatomic,assign)CGFloat offsetTop;
@end
