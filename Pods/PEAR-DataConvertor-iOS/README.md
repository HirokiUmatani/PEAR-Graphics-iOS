### PEAR-DataConvertor-iOS [![GitHub license](https://img.shields.io/badge/LICENSE-MIT%20LICENSE-blue.svg)](https://github.com/HirokiUmatani/PEAR-DataConvertor-iOS/LICENSE) [![CocoaPods](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://cocoapods.org/pods/PEAR-DataConvertor-iOS) [![CocoaPods](https://img.shields.io/cocoapods/v/PEAR-DataConvertor-iOS.svg)](https://cocoapods.org/pods/PEAR-DataConvertor-iOS)  

====
### Overview
NSData interconversion.

### Installation
<code>
pod 'PEAR-DataConvertor-iOS'
</code>

### Usage
#### □ import header file
```
#import "DataConvertor.h"
```

#### □ NSData < = > NSString
```

    NSString *string = @"convert from string";
    NSData *strData = [DataConvertor dataFromString:string];
    NSLog(@"=> String Data:%@",strData);
    NSString * dataStr = [DataConvertor stringFromData:strData];
    NSLog(@"=> String:%@",dataStr);
```
    
#### □ NSData < = > NSInteger
``` 
    NSInteger integer = -666;
    NSData *intData = [DataConvertor dataFromInteger:integer];
    NSLog(@"=> Integer Data:%@",intData);
    NSInteger dataInt = [DataConvertor integerFromData:intData];
    NSLog(@"=> Integer:%zd",dataInt);
```

#### □  NSData < = > CGFloat
```
    CGFloat float_ = 99.99;
    NSData *floatData = [DataConvertor dataFromFloat:float_];
    NSLog(@"=> Float Data:%@",floatData);
    CGFloat dataFloat = [DataConvertor floatFromData:floatData];
    NSLog(@"=> Float:%f",dataFloat);
```

#### □ NSData < = > NSNumber
```
    NSNumber *number = @(333);
    NSData *numData = [DataConvertor dataFromNumber:number];
    NSLog(@"=> Number Data:%@",numData);
    NSNumber *dataNum = [DataConvertor numberFromData:numData];
    NSLog(@"=> Number:%@",dataNum);
```

#### □ NSData < = > NSArray
```
    NSArray *array = @[strData,
                       intData,
                       floatData,
                       numData];
    NSData *arrayData = [DataConvertor dataFromArray:array];
    NSLog(@"=> Array Data:%@",arrayData);
    NSArray *dataArray = [DataConvertor arrayFromData:arrayData];
    NSLog(@"=> Array:%@",dataArray);
```

#### □ NSData < = > NSDictionary
```
    NSDictionary *dictionary = @{@"str":strData,
                                 @"int":intData,
                                 @"float":floatData,
                                 @"num":numData,
                                 @"array":arrayData};
    NSData *dictData = [DataConvertor dataFromDictionary:dictionary];
    NSLog(@"=> Dictionary Data:%@",dictData);
    NSArray *dataDict = [DataConvertor arrayFromData:dictData];
    NSLog(@"=> Dictionary:%@",dataDict);
```

#### □ NSData < = > UIImage(PNG)
```
    UIImage *pngImg = [UIImage imageNamed:@"pngsample.png"];
    NSData *imgPNGData = [DataConvertor dataFromPNGImage:pngImg];
    NSLog(@"=> PNG Image Data:%@",imgPNGData);
    UIImage *dataImgPNG = [DataConvertor imageFromData:imgPNGData];
    NSLog(@"=> PNG Image:%@",dataImgPNG);
```

#### □ NSData < = > UIImage(JPG))
```
    UIImage *jpgImg = [UIImage imageNamed:@"jpgsample.jpg"];
    NSData *imgJPGData = [DataConvertor dataFromJPGImage:jpgImg quality:1.0];
    NSLog(@"=> JPG Image Data:%@",imgJPGData);
    UIImage *dataImgJPG = [DataConvertor imageFromData:imgJPGData];
    NSLog(@"=> JPG Image:%@",dataImgJPG);
```

### Documents
[library document](http://cocoadocs.org/docsets/PEAR-DataConvertor-iOS)

### Licence
[MIT](https://github.com/HirokiUmatani/PEAR-DataConvertor-iOS/blob/master/LICENSE)

### Author
[Hiroki Umatani](https://github.com/HirokiUmatani)
