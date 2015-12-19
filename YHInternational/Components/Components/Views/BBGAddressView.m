//
//  BBGAddressView.m
//  BubuGao
//
//  Created by calvin on 14-5-15.
//  Copyright (c) 2014年 bubugao. All rights reserved.
//

#import "BBGAddressView.h"

@interface BBGAddressView () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *addressPickerView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, copy) AddressViewCallBack callback;
@property (nonatomic, assign) NSInteger provinceSelectIndex;
@property (nonatomic, assign) NSInteger citySelectIndex;
@property (nonatomic, assign) NSInteger districtSelectIndex;
@property (nonatomic, assign) NSInteger streetSelectIndex;
@property (nonatomic, strong) NSArray *regionList;
@end

@implementation BBGAddressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithRegions:(NSMutableArray *)regionList {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        
        
        
        self.regionList = regionList;
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _provinceSelectIndex = -1;
        _citySelectIndex = -1;
        _districtSelectIndex = -1;
        _streetSelectIndex = -1;
        _addressPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 216)];
        _addressPickerView.showsSelectionIndicator = YES;
        _addressPickerView.dataSource = self;
        _addressPickerView.delegate = self;
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _addressPickerView.frame.size.height + 36)];
        _mainView.backgroundColor = [UIColor whiteColor];
        UIImageView *bar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _mainView.frame.size.width, 44)];
        bar.backgroundColor = UIColorFromRGB(244, 244, 244);
        [_mainView addSubview:bar];
        
        
        CGFloat buttonWith = 94.0;
        CGFloat buttonHeight = 40.0;
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [cancelButton addTarget:self action:@selector(actionOfCancel:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = APP_FONT(15);
        cancelButton.tag = 120;
        buttonWith -= 52;
        cancelButton.frame = CGRectMake(10, (bar.frame.size.height - buttonHeight) / 2, buttonWith, buttonHeight);
        [cancelButton setTitleColor:UICOLOR_FONT_IMPORTANT_BLACK forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_mainView addSubview:cancelButton];
        
        UIButton *makesureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        makesureButton.frame = CGRectMake(bar.frame.size.width - 10 - buttonWith, (bar.frame.size.height - buttonHeight ) / 2, buttonWith, buttonHeight);
        [makesureButton addTarget:self action:@selector(actionOfMakesure:) forControlEvents:UIControlEventTouchUpInside];
        [makesureButton setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
        makesureButton.titleLabel.font = APP_FONT(15);
        [makesureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_mainView addSubview:makesureButton];
        
        CGRect frame = _addressPickerView.frame;
        frame.origin.x = 0;
        frame.origin.y = _mainView.frame.size.height - frame.size.height;
        _addressPickerView.frame = frame;
        [_mainView addSubview:_addressPickerView];
        [self addSubview:_mainView];
    }
    return self;
}
- (CGFloat)height {
    return _mainView.frame.size.height;
}

- (IBAction)actionOfCancel:(id)sender {
    [self dismiss];
}

- (IBAction)actionOfMakesure:(id)sender {
    NSInteger fIndex = [_addressPickerView selectedRowInComponent:0];
    NSInteger sIndex = [_addressPickerView selectedRowInComponent:1];
    NSInteger tIndex = [_addressPickerView selectedRowInComponent:2];
    NSInteger foIndex = 0;
    if (!self.isShowDistrict) {
        foIndex = [_addressPickerView selectedRowInComponent:3];
    }
    NSString *pID = nil;
    NSString *cID = nil;
    NSString *dID = nil;
    NSString *sID = nil;
    NSString *province = nil;
    NSString *city = nil;
    NSString *district = nil;
    NSString *street = nil;
    
    if ([self.regionList count]>0) {
        BBGRegion *provinceRegion = [self.regionList objectAtIndex:fIndex];
        province = provinceRegion.name;
        pID = provinceRegion.regionId;
        NSArray *cities = provinceRegion.regionChildren;
        if (sIndex < [cities count]) {
            BBGRegion *cityRegion = [cities objectAtIndex:sIndex];
            city = cityRegion.name;
            cID = cityRegion.regionId;
            NSArray *districts = cityRegion.regionChildren;
            if (tIndex < [districts count]) {
                BBGRegion *districtsRegion = [districts objectAtIndex:tIndex];
                district = districtsRegion.name;
                dID = districtsRegion.regionId;
                NSArray *streets = districtsRegion.regionChildren;
                if (self.isShowDistrict) {
                    self.selfStoreList = streets;
                }
                if (foIndex < [streets count]) {
                    BBGRegion *streetsRegion = [streets objectAtIndex:foIndex];
                    street = streetsRegion.name;
                    sID = streetsRegion.regionId;
                }
            }
        }
        
    }
    
    self.callback(YES,province,city,district,street,pID,cID,dID,sID);
    __block CGRect frame = _mainView.frame;
    __weak BBGAddressView * weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        frame.origin.y += frame.size.height;
        _mainView.frame = frame;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)show:(AddressViewCallBack)callback {
    WS(weakSelf)
    [[BBGLoadingTips sharedInstance]showLoading:nil];
    if(![BBGRegionManager sharedInstance].regionList){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //获取数据
            NSMutableArray * addressArray = [BBGRegionCache queryData];
            
            [BBGRegionManager sharedInstance].regionList = addressArray;
            
            weakSelf.regionList = [BBGRegionManager sharedInstance].regionList;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [BBGRegionManager sharedInstance].regionList = nil;
                //刷新UI
                [[BBGLoadingTips sharedInstance] hideTips];
                weakSelf.callback = callback;
                __block CGRect frame = _mainView.frame;
                frame.origin.y = weakSelf.frame.size.height;
                _mainView.frame = frame;
                [[UIApplication sharedApplication].keyWindow addSubview:weakSelf];
                [UIView animateWithDuration:0.25 animations:^{
                    frame.origin.y -= frame.size.height;
                    _mainView.frame = frame;
                } completion:^(BOOL finished) {
                    
                }];
            });
        });
    }else{
        self.regionList = [BBGRegionManager sharedInstance].regionList;
        [[BBGLoadingTips sharedInstance] hideTips];
        self.callback = callback;
        __block CGRect frame = _mainView.frame;
        frame.origin.y = self.frame.size.height;
        _mainView.frame = frame;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.25 animations:^{
            frame.origin.y -= frame.size.height;
            _mainView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}


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

- (void)showWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district street:(NSString *)street callback:(AddressViewCallBack)callback {
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    WS(weakSelf)
    if (![BBGRegionManager sharedInstance].regionList) {
        //获取数据
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSMutableArray * addressArray = [BBGRegionCache queryData];
            
            [BBGRegionManager sharedInstance].regionList = addressArray;
            
            weakSelf.regionList = [BBGRegionManager sharedInstance].regionList;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [BBGRegionManager sharedInstance].regionList = nil;
                //刷新UI
                [[BBGLoadingTips sharedInstance]hideTips];
                
                [weakSelf calculateSelectIndexWithProvince:province city:city district:district street:street];
                //[_addressPickerView reloadAllComponents];
                [_addressPickerView reloadComponent:0];
                [_addressPickerView selectRow:_provinceSelectIndex inComponent:0 animated:NO];
                [_addressPickerView reloadComponent:1];
                [_addressPickerView selectRow:_citySelectIndex inComponent:1 animated:NO];
                [_addressPickerView reloadComponent:2];
                [_addressPickerView selectRow:_districtSelectIndex inComponent:2 animated:NO];
                if (!weakSelf.isShowDistrict) {
                    [_addressPickerView reloadComponent:3];
                    [_addressPickerView selectRow:_streetSelectIndex inComponent:3 animated:NO];
                    
                }
                weakSelf.callback = callback;
                __block CGRect frame = _mainView.frame;
                frame.origin.y = weakSelf.frame.size.height;
                _mainView.frame = frame;
                [[UIApplication sharedApplication].keyWindow addSubview:self];
                [UIView animateWithDuration:0.25 animations:^{
                    frame.origin.y -= frame.size.height;
                    _mainView.frame = frame;
                } completion:^(BOOL finished) {
                    
                }];
            });
            
            
        });
    }else{
        weakSelf.regionList = [BBGRegionManager sharedInstance].regionList;
        [[BBGLoadingTips sharedInstance]hideTips];
        
        [self calculateSelectIndexWithProvince:province city:city district:district street:street];
        //[_addressPickerView reloadAllComponents];
        [_addressPickerView reloadComponent:0];
        [_addressPickerView selectRow:_provinceSelectIndex inComponent:0 animated:NO];
        [_addressPickerView reloadComponent:1];
        [_addressPickerView selectRow:_citySelectIndex inComponent:1 animated:NO];
        [_addressPickerView reloadComponent:2];
        [_addressPickerView selectRow:_districtSelectIndex inComponent:2 animated:NO];
        if (!self.isShowDistrict) {
            [_addressPickerView reloadComponent:3];
            [_addressPickerView selectRow:_streetSelectIndex inComponent:3 animated:NO];
            
        }
        self.callback = callback;
        __block CGRect frame = _mainView.frame;
        frame.origin.y = weakSelf.frame.size.height;
        _mainView.frame = frame;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.25 animations:^{
            frame.origin.y -= frame.size.height;
            _mainView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

- (void)dismiss {
    self.callback(NO,nil,nil,nil,nil,nil,nil,nil,nil);
    __block CGRect frame = _mainView.frame;
    __weak BBGAddressView * weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        frame.origin.y += frame.size.height;
        _mainView.frame = frame;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource and UIPickerViewDelegate methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    int count = 4;
    if (self.isShowDistrict) {
        count = 3;
    }
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
            if (!self.isShowDistrict) {
                [pickerView reloadComponent:3];
                [pickerView selectRow:0 inComponent:3 animated:YES];
            }
            
        }
            break;
        case 1:
        {
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            if (!self.isShowDistrict) {
                [pickerView reloadComponent:3];
                [pickerView selectRow:0 inComponent:3 animated:YES];
            }
            
        }
            break;
        case 2:
        {
            if (!self.isShowDistrict) {
                [pickerView reloadComponent:3];
                [pickerView selectRow:0 inComponent:3 animated:YES];
            }
            
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
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
