/**
 * Copyright 2009 Jeff Verkoeyen
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "OverlayView.h"
#import <AVFoundation/AVFoundation.h>

#define TOPHEIGHT    80.0
#define BOTTOMHEIGHT 54.0
#define RECTLENGTH   25.0

#define VIEWFINDERSIZE CGSizeMake(233,233)

//static const CGFloat kPadding = 40;

@interface OverlayView()
@property (nonatomic,assign) UIButton *cancelButton;
@property (nonatomic,retain) UILabel *instructionsLabel;
@property (nonatomic,assign) CGFloat kPadding;
@property (nonatomic,retain) UIImageView *scanner;

@end


@implementation OverlayView

@synthesize delegate, oneDMode;
@synthesize points = _points;
@synthesize cancelButton;
@synthesize cropRect;
@synthesize instructionsLabel;
@synthesize displayedMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled {
  self = [super initWithFrame:theFrame];
  if( self ) {
      self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor clearColor];
      [self initVariables];
    //self.oneDMode = isOneDModeEnabled;
    if (isCancelEnabled) {
      UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom]; 
      self.cancelButton = butt;
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"vss_more_scan_close.png"] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
      if (oneDMode) {
        [cancelButton setTransform:CGAffineTransformMakeRotation(M_PI/2)];
        
        [cancelButton setFrame:CGRectMake(20, 175, 45, 130)];
      }
      else {
          CGSize theSize = CGSizeMake(76, 36);
          CGRect theRect = CGRectMake(/*(theFrame.size.width - theSize.width) / 2*/theFrame.size.width - theSize.width - 10, theFrame.size.height - theSize.height - (BOTTOMHEIGHT - theSize.height) / 2.0, theSize.width, theSize.height);
          [cancelButton setFrame:theRect];
      }
      
      [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:cancelButton];
      [self addSubview:imageView];
        
        UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lightButton setBackgroundImage:[UIImage imageNamed:@"vss_more_scan_openLight.png"] forState:UIControlStateNormal];
        [lightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [lightButton setTitle:@"  打开" forState:UIControlStateNormal];
        [lightButton setTitle:@"  关闭" forState:UIControlStateSelected];
        CGSize buttonSize = CGSizeMake(76, 36);
        [lightButton setFrame:CGRectMake(10.0, theFrame.size.height - buttonSize.height - (BOTTOMHEIGHT - buttonSize.height) / 2.0, buttonSize.width, buttonSize.height)];
        [lightButton addTarget:self action:@selector(openLight:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lightButton];
        /*
        UIView *rollView = [[UIView alloc] initWithFrame:CGRectMake(cropRect.origin.x, cropRect.origin.y - 2.5, cropRect.size.width, 3.0)];
        rollView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.6];
        [self addSubview:rollView];
        [UIView animateWithDuration:4.0 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
            CGRect frame = rollView.frame;
            frame.origin.y += (cropRect.size.height + 2.5);
            rollView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
        [rollView release];
         */
    }
  }
  return self;
}

- (void)initVariables {
    CGFloat rectSize = VIEWFINDERSIZE.width;//self.frame.size.width - kPadding * 2;
    _kPadding = (self.frame.size.width - rectSize) / 2;
    if (!oneDMode) {
        cropRect = CGRectMake(_kPadding, (self.frame.size.height - rectSize) / 4, rectSize, rectSize);
    } else {
        CGFloat rectSize2 = self.frame.size.height - _kPadding * 2;
        cropRect = CGRectMake(_kPadding, _kPadding, rectSize, rectSize2);
    }
    
    if (!_scanner) {
        _scanner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner"]];
    }
    _scanner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    __block CGRect sFrame = _scanner.frame;
    sFrame.origin.x = (self.frame.size.width - sFrame.size.width) / 2;
    sFrame.origin.y = cropRect.origin.y;
    _scanner.frame = sFrame;
    [self addSubview:_scanner];
    [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        sFrame.origin.y += cropRect.size.height - 8.0;
        _scanner.frame = sFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self initVariables];
}

- (void)cancel:(id)sender {
	// call delegate to cancel this scanner
	if (delegate != nil) {
		[delegate cancelled];
	}
}

