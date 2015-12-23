//
//  ViewController.m
//  Graphics
//
//  Created by hirokiumatani on 2015/11/22.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "ViewController.h"
#import "PEARCanvas.h"

@interface ViewController ()
{
    PEARCanvas *_canvas;
    __weak IBOutlet NSLayoutConstraint *viewBottomMargin;
    __weak IBOutlet NSLayoutConstraint *clearBottomMargin;
    __weak IBOutlet NSLayoutConstraint *saveBottomMargin;
    BOOL isMenu;
}
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"backGroundView"]];
    
   
    _canvas = [[PEARCanvas alloc] initWithFrame:self.view.frame
                                         onView:self.view
                                          index:0];
    [self showMenu];
     
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideMenu];
    [_canvas setTouchPointWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self draw:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_canvas drawEnd];
}
- (void)draw:(NSSet *)touches
{
    [_canvas setMovePointWithTouches:touches];
    [_canvas drawStart];
    [_canvas setPencilWithShape:kCGLineCapRound
                      thickness:5.0   colorRed:0.0
                     colorGreen:0.0  colorBlue:0.0
                          alpha:1.0];
    [_canvas draw];
}

- (IBAction)tapMenu:(UIButton *)sender
{
    if (isMenu)
    {
        [self hideMenu];
    }
    else
    {
        [self showMenu];
    }
}
- (IBAction)saveButton:(UIButton *)sender
{
    [_canvas save];
}
- (IBAction)clearButton:(UIButton *)sender
{
    [_canvas clear];
}
- (IBAction)undoButton:(UIButton *)sender
{
    [_canvas undo];
}
- (IBAction)redoButton:(UIButton *)sender
{
    [_canvas redo];
}

#define BUTTON_HEIGHT 76
#define MARGIN 10
- (void)showMenu
{
    viewBottomMargin.constant   = MARGIN +BUTTON_HEIGHT*3;
    clearBottomMargin.constant  = MARGIN +BUTTON_HEIGHT*2;
    saveBottomMargin.constant   = MARGIN +BUTTON_HEIGHT;
    [UIView animateWithDuration:0.6 animations:^
     {
         [self.view layoutIfNeeded];
         
     }
                     completion:^(BOOL finished)
     {
         isMenu = YES;
     }];
}


- (void)hideMenu
{
    viewBottomMargin.constant  = 10;
    clearBottomMargin.constant = 10;
    saveBottomMargin.constant  = 10;
    [UIView animateWithDuration: 0.6 animations:^
     {
         [self.view layoutIfNeeded];
         
     }
                     completion:^(BOOL finished)
     {
         isMenu = NO;
     }];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PEARDataViewViewController"]) {
        PEARDataViewViewController *dataViewViewController = segue.destinationViewController;
        dataViewViewController.delegate = self;
       
    }
}
#pragma mark - PEARDataViewViewControllerDelegate
- (void)didSelectLoadImage:(UIImage *)image
{
    _canvas.image = nil;
    _canvas.image = image;
}
@end
