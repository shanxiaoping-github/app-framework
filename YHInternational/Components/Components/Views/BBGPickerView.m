//
//  BBGPickerView.m
//  Components
//
//  Created by Damon on 15/5/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPickerView.h"
#import "Common.h"
@interface BBGPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView * pickerView;
@property (nonatomic, strong) UIView * handleView;
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) UIButton * doneBtn;

@property (nonatomic, strong) PickerAction block;

@property (nonatomic, strong) NSString * response;

@property (nonatomic, copy) AddressViewCallBack callback;
@property (nonatomic, assign) NSInteger provinceSelectIndex;
@property (nonatomic, assign) NSInteger citySelectIndex;
@property (nonatomic, assign) NSInteger districtSelectIndex;
@property (nonatomic, assign) NSInteger streetSelectIndex;
@property (nonatomic, strong) NSArray *regionList;

@end

@implementation BBGPickerView

DECLARE_SINGLETON(BBGPickerView)

-(BOOL)stringCompare:(NSString *)str1 str2:(NSString *)str2{
    BOOL result = NO;
    if (str1 && str2 ) {
        if ([str1 rangeOfString:str2].location != NSNotFound || [str1 rangeOfString:str2].location != NSNotFound) {
            
            result = YES;
        }
    }
    return result;
}

- (void)calculateSelectIndexWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district street:(NSString *)street {
    int i = 0;
    for (BBGRegion *provinceRegion in self.regionList) {
        if ([self stringCompare:provinceRegion.name str2:province]) {
            _provinceSelectIndex = i;
            int j = 0;
            for (BBGRegion *cityRegion in provinceRegion.regionChildren) {
                if ([self stringCompare:cityRegion.name str2:city]) {
                    _citySelectIndex = j;
                    int k = 0;
                    for (BBGRegion *districtRegion in cityRegion.regionChildren) {
                        if ([self stringCompare:districtRegion.name str2:district]) {
                            _districtSelectIndex = k;
                            int l = 0;
                            for (BBGRegion *streetRegion in districtRegion.regionChildren) {
                                if ([self stringCompare:streetRegion.name str2:street]) {
                                    _streetSelectIndex = l;
                                    break;
                                }
                                l ++;
                            }
                            break;
                        }
                        k ++;
                    }
                    break;
                }
                j ++;
            }
            break;
        }
        i ++;
    }
    if (_provinceSelectIndex == -1) {
        _provinceSelectIndex = 0;
    }
    if (_citySelectIndex == -1) {
        _citySelectIndex = 0;
    }
    if (_districtSelectIndex == -1) {
        _districtSelectIndex = 0;
    }
    if (_streetSelectIndex == -1) {
        _streetSelectIndex = 0;
    }
}

- (id)init{
    self = [super initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    if (self) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT + 44, IPHONE_WIDTH, 216)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        _handleView = [[UIView alloc] initWithFrame:CGRectMake(0, IPHONE_HEIGHT , IPHONE_WIDTH, 44)];
        _handleView.backgroundColor = UIColorFromRGB(244, 244, 244);
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setFrame:CGRectMake(0, 0, 60, 44)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColorFromHexadecimalRGB(0x333333) forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
        [_cancelBtn setTitleColor:UIColorFromHexadecimalRGB(0x333333) forState:UIControlStateHighlighted];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_handleView addSubview:_cancelBtn];
        
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setFrame:CGRectMake(IPHONE_WIDTH - 60,0, 60, 44)];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:UIColorFromHexadecimalRGB(0xf03468) forState:UIControlStateNormal];
        [_doneBtn setTitle:@"确定" forState:UIControlStateHighlighted];
        [_doneBtn setTitleColor:UIColorFromHexadecimalRGB(0x333333) forState:UIControlStateHighlighted];
        [_doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [_handleView addSubview:_doneBtn];
        
        [self addSubview:_handleView];
        [self addSubview:_pickerView];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return self;
}

-(void)showWithDone:(PickerAction)block{
    if (block) {
        self.block = block;
    }
    [KEYWindow addSubview:self];
    __weak BBGPickerView * weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.handleView setFrame:CGRectMake(0, IPHONE_HEIGHT - 260, IPHONE_WIDTH, 44)];
        [weakSelf.pickerView setFrame:CGRectMake(0, IPHONE_HEIGHT - 216, IPHONE_WIDTH, 216)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)cancelAction:(id)sender{
    [self dismiss];
}

- (void)doneAction:(id)sender{
    if (self.block) {
        self.block(@"湖南_长沙市_岳麓区_麓谷街道:43_430100000000_430104000000_430104030000");
    }
    [self dismiss];
}