- (void)openLight:(id)sender
{
    UIButton *button = (UIButton *)sender;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        if (button.selected) 
        {
            if ([device hasTorch]) {  
                [device lockForConfiguration:nil];  
                [device setTorchMode: AVCaptureTorchModeOff];  
                [device unlockForConfiguration];  
            }  
        }
        else 
        {
            if ([device hasTorch]) {  
                [device lockForConfiguration:nil];  
                [device setTorchMode: AVCaptureTorchModeOn];  
                [device unlockForConfiguration];  
            }
        }
        button.selected = !button.selected;
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备没有闪光灯!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	[imageView release];
	[_points release];
  [instructionsLabel release];
  [displayedMessage release];
    [_scanner release];
	[super dealloc];
}


- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context 
{
    CGContextMoveToPoint(context, rect.origin.x + RECTLENGTH, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + RECTLENGTH);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width - RECTLENGTH, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + RECTLENGTH);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - RECTLENGTH);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x + RECTLENGTH, rect.origin.y + rect.size.height);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width - RECTLENGTH, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - RECTLENGTH);
    CGContextStrokePath(context);
}

- (void)drawRingWithCenterSize:(CGSize)size inContext:(CGContextRef)contex{
    CGRect frame = self.frame;
    CGRect centerRect = CGRectMake((frame.size.width - size.width) / 2, (frame.size.height - size.height) / 4, size.width, size.height);
    CGContextFillRect(contex, CGRectMake(0, 0, frame.size.width, centerRect.origin.y));
    CGFloat height = centerRect.origin.y + centerRect.size.height;
    CGContextFillRect(contex, CGRectMake(0, height, frame.size.width, frame.size.height - height));
    CGContextFillRect(contex, CGRectMake(0, centerRect.origin.y, centerRect.origin.x, centerRect.size.height));
    CGFloat width = centerRect.origin.x + centerRect.size.width;
    CGContextFillRect(contex, CGRectMake(width, centerRect.origin.y, frame.size.width - width, centerRect.size.height));
}

- (CGPoint)map:(CGPoint)point {
    CGPoint center;
    center.x = cropRect.size.width/2;
    center.y = cropRect.size.height/2;
    float x = point.x - center.x;
    float y = point.y - center.y;
    int rotation = 90;
    switch(rotation) {
    case 0:
        point.x = x;
        point.y = y;
        break;
    case 90:
        point.x = -y;
        point.y = x;
        break;
    case 180:
        point.x = -x;
        point.y = -y;
        break;
    case 270:
        point.x = y;
        point.y = -x;
        break;
    }
    point.x = point.x + center.x;
    point.y = point.y + center.y;
    return point;
}

