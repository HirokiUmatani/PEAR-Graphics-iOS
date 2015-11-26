### PEAR-Graphics-iOS [![GitHub license](https://img.shields.io/badge/LICENSE-MIT%20LICENSE-blue.svg)](https://github.com/HirokiUmatani/PEAR-Graphics-iOS/LICENSE) [![CocoaPods](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://cocoapods.org/pods/PEAR-Graphics-iOS) [![CocoaPods](https://img.shields.io/cocoapods/v/PEAR-Graphics-iOS.svg)](https://cocoapods.org/pods/PEAR-Graphics-iOS)  

====
### Overview
This library can draw on a canvas in iOS.

### Demo Screen
![draw_canvas_demo](http://pear.chat/image/drawcanvasdemo-o.gif)

### Installation
<code>
pod 'PEAR-Graphics-iOS'
</code>

### Usage

#####□import  
``` Objective-C
#import "PEARGraphics.h"
```

#####□create instance  

``` Objective−C
PEARCanvas *_canvas = [[PEARCanvas alloc] initWithFrame:self.view.frame
                                         onView:self.view
                                          index:0];
```

#####□draw  

``` Objective−C
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_canvas setTouchPointWithTouches:touches];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_canvas setMovePointWithTouches:touches];
    [_canvas drawStart];
    [_canvas setPencilWithShape:kCGLineCapRound
                      thickness:5.0   colorRed:0.0
                     colorGreen:0.0  colorBlue:0.0
                          alpha:1.0];
    [_canvas draw];
    [_canvas drawEnd];
}
```
#####□save  

``` Objective−C
    [_canvas save];
```

#####□fatch save List data  

``` Objective−C
    [_canvas fetchSaveData];
```

#####□fatch save image data
``` Objective−C
    [_canvas fetchSaveDataAtIndex:0];
```

### Document
[document library](http://cocoadocs.org/docsets/PEAR-Graphics-iOS)

### Licence
[MIT](https://github.com/HirokiUmatani/PEAR-Graphics-iOS/blob/master/LICENSE)

### Author
[Hiroki Umatani](https://github.com/HirokiUmatani)
