//
//  PEARCanvas.m
//  Graphics
//
//  Created by hirokiumatani on 2015/11/22.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//
#import "PEARFileManager.h"
#import "DataConvertor.h"
#import "PEARCanvas.h"
@interface PEARCanvas()
@property (nonatomic,assign)CGPoint     touchPoint;
@property (nonatomic,assign)CGPoint     movePoint;
@property (nonatomic,assign)NSInteger   page;
@property (nonatomic,strong)PEARFileManager *fileManager;
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

#define DIR_NAME @"draw_data"
#define PERMISSION @0755

- (void)save
{
    _fileManager = [PEARFileManager sharedInstatnce];
    NSData *data =[DataConvertor dataFromPNGImage:self.image];

    [_fileManager createDirectory:DIR_NAME
                        permisson:PERMISSION];
    
    NSString *saveName = [NSString stringWithFormat:@"save_%zd.png",self.page];
    NSString *savePath = [_fileManager joinFileName:saveName
                                          inDirPath:DIR_NAME];
    BOOL ret = [_fileManager createFileWithData:data
                                       filePath:savePath
                                      permisson:PERMISSION];
    if (ret)
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
    _fileManager = [PEARFileManager sharedInstatnce];
    
    NSMutableArray *results     = @[].mutableCopy;
    
    NSString       *dirPath     = [_fileManager joinFileName:DIR_NAME
                                                   inDirPath:[_fileManager getRootDirectoryPath]];
    NSArray        *fileNames   = [_fileManager fetchFileNameListsWithDirPath:dirPath];
    
    for (NSString *fileName in fileNames)
    {
        
        NSString *filePath  = [_fileManager joinFileName:fileName inDirPath:DIR_NAME];
        NSData   *data      = [_fileManager fetchFileDataWithPath:filePath];
        UIImage  *image     = [DataConvertor imageFromData:data];
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
@end
