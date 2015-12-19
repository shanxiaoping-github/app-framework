//
//  BBGTools.m
//  Common
//
//  Created by yangjie on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGTools.h"
#import "BBGMacro.h"
#import "BBGAlertView.h"
#import "Masonry.h"
static NSDateFormatter* dateFormaterObj = nil;

@implementation BBGTools

+ (BOOL)checkStringIsBlank:(NSString*)str{
    BOOL isBlank = YES;
    if ([str isKindOfClass:[NSNull class]]) {
        str = nil;
    }
    if (str == nil) {
        isBlank = YES;
    }
    for (int i = 0; i < str.length; i++) {
        NSRange range;
        range.location = i; range.length = 1;
        NSString* _s = [str substringWithRange:range];
        if (![_s isEqualToString:@" "]) {
            isBlank = NO;
            break;
        }
    }
    return isBlank;
}

+ (NSDateFormatter*)dateFormatter{
    if (dateFormaterObj == nil) {
        dateFormaterObj = [[NSDateFormatter alloc] init];
    }
    return dateFormaterObj;
}

+ (NSString*)timeToString:(double)unixtime Format:(NSString*)formatStr{
    NSString *timeStr = @"";
    if (unixtime > 0) {
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:unixtime];
        NSDateFormatter *dateForMatter =[self dateFormatter];
        dateFormaterObj.timeZone = [NSTimeZone systemTimeZone];
        [dateForMatter setDateFormat:formatStr];
        timeStr = [dateForMatter stringFromDate:date];
    }
    return timeStr;
}

+ (BOOL)validateChinese:(NSString *)str{
    NSString *regex = @"^[\u4E00-\u9FA5]*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:str];
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UITableViewCell *)tableViewCell:(id)obj{
    UITableViewCell *cell = (UITableViewCell*)[obj superview];
    if ([cell isKindOfClass:[UITableViewCell class]]) {
        return cell;
    }else{
        return [self tableViewCell:cell];
    }
}


+ (void)callPhone:(NSString*)phoneNumber alertTitle:(NSString*)title{
    [BBGAlertView showWithTitle:@"" message:title handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            NSString *telStr = [NSString stringWithFormat:@"tel://%@",phoneNumber];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }
    } buttonTitles:@"拨打电话", nil];
}

@end

@implementation UIImage (CS_Extensions)
- (UIImage *)imageAtRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    return subImage;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize{
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    UIGraphicsBeginImageContext(targetSize);
    
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    return newImage ;
}

-(UIImage*)reSizeImage:(CGSize)maxSize{
    CGSize originSize = self.size;
    CGSize newSize = originSize;
    if (originSize.width > originSize.height) {
        //宽图，只要考虑最大宽度即可
        if (originSize.width > maxSize.width) {
            newSize.width = maxSize.width;
            newSize.height = originSize.height*(newSize.width/originSize.width);
        }
        
    }else{
        //考虑最大高度即可
        if (originSize.height > maxSize.height) {
            newSize.height = maxSize.height;
            newSize.width = originSize.width*(newSize.height/originSize.height);
        }
    }
    return  [self imageByScalingToSize:newSize];
}
@end

@implementation UIButton (ExtentionButton)
+ (UIButton*)buttonWithMyImage:(NSString*)imageName{
    UIImage* btnImg = [UIImage imageNamed:imageName];
    CGSize imgSize = btnImg.size;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:btnImg forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    return btn;
}
+ (UIButton*)buttonWithName:(NSString *)name Price:(float)price{
    UIButton *btn = [[UIButton alloc]init];
    UILabel *label1 = [[UILabel alloc]init];
    [label1 setText:name];
    [label1 setFont:APP_FONT(13)];
    [btn addSubview:label1];
    label1.tag = 20011;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.bottom.equalTo(btn.mas_centerY).offset(-2);
    }];
    UILabel *label2 = [[UILabel alloc]init];
    [label2 setText:[NSString stringWithFormat:@"%f",price]];
    [label2 setFont:APP_FONT(11)];
    [btn addSubview:label2];
    label2.tag = 20012;
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.top.equalTo(btn.mas_centerY).offset(2);
    }];
    
    return btn;
    
}
+ (UIButton*)buttonWithMyImage:(NSString*)imageName stretchInset:(UIEdgeInsets)inset{
    UIImage* btnImg = [UIImage imageNamed:imageName];
    UIImage* btnImg2 = [btnImg resizableImageWithCapInsets:inset];
    CGSize imgSize = btnImg.size;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:btnImg2 forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    return btn;
}