- (void)dismiss{
    __weak BBGPickerView * weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.handleView setFrame:CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, 44)];
        [weakSelf.pickerView setFrame:CGRectMake(0, IPHONE_HEIGHT + 44, IPHONE_WIDTH, 216)];
    } completion:^(BOOL finished) {
        
        weakSelf.block = nil;
        [weakSelf removeFromSuperview];
        
    }];
}

- (void)dealloc{
    self.doneBtn = nil;
    self.cancelBtn = nil;
    self.pickerView = nil;
    self.handleView = nil;
    
}

#pragma mark -- UIPickerViewDataSource,UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    int count = 4;
    return count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return [self.regionList count];
        }
            break;
        case 1:
        {
            NSInteger index = [pickerView selectedRowInComponent:0];
            if (index < [self.regionList count]) {
                BBGRegion *provice = [self.regionList objectAtIndex:index];
                return [provice.regionChildren count];
            }
            return 0;
        }
            break;
        case 2:
        {
            
            NSInteger fIndex = [pickerView selectedRowInComponent:0];
            NSInteger sIndex = [pickerView selectedRowInComponent:1];
            if (fIndex < [self.regionList count]) {
                BBGRegion *provice = [self.regionList objectAtIndex:fIndex];
                NSArray *cities = provice.regionChildren;
                if (sIndex < [cities count]) {
                    BBGRegion *cityRegion = [cities objectAtIndex:sIndex];
                    return [cityRegion.regionChildren count];
                }
            }
            return 0;
        }
            break;
        default:
        {
            
            NSInteger fIndex = [pickerView selectedRowInComponent:0];
            NSInteger sIndex = [pickerView selectedRowInComponent:1];
            NSInteger tIndex = [pickerView selectedRowInComponent:2];
            if (fIndex < [self.regionList count]) {
                BBGRegion *provice = [self.regionList objectAtIndex:fIndex];
                NSArray *cities = provice.regionChildren;
                if (sIndex < [cities count]) {
                    BBGRegion *cityRegion = [cities objectAtIndex:sIndex];
                    NSArray *districts = cityRegion.regionChildren;
                    if (tIndex < [districts count]) {
                        BBGRegion *districtRegion = [cityRegion.regionChildren objectAtIndex:tIndex];
                        return [districtRegion.regionChildren count];
                    }
                }
            }
            return 0;
        }
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width / 4, 44)];
    rowView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, pickerView.frame.size.width / 4 - 20, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = APP_FONT(13);
    label.textColor = [UIColor darkGrayColor];
    switch (component) {
        case 0:
        {
            if (row < [self.regionList count]) {
                BBGRegion *provice = [self.regionList objectAtIndex:row];
                label.text = provice.name;
            }
        }
            break;
        case 1:
        {
            
            NSInteger index = [pickerView selectedRowInComponent:0];
            if (index < [self.regionList count]) {
                BBGRegion *provice = [self.regionList objectAtIndex:index];
                if (row < [provice.regionChildren count]) {
                    BBGRegion *cityRegion = [provice.regionChildren objectAtIndex:row];
                    label.text = cityRegion.name;
                }
            }
            
        }
            break;
        case 2:
        {
            
            NSInteger fIndex = [pickerView selectedRowInComponent:0];
            NSInteger sIndex = [pickerView selectedRowInComponent:1];
            if (fIndex < [self.regionList count]) {
                BBGRegion *provice = [self.regionList objectAtIndex:fIndex];
                NSArray *cities = provice.regionChildren;
                if (sIndex < [cities count]) {
                    BBGRegion *cityRegion = [provice.regionChildren objectAtIndex:sIndex];
                    if (row < [cityRegion.regionChildren count]) {
                        BBGRegion *districtRegion = [cityRegion.regionChildren objectAtIndex:row];
                        label.text = districtRegion.name;
                    }
                }
            }
            
            
        }
            break;
        default:
        {
            NSInteger fIndex = [pickerView selectedRowInComponent:0];
            NSInteger sIndex = [pickerView selectedRowInComponent:1];
            NSInteger tIndex = [pickerView selectedRowInComponent:2];
            if (fIndex < [self.regionList count]) {
                BBGRegion *provice = [self.regionList objectAtIndex:fIndex];
                if ([provice.regionChildren count]>sIndex) {
                    BBGRegion *cityRegion = [provice.regionChildren objectAtIndex:sIndex];
                    if ([cityRegion.regionChildren count] >tIndex) {
                        BBGRegion *districtRegion = [cityRegion.regionChildren objectAtIndex:tIndex];
                        if ([districtRegion.regionChildren count] >row) {
                            BBGRegion *streetRegion = [districtRegion.regionChildren objectAtIndex:row];
                            label.text = streetRegion.name;
                        }
                    }
                }
            }
            
        }
            break;
    }
    [rowView addSubview:label];
    return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 1:
        {
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
        {
            
        }
            break;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
