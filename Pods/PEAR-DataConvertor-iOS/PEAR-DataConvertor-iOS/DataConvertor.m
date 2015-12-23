//
//  DataConvertor.m
//  DataConvertor
//
//  Created by hirokiumatani on 2015/11/28.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "DataConvertor.h"

@implementation DataConvertor
+ (NSData *)dataFromString:(NSString *)string
{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)stringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)dataFromInteger:(NSInteger)integer
{
    return [NSData dataWithBytes:&integer length:sizeof(integer)];
}

+ (NSInteger)integerFromData:(NSData *)data
{
    NSInteger result;
    [data getBytes:&result length:sizeof(result)];
    return result;
}

+ (NSData *)dataFromFloat:(CGFloat)_float
{
    return [NSData dataWithBytes:&_float length:sizeof(_float)];
}

+ (CGFloat)floatFromData:(NSData *)data
{
    CGFloat result;
    [data getBytes:&result length:sizeof(result)];
    return result;

}

+ (NSData *)dataFromNumber:(NSNumber *)number
{
    NSInteger integer = [number integerValue];
    return [self dataFromInteger:integer];
}

+ (NSNumber *)numberFromData:(NSData *)data
{
    return @([self integerFromData:data]);
}

+ (NSData *)dataFromArray:(NSArray *)array
{
    return [NSKeyedArchiver archivedDataWithRootObject:array];
}

+ (NSArray *)arrayFromData:(NSData *)data
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (NSData *)dataFromDictionary:(NSDictionary *)dictionary
{
    return [NSKeyedArchiver archivedDataWithRootObject:dictionary];
}

+ (NSDictionary *)dictionaryFromData:(NSData *)data
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (NSData *)dataFromPNGImage:(UIImage*)image
{
    return [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
}

+ (NSData *)dataFromJPGImage:(UIImage*)image quality:(CGFloat)quality
{
    return [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, quality)];
}

+ (UIImage *)imageFromData:(NSData *)data
{
    return [[UIImage alloc] initWithData:data];
}
@end
