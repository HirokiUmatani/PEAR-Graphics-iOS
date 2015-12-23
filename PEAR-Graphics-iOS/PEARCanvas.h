//
//  PEARCanvas.h
//  Graphics
//
//  Created by hirokiumatani on 2015/11/22.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PEARCanvas : UIImageView

- (id)initWithFrame:(CGRect)frame
             onView:(UIView *)onView
              index:(NSInteger)index;

- (void)insertCanvasOnView:(UIView *)view
                     index:(NSInteger)index;

- (void)drawStart;

- (void)setPencilWithShape:(CGLineCap)shape
                 thickness:(CGFloat)thickness
                  colorRed:(CGFloat)red
                colorGreen:(CGFloat)green
                 colorBlue:(CGFloat)blue
                     alpha:(CGFloat)alpha;

- (void)draw;

- (void)drawEnd;

- (void)undo;

- (void)redo;

- (void)clear;

- (void)setTouchPointWithTouches:(NSSet *)touches;

- (void)setMovePointWithTouches:(NSSet *)touches;

- (void)save;

- (NSArray *)fetchSaveData;

- (UIImage *)fetchSaveDataAtIndex:(NSInteger)index;

@end
