//
//  RateChartView.m
//  TestChart
//
//  Created by 单小萍 on 15/12/4.
//  Copyright © 2015年 单小萍. All rights reserved.
//
#define kColorWithRGB(r, g, b,a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:(a)]
#define defaultColor kColorWithRGB(74,202,226,1);
#define fillPathColor kColorWithRGB(219,245,250,1);
#define lineDrawColor kColorWithRGB(229,229,229,1);
#import "RateChartView.h"
@implementation RateChartView
@synthesize lineColor = _lineColor;
@synthesize fontColor = _fontColor;
@synthesize chartColor = _chartColor;
@synthesize fillColor = _fillColor;
@synthesize textFont = _textFont;
@synthesize markFont = _markFont;
@synthesize deleget = _deleget;
@synthesize isShowMaxValue = _isShowMaxValue;
@synthesize isCurrentMark = _isCurrentMark;
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initDefault];
    }
    return self;
}
/*
 *初始化默认值
 */
-(void)initDefault{
    self.lineColor = lineDrawColor;
    self.fontColor = defaultColor;
    self.chartColor  = defaultColor;
    self.fillColor = fillPathColor;
    self.isShowMaxValue = YES;
    self.isCurrentMark = YES;
    self.markFont = [UIFont systemFontOfSize:10.f];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    if (!_deleget) {
        return;
    }
    if([_deleget rateChartXArray]) {
        CGSize xSize = [self boundingRectWithSize:[_deleget rateChartXArray][0] font:_markFont size:CGSizeMake(rect.size.width,rect.size.height)];
        CGSize ySize = [self boundingRectWithSize:[_deleget rateChartYArray][0] font:_markFont size:CGSizeMake(rect.size.width,rect.size.height)];
        CGRect chartRect = CGRectMake(ySize.width+5.f,0.f,rect.size.width-2*ySize.width-10.f,rect.size.height-xSize.height-5.f);
        [self drawXArray:rect chartRect:chartRect];
        [self drawChart:chartRect];
    }else{
        [self drawChart:rect];
    }
}
/*
 *画框
 */
