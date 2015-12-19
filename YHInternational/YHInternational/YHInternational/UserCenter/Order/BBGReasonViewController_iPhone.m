//
//  BBGReasonViewController_iPhone.m
//  BuBuGao
//
//  Created by elvis.peng on 14-8-27.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGReasonViewController_iPhone.h"
#import <Common/Common.h>
@interface BBGReasonViewController_iPhone ()
@property (strong, nonatomic) IBOutlet UIPickerView *reasonPickerView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;
@property (assign, nonatomic) BOOL animating;
@property (assign, nonatomic) NSInteger selectIndex;
@end

@implementation BBGReasonViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)backgroundTapped:(id)sender {
    [self dismiss];
}

- (IBAction)makesureAction:(id)sender {
    if (_selectIndex >=0 && _selectIndex < [self.reasons count]) {
        if (self.reasonCallback) {
            BBGCancellingReason *reason = [self.reasons objectAtIndex:_selectIndex];
            self.reasonCallback(reason.reason);
        }
    }
    [self dismiss];
}

- (void)show {
    if (!_animating) {
        _animating = YES;
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
//        [[[[UIApplication sharedApplication] keyWindow] rootViewController].view addSubview:self.view];
        __block CGRect mFrame = _mainView.frame;
        mFrame.origin.y = self.view.frame.size.height;
        _mainView.frame = mFrame;
        [UIView animateWithDuration:0.25 animations:^{
            if (isIOS7) {
                mFrame.origin.y = self.view.frame.size.height - mFrame.size.height;
            }else{
                mFrame.origin.y = self.view.frame.size.height - mFrame.size.height + 20;
            }
            
            _mainView.frame = mFrame;
        } completion:^(BOOL finished) {
            _animating = NO;
        }];
    }
}

- (void)dismiss {
    if (!_animating) {
        _animating = YES;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect mFrame = _mainView.frame;
            mFrame.origin.y = self.view.frame.size.height;
            if (isIOS7) {
                mFrame.origin.y = self.view.frame.size.height;
            }else{
                mFrame.origin.y = self.view.frame.size.height + 20;
            }
             _mainView.frame = mFrame;
        } completion:^(BOOL finished) {
            _animating = NO;
            [self.view removeFromSuperview];
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selectIndex = 0;
    self.view.frame = [[[UIApplication sharedApplication] keyWindow] rootViewController].view.bounds;
    self.view.backgroundColor = [UIColor clearColor];
    [_cancelButton setTitleColor:UICOLOR_FONT_IMPORTANT_BLACK forState:UIControlStateNormal];
    [_sureButton setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
//    UIImage *cdImage = [UIImage imageNamed:@"白底红框按钮"];
//    [self.cancelButton setBackgroundImage:_ResizeImage(cdImage) forState:UIControlStateNormal];
//    UIImage *sdImage = [UIImage imageNamed:@"红按钮"];
//    [self.sureButton setBackgroundImage:_ResizeImage(sdImage) forState:UIControlStateNormal];
//    [self.cancelButton setTitleColor:UIColorFromRGB(236, 43, 86) forState:UIControlStateNormal];
    [self reloadView];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self  backgroundTapped:nil];
    
}

-(void)reloadView{
    [_reasonPickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource And UIPickerViewDelegate Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.reasons count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 21)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = UIColorFromRGB(133.0, 133.0, 133.0);
    BBGCancellingReason *reason = [self.reasons objectAtIndex:row];
    textLabel.text = reason.reason;
    return textLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectIndex = row;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{

}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