#define kTextMargin 10

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
  if (displayedMessage == nil) {
//    self.displayedMessage = @"请将二维码放入下面的取景框范围内进行扫描!";
  }
	CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(c, [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor);
    //绘制环形半透明灰色mask view
    [self drawRingWithCenterSize:VIEWFINDERSIZE inContext:c];
    CGContextSetStrokeColorWithColor(c, [UIColor whiteColor].CGColor);
    CGPoint beginPoint = CGPointMake((self.frame.size.width - VIEWFINDERSIZE.width) / 2, (self.frame.size.height - VIEWFINDERSIZE.height) / 4);
    CGContextAddRect(c, CGRectMake(beginPoint.x, beginPoint.y, VIEWFINDERSIZE.width, VIEWFINDERSIZE.height));
    CGContextStrokePath(c);
    /*
    CGContextFillRect(c, CGRectMake(0, 0, self.frame.size.width, TOPHEIGHT));
    CGContextFillRect(c, CGRectMake(0, cropRect.origin.y + cropRect.size.height + _kPadding, self.frame.size.width, self.frame.size.height - BOTTOMHEIGHT - (cropRect.origin.y + cropRect.size.height - _kPadding)));
    
    CGContextSetFillColorWithColor(c, [UIColor colorWithRed:203.0 / 255.0 green:200.0 / 255.0 blue:202.0 / 255.0 alpha:1.0].CGColor);
    CGContextFillRect(c, CGRectMake(0, self.frame.size.height - BOTTOMHEIGHT, self.frame.size.width, BOTTOMHEIGHT));
  
	if (nil != _points) {
    //		[imageView.image drawAtPoint:cropRect.origin];
	}
     */
	
	//CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
	//CGContextSetStrokeColor(c, white);
	//CGContextSetFillColor(c, white);
    CGContextSetStrokeColorWithColor(c, [[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor);
    CGFloat padding = 4;
    CGContextSetLineWidth(c, 3);
    //绘制直角辅线
	[self drawRect:CGRectMake(cropRect.origin.x - padding, cropRect.origin.y - padding, cropRect.size.width + 2 * padding, cropRect.size.height + 2 * padding) inContext:c];
	
  //	CGContextSetStrokeColor(c, white);
	//	CGContextSetStrokeColor(c, white);
	CGContextSaveGState(c);
//	if (oneDMode) {
//		char *text = "Place a red line over the bar code to be scanned.";
//		CGContextSelectFont(c, "Helvetica", 15, kCGEncodingMacRoman);
//		CGContextScaleCTM(c, -1.0, 1.0);
//		CGContextRotateCTM(c, M_PI/2);
//		CGContextShowTextAtPoint(c, 74.0, 285.0, text, 49);
//	}
//	else {
//    UIFont *font = [UIFont systemFontOfSize:18];
//    CGSize constraint = CGSizeMake(rect.size.width  - 2 * kTextMargin, cropRect.origin.y);
//    CGSize displaySize = [self.displayedMessage sizeWithFont:font constrainedToSize:constraint];
//    CGRect displayRect = CGRectMake((rect.size.width - displaySize.width) / 2 , (80 - displaySize.height) / 2, displaySize.width, displaySize.height);
//    [self.displayedMessage drawInRect:displayRect withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
//	}
	CGContextRestoreGState(c);
	int offset = rect.size.width / 2;
	if (oneDMode) {
		CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, red);
		CGContextSetFillColor(c, red);
		CGContextBeginPath(c);
		//		CGContextMoveToPoint(c, rect.origin.x + kPadding, rect.origin.y + offset);
		//		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - kPadding, rect.origin.y + offset);
		CGContextMoveToPoint(c, rect.origin.x + offset, rect.origin.y + _kPadding);
		CGContextAddLineToPoint(c, rect.origin.x + offset, rect.origin.y + rect.size.height - _kPadding);
		CGContextStrokePath(c);
	}
	if( nil != _points ) {
		CGFloat blue[4] = {0.0f, 1.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, blue);
		CGContextSetFillColor(c, blue);
		if (oneDMode) {
			CGPoint val1 = [self map:[[_points objectAtIndex:0] CGPointValue]];
			CGPoint val2 = [self map:[[_points objectAtIndex:1] CGPointValue]];
			CGContextMoveToPoint(c, offset, val1.x);
			CGContextAddLineToPoint(c, offset, val2.x);
			CGContextStrokePath(c);
		}
		else {
			CGRect smallSquare = CGRectMake(0, 0, 10, 10);
			for( NSValue* value in _points ) {
				CGPoint point = [self map:[value CGPointValue]];
				smallSquare.origin = CGPointMake(
                                         cropRect.origin.x + point.x - smallSquare.size.width / 2,
                                         cropRect.origin.y + point.y - smallSquare.size.height / 2);
				[self drawRect:smallSquare inContext:c];
			}
		}
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 - (void) setImage:(UIImage*)image {
 //if( nil == imageView ) {
// imageView = [[UIImageView alloc] initWithImage:image];
// imageView.alpha = 0.5;
// } else {
 imageView.image = image;
 //}
 
 //CGRect frame = imageView.frame;
 //frame.origin.x = self.cropRect.origin.x;
 //frame.origin.y = self.cropRect.origin.y;
 //imageView.frame = CGRectMake(0,0, 30, 50);
 
 //[_points release];
 //_points = nil;
 //self.backgroundColor = [UIColor clearColor];
 
 //[self setNeedsDisplay];
 }
 */

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*) image {
	return imageView.image;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setPoints:(NSMutableArray*)pnts {
    [pnts retain];
    [_points release];
    _points = pnts;
	
    if (pnts != nil) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    }
    [self setNeedsDisplay];
}

- (void) setPoint:(CGPoint)point {
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
    }
    if (_points.count > 3) {
        [_points removeObjectAtIndex:0];
    }
    [_points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}


@end