-(void)drawXArray:(CGRect)originRect chartRect:(CGRect)chartRect{
    CGFloat itemWidth = chartRect.size.width/([_deleget rateChartXArray].count-1);
    for (int i = 0; i < [_deleget rateChartXArray].count;i++){
        UIBezierPath* linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(i*itemWidth+chartRect.origin.x, chartRect.origin.y)];
        [linePath addLineToPoint:CGPointMake(i*itemWidth+chartRect.origin.x, chartRect.origin.y+chartRect.size.height)];
        [linePath setLineWidth:0.5f];
        [_lineColor setStroke];
        [linePath stroke];
        //画x值
        if (i >= [_deleget rateChartXArray].count) {
            continue;
        }
        NSString* xString = [_deleget rateChartXArray][i];
        NSDictionary *textAttrsDictionary =
        [NSDictionary dictionaryWithObjectsAndKeys:
         _markFont,NSFontAttributeName,_lineColor,NSForegroundColorAttributeName,nil];
        CGSize xSize = [self boundingRectWithSize:xString font:_markFont size:CGSizeMake(chartRect.size.width,chartRect.size.height)];
        [xString drawAtPoint:CGPointMake(i*itemWidth+chartRect.origin.x-xSize.width/2,originRect.size.height-xSize.height-2.5f) withAttributes:textAttrsDictionary];
		
		if (i %2 != 0 ) {
			//画填充色
			UIBezierPath* fillPath = [UIBezierPath bezierPath];
			[fillPath moveToPoint:CGPointMake(i*itemWidth+chartRect.origin.x,0)];
			[fillPath addLineToPoint:CGPointMake(i*itemWidth+chartRect.origin.x, chartRect.size.height)];
			[fillPath addLineToPoint:CGPointMake(i*itemWidth+chartRect.origin.x+itemWidth, chartRect.size.height)];
			[fillPath addLineToPoint:CGPointMake(i*itemWidth+chartRect.origin.x+itemWidth, 0)];
			[fillPath addLineToPoint:CGPointMake(i*itemWidth+chartRect.origin.x, 0)];
			
			[kColorWithRGB(252,252,252,1) setFill];
			[fillPath fill];
			
		}
    }
    NSInteger yCount = [_deleget rateChartXArray].count/2;
    int addNumber = [_deleget rateChartXArray].count%2==0?0:1;
    yCount+=addNumber;
    
    CGFloat itemHeight = chartRect.size.height/yCount;
    for (int i = 0;i <= yCount+1;i++){
        UIBezierPath* yLinePath = [UIBezierPath bezierPath];
        if (i == 0) {
            [yLinePath moveToPoint:CGPointMake(0.f,chartRect.origin.y)];
            [yLinePath addLineToPoint:CGPointMake(originRect.size.width, chartRect.origin.y)];
        }else if (i == yCount+1){
            [yLinePath moveToPoint:CGPointMake(0.f,chartRect.origin.y+chartRect.size.height)];
            [yLinePath addLineToPoint:CGPointMake(originRect.size.width, chartRect.origin.y+chartRect.size.height)];
        }else{
            CGFloat pointHeight = itemHeight/2+(i-1)*itemHeight;
            [yLinePath moveToPoint:CGPointMake(chartRect.origin.x,chartRect.origin.y+pointHeight)];
            [yLinePath addLineToPoint:CGPointMake(originRect.size.width,chartRect.origin.y+pointHeight)];
            //画y值
            CGFloat yValue = (chartRect.size.height-pointHeight)/chartRect.size.height*[_deleget maxValue];

            NSString* yValueStr = [NSString stringWithFormat:@"%.3f",yValue];

            NSDictionary *textAttrsDictionary =
            [NSDictionary dictionaryWithObjectsAndKeys:
             _markFont,NSFontAttributeName,_lineColor,NSForegroundColorAttributeName,nil];
            CGSize ySize = [self boundingRectWithSize:yValueStr font:_markFont size:CGSizeMake(originRect.size.width,originRect.size.height)];
            [yValueStr drawAtPoint:CGPointMake(0.5f,chartRect.origin.y+pointHeight-ySize.height/2) withAttributes:textAttrsDictionary];
        }
        [yLinePath setLineWidth:0.5f];
        [_lineColor setStroke];
        [yLinePath stroke];
    }
}
/*
 *绘制曲线
 */
