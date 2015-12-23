//
//  DataConvertor.h
//  DataConvertor
//
//  Created by hirokiumatani on 2015/11/28.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DataConvertor : NSObject

#pragma mark - Aniting => Data
/** String -> Data */
+ (NSData *)dataFromString:(NSString *)string;
/** Integer -> Data */
+ (NSData *)dataFromInteger:(NSInteger)integer;
/** CGFloat -> Data */
+ (NSData *)dataFromFloat:(CGFloat)_float;
/** Number -> Data */
+ (NSData *)dataFromNumber:(NSNumber *)number;
/** Array -> Data*/
+ (NSData *)dataFromArray:(NSArray *)array;
/** Dictionary -> Data */
+ (NSData *)dataFromDictionary:(NSDictionary *)dictionary;
/** Image(PNG) -> Data */
+ (NSData *)dataFromPNGImage:(UIImage*)image;
/** Image(JPG) -> Data */
+ (NSData *)dataFromJPGImage:(UIImage*)image quality:(CGFloat)quality;

#pragma mark - Data <= Anyting
/** Data -> String */
+ (NSString *)stringFromData:(NSData *)data;
/** Data -> Integer */
+ (NSInteger)integerFromData:(NSData *)data;
/** Data -> CGFloat */
+ (CGFloat)floatFromData:(NSData *)data;
/** Data -> Number */
+ (NSNumber *)numberFromData:(NSData *)data;
/** Data -> Array */
+ (NSArray *)arrayFromData:(NSData *)data;
/** Data -> Dictionary */
+ (NSDictionary *)dictionaryFromData:(NSData *)data;
/** Data -> Image */
+ (UIImage *)imageFromData:(NSData *)data;
@end
