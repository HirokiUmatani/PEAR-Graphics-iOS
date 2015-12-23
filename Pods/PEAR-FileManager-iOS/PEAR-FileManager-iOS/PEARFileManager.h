//
//  PEARFileManager.h
//  FileManager
//
//  Created by hirokiumatani on 2015/10/31.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PEARFileManager : NSObject

typedef NS_ENUM(NSInteger,ROOT_DIR_TYPE)
{
    k_ROOT_DIR_DOCUMENTS,
    k_ROOT_DIR_LIBRARY,
    k_ROOT_DIR_TMP,
};


@property (nonatomic,assign)ROOT_DIR_TYPE rootDir;
/**
 initial with root directory
 */
- (id)initWithRootPath:(ROOT_DIR_TYPE)rootType;

/**
 singletone instance
 */
+ (PEARFileManager *)sharedInstatnce;

/**
 set root directory
 */
- (void)setRootDirectory:(ROOT_DIR_TYPE)rootType;

/**
 get root directory path
 */
- (NSString *)getRootDirectoryPath;

/**
 join file name in dir path
 */
- (NSString *)joinFileName:(NSString *)fileName
                 inDirPath:(NSString *)dirPath;

/**
 create directory
 */
- (BOOL)createDirectory:(NSString *)dirPath
              permisson:(NSNumber *)permission;

/**
 create file
 */
- (BOOL)createFileWithData:(NSData *)fileData
                  filePath:(NSString *)filePath
                 permisson:(NSNumber *)permission;

/**
 fetch data
 */
- (NSData *)fetchFileDataWithPath:(NSString *)path;

/**
 fetch file Names
 */
- (NSArray *)fetchFileNameListsWithDirPath:(NSString *)dirPath;

/**
 check file or directory
 */
- (BOOL)checkPath:(NSString *)path;

/**
 delete file or directory
 */
- (BOOL)deletePath:(NSString *)Path;

/**
 update directory
 */
- (BOOL)updateDirectory:(NSString *)dirPath
              permisson:(NSNumber *)permission;

/**
 update file
 */
- (BOOL)updateFileWithData:(NSData *)fileData
                  filePath:(NSString *)filePath
                 permisson:(NSNumber *)permission;

/**
 move file or directory
 */
- (BOOL)moveFromPath:(NSString *)fromPath toPath:(NSString *)toPath;

/**
 copy file or directory
 */
- (BOOL)copyFrompath:(NSString *)fromPath toPath:(NSString *)toPath;

@end
