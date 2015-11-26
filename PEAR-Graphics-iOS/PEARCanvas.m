//
//  PEARCanvas.m
//  Graphics
//
//  Created by hirokiumatani on 2015/11/22.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "PEARCanvas.h"
@interface PEARCanvas()
@property (nonatomic,assign)CGPoint     touchPoint;
@property (nonatomic,assign)CGPoint     movePoint;
@property (nonatomic,assign)NSInteger   page;
@end
@implementation PEARCanvas

- (id)initWithFrame:(CGRect)frame
             onView:(UIView *)view
              index:(NSInteger)index
{
    if (self = [super initWithFrame:frame])
    {
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
        [self insertCanvasOnView:view index:index];
    }
    return self;
}

- (void)insertCanvasOnView:(UIView *)view
                     index:(NSInteger)index
{
    [view insertSubview:self atIndex:index];
}

- (void)drawStart
{
    /* draw start */
    UIGraphicsBeginImageContext(self.frame.size);
    /* set draw area */
    [self.image drawInRect:self.frame];
}

- (void)setPencilWithShape:(CGLineCap)shape
                 thickness:(CGFloat)thickness
                  colorRed:(CGFloat)red
                colorGreen:(CGFloat)green
                 colorBlue:(CGFloat)blue
                     alpha:(CGFloat)alpha

{
    /* Pencil */
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), shape);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),thickness);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, alpha);
}

- (void)draw
{
    /* draw */
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _touchPoint.x, _touchPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _movePoint.x, _movePoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.image = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)drawEnd
{
    UIGraphicsEndImageContext();
    _touchPoint = _movePoint;
}

- (void)setTouchPointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
}

- (void)setMovePointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    _movePoint = [touch locationInView:self];
    
}

- (void)save
{
    NSData *data = UIImagePNGRepresentation(self.image);
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"save_%zd.png",self.page];
    NSString *filePath = [cacheDirPath stringByAppendingPathComponent:fileName];
    
    if ([data writeToFile:filePath atomically:YES])
    {
        // success
        self.page ++;
    }
    else
    {
        // error
    }
}

- (NSArray *)fetchSaveData
{
    NSMutableArray * results = @[].mutableCopy;
    NSString * filePath = [self filePath];
    NSArray * fileNames = [self fileNames];
    
    for (NSString *fileName in fileNames)
    {
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@",filePath,fileName];
        NSData *data = [self loadData:fullPath];
        UIImage *image = [UIImage imageWithData:data];
        if (image)
        {
            [results addObject:image];
        }
    }
    return results;
}

- (UIImage *)fetchSaveDataAtIndex:(NSInteger)index
{
    NSArray *fetchLists = [self fetchSaveData];
    UIImage *image = fetchLists[index];
    return image;
}

- (NSString *)filePath
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    return cacheDirPath;
}

- (NSArray *)fileNames
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    
    return [[NSFileManager defaultManager]  contentsOfDirectoryAtPath:cacheDirPath error:nil];
}

- (NSData*)loadData:(NSString*)fileName
{
    return [[NSData alloc] initWithContentsOfFile:fileName];
}

@end
