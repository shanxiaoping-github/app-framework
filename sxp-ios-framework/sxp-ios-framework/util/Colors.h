//
//  Colors.h
//  WMF
//
//  Created by 单小萍 on 15/6/18.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//
/*颜色定义类*/

#ifndef _Colors_h
#define _Colors_h
#import <UIKit/UIKit.h>
/*颜色生成器*/
#define kColorWithRGB(r, g, b,a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:(a)]

/*颜色定值*/

/*基本字体黑颜色*/
#define shallowGray kColorWithRGB(76,73,72,1)

/*分割线*/
#define diver kColorWithRGB(229,229,229,1)

/*基本背景底色*/
#define baseColor kColorWithRGB(245,245,245,1)

/*hint提示颜色*/
#define hintColor kColorWithRGB(201,201,201,1)

/*淡灰*/
#define lightGrayColor kColorWithRGB(168,168,168,1)
/*浅蓝*/
#define lightBlueColor kColorWithRGB(109,171,207,1)
/*基本底色*/
#define baseColor kColorWithRGB(245,245,245,1)



#endif
