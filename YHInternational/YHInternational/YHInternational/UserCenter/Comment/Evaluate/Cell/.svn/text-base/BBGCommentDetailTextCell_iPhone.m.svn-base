//
//  DetailTextCell.m
//  BubuGao
//
//  Created by Damon on 14-8-7.
//  Copyright (c) 2014年 bubugao. All rights reserved.
//

#import "BBGCommentDetailTextCell_iPhone.h"
#import <Common/Common.h>
@interface BBGCommentDetailTextCell_iPhone ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *anonymousBtn;
@property (strong, nonatomic) IBOutlet UILabel *commentNum;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *bgView;

@end

@implementation BBGCommentDetailTextCell_iPhone

- (void)awakeFromNib
{
    self.commentNum.text = @"0/500";
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.tintColor = UIColorFromHexadecimalRGB(0xf03468);
    self.bgView.image = _ResizeImage([UIImage imageNamed:@"universal_input_bg"]);
}

- (void)displayTextContent:(NSString *)text isAnonymous:(BOOL)isAnonymous{
    self.textView.text = text;
    
    self.commentNum.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)text.length];
    self.anonymousBtn.selected = isAnonymous;
}

#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    //该判断用于联想输入
    if (textView.text.length > 500)
    {
        textView.text = [textView.text substringToIndex:500];
    }
    
    self.commentNum.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.commentNum.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(changeTable:str:isAnonymous:)]) {
        [self.delegate changeTable:self.tag str:@"" isAnonymous:NO];
    }
    return YES;
}
    
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeTable:str:isAnonymous:)]) {
        [self.delegate changeTable:self.tag str:textView.text isAnonymous:self.anonymousBtn.selected];
    }
    return YES;
}

- (IBAction)anonymousComment:(id)sender {
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeTable:str:isAnonymous:)]) {
        [self.delegate changeTable:self.tag str:self.textView.text isAnonymous:self.anonymousBtn.selected];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
