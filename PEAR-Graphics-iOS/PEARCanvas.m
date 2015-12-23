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
@property (nonatomic,assign)CGPoint         touchPoint;
@property (nonatomic,assign)CGPoint         movePoint;
@property (nonatomic,assign)NSInteger       page;
@property (nonatomic,strong)NSMutableArray  *undoLists;
@property (nonatomic,strong)NSMutableArray  *redoLists;
@property (nonatomic,strong)UIBezierPath    *bezierPath;
@property (nonatomic,strong)UIImage         *lastImage;
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
        _undoLists = @[].mutableCopy;
        _redoLists = @[].mutableCopy;
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
    _bezierPath = [UIBezierPath bezierPath];
    _bezierPath.lineCapStyle = shape;
    _bezierPath.lineWidth = thickness;
    [[UIColor colorWithRed:red green:green blue:blue alpha:alpha] setStroke];
}

- (void)draw
{
    /* draw */
    [_bezierPath moveToPoint:CGPointMake(_touchPoint.x, _touchPoint.y)];
    [_bezierPath addLineToPoint:CGPointMake(_movePoint.x, _movePoint.y)];
    [_bezierPath stroke];
    _touchPoint = _movePoint;
    self.image = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)drawEnd
{
    UIGraphicsEndImageContext();
    _lastImage = self.image;
    [_undoLists addObject:_lastImage];

}

- (void)undo
{
    if (_undoLists.count > 0)
    {
        [_redoLists addObject:_lastImage];
        [_undoLists removeLastObject];
        self.image = _undoLists.lastObject;
        _lastImage = self.image;
    }
}

- (void)redo
{
    if (_redoLists.count > 0)
    {
        [_undoLists addObject:_redoLists.lastObject];
        [_redoLists removeLastObject];
        self.image = _undoLists.lastObject;
        _lastImage = self.image;
    }
}

- (void)clear
{
    self.image = nil;
    _lastImage = nil;
    _undoLists = @[].mutableCopy;
    _redoLists = @[].mutableCopy;
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
    if (!ret)
    {
        ret = [_fileManager updateFileWithData:data
                                      filePath:savePath
                                     permisson:PERMISSION];
    }
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