-(void)drawChart:(CGRect)rect{
    //画曲线
    NSArray* drawArray = [self calculateDrawPoint:rect];
	
    UIBezierPath* chartPath = [UIBezierPath bezierPath];
    for (int i = 0; i < drawArray.count; i++) {
        NSValue* drawValue = drawArray[i];
        CGPoint drawPoint = [drawValue CGPointValue];
        if(i == 0){
            [chartPath moveToPoint:drawPoint];
        }else{
            [chartPath addLineToPoint:drawPoint];
        }
    }
	[_chartColor setStroke];
	[chartPath setLineWidth:2.f];
	[chartPath stroke];
	
	//做虚拟折线

	UIBezierPath* chartPath2 = [UIBezierPath bezierPath];
	for (int i = 0; i < drawArray.count; i++) {
		NSValue* drawValue = drawArray[i];
		CGPoint drawPoint = [drawValue CGPointValue];
		if(i == 0){
			[chartPath2 moveToPoint:CGPointMake(drawPoint.x, drawPoint.y+2)];
		}else{
			[chartPath2 addLineToPoint:CGPointMake(drawPoint.x, drawPoint.y+2)];
		}
	}
	[kColorWithRGB(219,245,250,0.8) setStroke];
	[chartPath2 setLineWidth:3.f];
	[chartPath2 stroke];
	
	
    //画填充色
    UIBezierPath* fillPath = [UIBezierPath bezierPath];
	

	//绘制渐变颜色
	NSValue* firstValue = [drawArray firstObject];
	[fillPath moveToPoint:CGPointMake([firstValue CGPointValue].x,rect.size.height+rect.origin.y+3)];
	for (int i = 0; i < drawArray.count; i++){
		NSValue* drawValue = drawArray[i];
		CGPoint drawPoint = [drawValue CGPointValue];
		[fillPath addLineToPoint:CGPointMake(drawPoint.x, drawPoint.y+3)];
	}
	NSValue* lastValue = [drawArray lastObject];
	[fillPath addLineToPoint:CGPointMake([lastValue CGPointValue].x,rect.size.height+rect.origin.y+3)];

//	[fillPath moveToPoint:CGPointMake([firstValue CGPointValue].x,rect.size.height+rect.origin.y+1.5)];
//	for (int i = 0; i < drawArray.count; i++){
//		NSValue* drawValue = drawArray[i];
//		CGPoint drawPoint = [drawValue CGPointValue];
//		[fillPath addLineToPoint:CGPointMake(drawPoint.x, drawPoint.y+1.5)];
//	}
//	NSValue* lastValue = [drawArray lastObject];
//	[fillPath addLineToPoint:CGPointMake([lastValue CGPointValue].x,rect.size.height+rect.origin.y+1.5)];

	
	if([_deleget rateChartXArray]) {
		
//		[kColorWithRGB(219,245,250,0.3) setFill];
//		[fillPath fill];
		// Create a gradient from white to red
		
		
		CAGradientLayer *gradientLayer = [CAGradientLayer layer];
		gradientLayer.frame = self.bounds;
		gradientLayer.colors = @[(__bridge id)_fillColor.CGColor ,
								 (__bridge id)kColorWithRGB(219,245,250,0.1).CGColor];
//		gradientLayer.locations=@[@0.2,@0.2,@0.2];
//		gradientLayer.startPoint = CGPointMake(0.5,0.5);
//		gradientLayer.endPoint = CGPointMake(0.5,1);
		[self.layer insertSublayer:gradientLayer atIndex:0];
		
		CAShapeLayer *arc = [CAShapeLayer layer];
		arc.path = fillPath.CGPath;
		gradientLayer.mask = arc;
		
	}else{
		[_fillColor setFill];
		[fillPath fill];
	}
	
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.frame = self.bounds;
	CAShapeLayer *arc = [CAShapeLayer layer];
	arc.path = chartPath.CGPath;
	gradientLayer.mask = arc;
	
    //画最大值
    //画最大值
    if (_isShowMaxValue||_isCurrentMark) {
        [self drawMaxValue:rect points:drawArray];
    }

}
//绘制最大值
-(void)drawMaxValue:(CGRect)rect points:(NSArray*)points{
    NSArray* maxArray = [self getMaxValue];
    NSInteger maxIndex = [maxArray[0]integerValue];
    CGPoint maxPoint = [points[maxIndex]CGPointValue];
    NSString* maxValue = maxArray[1];
	//画圆圈
    UIBezierPath* arcPath =  [UIBezierPath bezierPathWithArcCenter:maxPoint radius:2.5f startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self.backgroundColor setFill];
    [arcPath fill];
    [_chartColor setStroke];
    [arcPath setLineWidth:1.5f];
    [arcPath stroke];

	
	//画圆圈
	if (arcView) {
		[arcView removeFromSuperview];
		arcView = nil;
	}
	arcView = [[UIView alloc] initWithFrame:CGRectMake(maxPoint.x, maxPoint.y, 8, 8)];
	arcView.layer.borderWidth = 2;
	arcView.layer.cornerRadius = arcView.frame.size.width/2;
	arcView.layer.borderColor = _chartColor.CGColor;
	arcView.backgroundColor = [UIColor whiteColor];
	arcView.center = maxPoint;
	[self addSubview:arcView];

//
//    UIBezierPath* arcPath =  [UIBezierPath bezierPathWithArcCenter:maxPoint radius:2.5f startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [self.backgroundColor setFill];
//    [arcPath fill];
//    [_chartColor setStroke];
//    [arcPath setLineWidth:1.5f];
//    [arcPath stroke];

    //画最大值
	
	if ([_deleget rateChartXArray]) {
		_textFont = [UIFont systemFontOfSize:12];
	}else{
		_textFont = [UIFont systemFontOfSize:10];
	}
	
    CGSize textSize = [self boundingRectWithSize:maxValue font:_textFont size:CGSizeMake(rect.size.width,rect.size.height)];
    CGFloat drawTextX = maxPoint.x-textSize.width-2.5f;
    if ([_deleget rateChartXArray]){
        drawTextX = maxPoint.x-textSize.width/2;
    }
    if (drawTextX <= 0) {
		drawTextX = maxPoint.x+2.5f;
	}
    CGFloat drawTextY = maxPoint.y-textSize.height-2.5f;
	if(drawTextY <= 0) {
        drawTextY = 2.5f;
    }
    CGPoint drawTextPoint = CGPointMake(drawTextX,drawTextY);
	
	if (maxLabel) {
		[maxLabel removeFromSuperview];
		maxLabel = nil;
	}
	maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(drawTextPoint.x-2.5, drawTextPoint.y-2, textSize.width, textSize.height)];
	if ([_deleget rateChartXArray]) {
		maxLabel.textColor = [UIColor whiteColor];
		
		
		maxLabel.frame = CGRectMake (drawTextPoint.x-3, drawTextPoint.y-0.5-3, textSize.width+6, textSize.height+1);
		UIView* backgroudView = [[UIView alloc] initWithFrame:maxLabel.frame];
		backgroudView.layer.cornerRadius = 1;
		backgroudView.clipsToBounds = YES;
		backgroudView.backgroundColor = _chartColor;
		[self addSubview:backgroudView];
	}else{
		
		maxLabel.textColor = _chartColor;
	}
	maxLabel.backgroundColor = [UIColor clearColor];
	maxLabel.font = _textFont;
	maxLabel.textAlignment = NSTextAlignmentCenter;
	maxLabel.text = maxValue;
	[self addSubview:maxLabel];
	