+ (UIButton*)buttonWithMyImage:(NSString *)imageName Frame:(CGRect)rect{
    UIImageView* imgView = [UIImageView imageViewWithMyImage:imageName];
    [imgView setCenter:CGPointMake(rect.size.width/2.0, rect.size.height/2.0)];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    
    [btn addSubview:imgView];
    
    return btn;
}

+ (UIButton*)buttonWithTitle:(NSString*)title color:(UIColor*)_color{
    CGRect rect = CGRectMake(0, 0, 55, 31);
    return [self buttonWithTitle:title color:_color rect:rect];
}

+ (UIButton*)buttonWithTitle:(NSString*)title color:(UIColor*)_color rect:(CGRect)_rect{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:_rect];
    [btn setClipsToBounds:YES];
    [btn setBackgroundColor:_color];
    [btn setBackgroundImage:[UIImage imageNamed:@"mask_link"] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:APP_FONT(14)];
    btn.layer.cornerRadius = _rect.size.height/2.0;
    return btn;
}

@end

@implementation UIImageView(ExtentionImageView)
+ (UIImageView*)imageViewWithMyImage:(NSString*)imageName{
    UIImage* img = [UIImage imageNamed:imageName];
    CGSize imgSize = img.size;
    UIImageView* imageView = [[UIImageView alloc] initWithImage:img];
    [imageView setFrame:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    return imageView;
}
//圆角矩阵拉伸
+ (UIImageView*)imageViewWithMyImage:(NSString*)imageName stretchInset:(UIEdgeInsets)inset{
    UIImage* img = [UIImage imageNamed:imageName];
    UIImage* img2 = [img resizableImageWithCapInsets:inset];
    CGSize imgSize = img2.size;
    UIImageView* imageView = [[UIImageView alloc] initWithImage:img2];
    [imageView setFrame:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    return imageView;
}

@end

@implementation NSObject (SuperFaultTolerant)

- (id)ARRAY_OBJ_AT{
    return nil;
}
- (void)ARRAY_ADD_OBJ{
    
}
- (void)ARRAY_ADD_OBJS_FROM_ARRAY{
    
}
- (void)ARRAY_INSERT_OBJ_AT{
    
}
- (void)ARRAY_REMOVEOBJ_AT{
    
}
- (void)ARRAY_REMOVE_OBJ{
    
}
- (id)DICT_OBJ_FOR_K{
    return nil;
}
- (void)DICT_SET_VK{
    
}
- (void)DICT_REMOVEOBJ_K{
    
}
- (void)DICT_SET_DICT{
    
}
- (BOOL)DICT_HAS_K{
    return NO;
}
- (void)DICT_REMOVEOBJS_KS{
    
}



-(void)My_removeObjectAtIndex:(NSInteger)index File:(char*)file Line:(int)line{ //NSMutableArray
    if ([self isKindOfClass:[NSMutableArray class]]) {
        if (index >= 0 && index < [(NSArray*)self count]) {
            [(NSMutableArray*)self removeObjectAtIndex:index];
        }else{
            NSLog(@"[error array:%@ index:%ld 越界 count:%d | 在文件:%s  第:%d 行]",self,(long)index,(int)[(NSArray*)self count],file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
}
-(void)My_removeAllObjects_File:(char*)file Line:(int)line{ //NSMutableArray
    if ([self isKindOfClass:[NSMutableArray class]] || [self isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableArray*)self removeAllObjects];
    }else{
        NSLog(@"this is %@ class not NSMutableArray or NSMutableDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
}
-(void)My_removeObject:(id)obj File:(char*)file Line:(int)line{ //NSMutableArray
    if ([self isKindOfClass:[NSMutableArray class]]) {
        if (obj != nil) {
            [(NSMutableArray*)self removeObject:obj];
        }else{
            NSLog(@"删除对象不要为nil | 在文件:%s  第:%d 行]",file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
}
-(id)My_objectAtIndex:(NSInteger)index File:(char*)file Line:(int)line{ //NSArray
    id obj = nil;
    if ([self isKindOfClass:[NSArray class]]) {
        if (index >= 0 && index < [(NSArray*)self count]) {
            obj = [(NSArray*)self objectAtIndex:index];
        }else{
            if (index > 0) {
                NSLog(@"[error array:%@ index:%ld 越界 count:%d | 在文件:%s  第:%d 行]",self,(long)index,(int)[(NSArray*)self count],file,line);
            }
            
        }
    }else{
        NSLog(@"this is %@ class not NSArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
    
    return obj;
}
-(NSString*)MY_joinByString:(NSString*)sep File:(char*)file Line:(int)line{
    NSString* joined = nil;
    if ([self isKindOfClass:[NSArray class]]) {
        if ([sep isKindOfClass:[NSString class]]) {
            joined = [(NSArray*)self componentsJoinedByString:sep];
        }else{
            NSLog(@"this is %@ class not NSString | 在文件:%s  第:%d 行",[sep class],file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
    return joined;
}
-(void)My_setObject:(id)value forKey:(id)key File:(char*)file Line:(int)line{ //NSMutableDictionary
    if ([self isKindOfClass:[NSMutableDictionary class]]) {
        if (key == nil) {
            NSLog(@"key 不能为空 在文件:%s  第:%d 行]",file,line);
            return;
        }
        if (value == nil) {
            NSLog(@"value 不能为空 在文件:%s  第:%d 行]",file,line);
            return;
        }
        [(NSMutableDictionary*)self setObject:value forKey:key];
    }else{
        NSLog(@"this is %@ class not NSMutableDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
}
-(void)My_setDict:(NSDictionary*)dict File:(char*)file Line:(int)line{
    if ([self isKindOfClass:[NSMutableDictionary class]]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [(NSMutableDictionary*)self setDictionary:dict];
        }else{
            NSLog(@"dict is %@ class not NSDictionary | 在文件:%s  第:%d 行",[dict class],file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
}
-(void)My_removeObjectForKey:(id)key File:(char*)file Line:(int)line{
    if ([self isKindOfClass:[NSMutableDictionary class]]) {
        if (key != nil) {
            [(NSMutableDictionary*)self removeObjectForKey:key];
        }else{
            NSLog(@"key is 不能为nil | 在文件:%s  第:%d 行",file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
}
-(void)My_removeObjectsForKeys:(NSArray*)keys File:(char*)file Line:(int)line{
    if ([self isKindOfClass:[NSMutableDictionary class]]) {
        if ([keys isKindOfClass:[NSArray class]]) {
            [(NSMutableDictionary*)self removeObjectsForKeys:keys];
        }else{
            NSLog(@"keys is %@ class not NSArray | 在文件:%s  第:%d 行",[keys class],file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
}

-(BOOL)My_hasKey:(id)key File:(char*)file Line:(int)line{
    BOOL has = NO;
    if ([self isKindOfClass:[NSDictionary class]]) {
        if (key != nil) {
            if ([(NSDictionary*)self objectForKey:key] != nil) {
                has = YES;
            }
            
        }else{
            NSLog(@"aKey is nil | 在文件:%s  第:%d 行",file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
    return has;
}

- (int)My_count_File:(char*)file Line:(int)line{
    int counti = 0;
    if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSArray class]]) {
        counti = (int)[(NSArray*)self count];
    }else{
        NSLog(@"this is %@ class not NSDictionary or NSArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
    return counti;
}
- (id)My_objectForKey:(id)aKey File:(char*)file Line:(int)line{
    id obj = nil;
    if ([self isKindOfClass:[NSDictionary class]]) {
        if (aKey != nil) {
            obj = [(NSDictionary*)self objectForKey:aKey];
        }else{
            NSLog(@"aKey is nil | 在文件:%s  第:%d 行",file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
    return obj;
}
- (NSArray *)My_allKeys_File:(char*)file Line:(int)line{
    NSArray* allKeys = nil;
    if ([self isKindOfClass:[NSDictionary class]]) {
        allKeys = [(NSDictionary*)self allKeys];
    }else{
        NSLog(@"this is %@ class not NSDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
    return allKeys;
}
- (NSArray *)My_allValues_File:(char*)file Line:(int)line{
    NSArray* allValues = nil;
    if ([self isKindOfClass:[NSDictionary class]]) {
        allValues = [(NSDictionary*)self allValues];
    }else{
        NSLog(@"this is %@ class not NSDictionary | 在文件:%s  第:%d 行",[self class],file,line);
    }
    return allValues;
}
- (void)My_addObject:(id)anObject File:(char*)file Line:(int)line{
    if ([self isKindOfClass:[NSMutableArray class]]) {
        if (anObject != nil) {
            [(NSMutableArray*)self addObject:anObject];
        }else{
            NSLog(@"anObject is nil | 在文件:%s  第:%d 行",file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
}

- (void)My_addObjectsFromArray:(NSArray*)objs File:(char*)file Line:(int)line{
    if ([self isKindOfClass:[NSMutableArray class]]) {
        if ([objs isKindOfClass:[NSArray class]]) {
            [(NSMutableArray*)self addObjectsFromArray:objs];
        }else{
            NSLog(@"objs is not NSArray | 在文件:%s  第:%d 行",file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
}

- (void)My_insertObject:(id)anObject atIndex:(NSInteger)index File:(char*)file Line:(int)line{
    if ([self isKindOfClass:[NSMutableArray class]]) {
        if (anObject == nil) {
            NSLog(@"anObject is nil | 在文件:%s  第:%d 行",file,line);
            return;
        }
        if (index >= 0 && index <= [(NSMutableArray*)self count]) {
            [(NSMutableArray*)self insertObject:anObject atIndex:index];
        }else{
            NSLog(@"[insert array:%@ index:%ld 越界 count:%d | 在文件:%s  第:%d 行]",self,(long)index,(int)[(NSArray*)self count],file,line);
        }
    }else{
        NSLog(@"this is %@ class not NSMutableArray | 在文件:%s  第:%d 行",[self class],file,line);
    }
}
-(int)My_length_File:(char*)file Line:(int)line{
    int lengthI = 0;
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSData class]]) {
        lengthI = (int)[(NSString*)self length];
    }else{
        NSLog(@"this is %@ class not NSString or NSData | 在文件:%s  第:%d 行",[self class],file,line);
    }
    return lengthI;
}

-(void)My_setString:(NSString*)str File:(char*)file Line:(int)line{
    if ([self isKindOfClass:[NSMutableString class]]) {
        if (str != nil) {
            [(NSMutableString*)self setString:str];
        }else{
            NSLog(@"anObject is nil | 在文件:%s  第:%d 行",file,line);
            return;
        }
    }
}

-(void)performBlock:(void (^)(void))block Delay:(float)delay{
    [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
}

-(void)fireBlockAfterDelay:(void (^)(void))block
{
    block();
}

@end


NSString *NSStringFromOBJPointer(id obj){
    return [NSString stringWithFormat:@"%d",(int)obj];
}

NSString *NSStringFromInt(NSInteger num){
    return [NSString stringWithFormat:@"%ld",(long)num];
}

NSString *NSStringFromFloat(float num){
    return [NSString stringWithFormat:@"%f",num];
}

NSString *NSStringFromNumber(id obj){
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    return [NSString stringWithFormat:@"%@",obj];
}