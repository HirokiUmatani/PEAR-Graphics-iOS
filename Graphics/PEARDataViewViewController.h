//
//  PEARDataViewViewController.h
//  Graphics
//
//  Created by hirokiumatani on 2015/11/23.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PEARDataViewViewControllerDelegate <NSObject>
- (void)didSelectLoadImage:(UIImage *)image;
@end
@interface PEARDataViewViewController : UIViewController
@property (nonatomic,assign) id <PEARDataViewViewControllerDelegate> delegate;
@end
