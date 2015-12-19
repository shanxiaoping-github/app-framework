//
//  UMFeedbackTableViewCellRight.m
//  UMeng Analysis
//
//  Created by liuyu on 9/18/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "UMFeedbackTableViewCellRight.h"
#import "NSString+TitleSize.h"

#define TOP_MARGIN 20.0f

@implementation UMFeedbackTableViewCellRight

@synthesize timestampLabel = _timestampLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0f) {
            self.textLabel.backgroundColor = [UIColor whiteColor];
        }

        self.textLabel.font = APP_FONT(14);
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.textColor = RGB_COLOR(166,8,52);

        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _timestampLabel.textAlignment = NSTextAlignmentCenter;
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = APP_FONT(12);
        _timestampLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        _timestampLabel.frame = CGRectMake(0.0f, 12, self.bounds.size.width, 18);

        [self.contentView addSubview:_timestampLabel];

        CGRect textLabelFrame = self.textLabel.frame;
        textLabelFrame.origin.y = 20;
        textLabelFrame.size.width = self.bounds.size.width - 50;
        self.textLabel.frame = textLabelFrame;

        messageBackgroundView = [UIImageView imageViewWithMyImage:@"setting_feedback_bg1" stretchInset:UIEdgeInsetsMake(16, 12, 8, 8)];
//        messageBackgroundView = [[UIImageView alloc] initWithFrame:self.textLabel.frame];
//        messageBackgroundView.image = [[UIImage imageNamed:@"setting_feedback2_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:16];
        [self.contentView insertSubview:messageBackgroundView belowSubview:self.textLabel];

        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.size.width = 226;
    self.textLabel.frame = textLabelFrame;

    CGSize labelSize = [self.textLabel.text sizeWithStringFont:APP_FONT(14) constrainedToSize:CGSizeMake(226, MAXFLOAT) lineSpacing:8.0];
//    CGSize labelSize = [self.textLabel.text sizeWithStringFont:APP_FONT(14) constrainedToSize:CGSizeMake(226, MAXFLOAT)];

    textLabelFrame.size.height = labelSize.height + 12;
    textLabelFrame.origin.y = 20.0f + TOP_MARGIN;
    textLabelFrame.origin.x = self.bounds.size.width - labelSize.width - 20;
    self.textLabel.frame = textLabelFrame;

    messageBackgroundView.frame = CGRectMake(textLabelFrame.origin.x -10, textLabelFrame.origin.y - 4, labelSize.width + 24, labelSize.height + 21);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor);

    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, 0, 21); //start at this point
    CGContextAddLineToPoint(context, (self.bounds.size.width - 120) / 2, 21); //draw to this point

    CGContextMoveToPoint(context, self.bounds.size.width, 21); //start at this point
    CGContextAddLineToPoint(context, self.bounds.size.width - (self.bounds.size.width - 120) / 2, 21); //draw to this point

    CGContextStrokePath(context);

}

@end