//    NSDictionary *textAttrsDictionary =
//    [NSDictionary dictionaryWithObjectsAndKeys:
//     _textFont,NSFontAttributeName,_chartColor,NSForegroundColorAttributeName,nil];
//    
//    [maxValue drawAtPoint:drawTextPoint withAttributes:textAttrsDictionary];
}

/*
 *计算文字高度和宽度
 */
- (CGSize)boundingRectWithSize:(NSString*)text font:(UIFont*)font size:(CGSize)maxSize{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize retSize = [text boundingRectWithSize:maxSize
                                             options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize;
}
/*
 *计算绘制的点
 */
-(NSArray*)calculateDrawPoint:(CGRect)rect{
    NSMutableArray* drawArray = [[NSMutableArray alloc]init];
    CGFloat itemWidth = rect.size.width/([_deleget rateChartYArray].count-1);
    for (int i = 0;i < [_deleget rateChartYArray].count;i++) {
        CGFloat drawX = i*itemWidth;
        if (i == [_deleget rateChartYArray].count-1&&[self isMaxValue:i]&&(_isShowMaxValue||_isCurrentMark)&&![_deleget rateChartXArray]) {
            drawX -= 4.f;
        }
        drawX+=rect.origin.x;
        
        CGFloat drawY = rect.size.height - [[_deleget rateChartYArray][i]floatValue]/[_deleget maxValue]*rect.size.height;
        drawY+=rect.origin.y;
        CGPoint drawPoint = CGPointMake(drawX,drawY);
        [drawArray addObject:[NSValue valueWithCGPoint:drawPoint]];
    }
    return drawArray;
    
}
/*
 *是否是最大值
 */
-(BOOL)isMaxValue:(NSInteger)index{
    if (_isCurrentMark) {
        if (index == [_deleget rateChartYArray].count-1) {
            return YES;
        }
        return NO;
    }
    if([[self getMaxValue][0]integerValue] == index){
        return YES;
    }
    return NO;
}

/*
 *获取最大值
 */
-(NSArray*)getMaxValue{
    CGFloat maxValue = 0.f;
    NSInteger maxIndex = 0;
    NSArray* valueStrArray = [_deleget rateChartYArray];
    if (_isCurrentMark) {
        maxValue = [valueStrArray[valueStrArray.count-1]floatValue];
        maxIndex = valueStrArray.count-1;
    }else{
        for (int i = 0;i < valueStrArray.count;i++) {
            CGFloat value = [valueStrArray[i]floatValue];
            if (value > maxValue) {
                maxValue = value;
                maxIndex = i;
            }
        }
    }
    NSArray* maxArray = [[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithInteger:maxIndex],[NSString stringWithFormat:@"%.4f",maxValue],nil];
    return maxArray;
}
-(void)setDeleget:(id<RateChartDeleget>)deleget{
    _deleget = deleget;
    [self setNeedsDisplay];
}
-(void)awakeFromNib{
    [self initDefault];
}
@end
