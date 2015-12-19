//
//  BBGIDCardEditViewController_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/6/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIDCardEditViewController.h"

@protocol BBGIDCardEditViewDelegate <NSObject>
//修改成功回调
-(void)editIDCardSuccess;
@end

@interface BBGIDCardEditViewController_iPhone : BBGIDCardEditViewController

//是否编辑身份证
@property(nonatomic,assign) BOOL isEdit;
//上个界面传过来的要编辑的身份证
@property(nonatomic,strong)BBGIDCard *editIDCard;

@property(nonatomic,weak)id<BBGIDCardEditViewDelegate> delegate;

@end
