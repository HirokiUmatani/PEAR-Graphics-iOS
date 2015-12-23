//
//  PEARFileManager.m
//  FileManager
//
//  Created by hirokiumatani on 2015/10/31.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "PEARFileManager.h"

@interface PEARFileManager ()

@property (nonatomic,strong) NSString *rootPath;

@end

@implementation PEARFileManager

static PEARFileManager *_sharedInstatnce = nil;

#pragma mark - initial
+ (PEARFileManager*)sharedInstatnce
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        _sharedInstatnce = [[PEARFileManager alloc] init];
        [_sharedInstatnce setRootDirectory:k_ROOT_DIR_LIBRARY];
    });
    return _sharedInstatnce;
}

- (id)init
{
    if (self == [super init])
    {
        [self setRootDir:k_ROOT_DIR_LIBRARY];
    }
    return self;
}

- (id)initWithRootPath:(ROOT_DIR_TYPE)rootType
{
    if (self == [super init])
    {
        [self setRootDir:rootType];
    }
    return self;
}

#pragma mark - root directory
- (void)setRootDirectory:(ROOT_DIR_TYPE)rootType
{
    switch (rootType)
    {
        case k_ROOT_DIR_DOCUMENTS:
        {
            _rootPath = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
            break;
        }
        case k_ROOT_DIR_LIBRARY:
        {
            _rootPath = [NSString stringWithFormat:@"%@/Library",NSHomeDirectory()];
            break;
        }
        case k_ROOT_DIR_TMP:
        {
            _rootPath = [NSString stringWithFormat:@"%@/tmp",NSHomeDirectory()];
            break;
        }
    }
}

- (NSString *)getRootDirectoryPath
{
    return _rootPath;
}

#pragma mark - create
- (BOOL)createDirectory:(NSString *)dirPath
              permisson:(NSNumber *)permission
{
    if ([self checkPath:dirPath])
    {
        NSLog(@"The path already exists");
        return NO;
    }
    
    return [[NSFileManager new] createDirectoryAtPath:[self joinFileName:dirPath inDirPath:_rootPath]
                          withIntermediateDirectories:YES
                                           attributes:@{NSFilePosixPermissions: permission}
                                                error:nil];
}

- (BOOL)createFileWithData:(NSData *)fileData
                  filePath:(NSString *)filePath
                 permisson:(NSNumber *)permission
{
    if ([self checkPath:filePath])
    {
        NSLog(@"The path already exists");
        return NO;
    }
    
    NSString *filesPath = [self joinFileName:filePath inDirPath:_rootPath];
    
    return [[NSFileManager new] createFileAtPath:filesPath
                                        contents:fileData
                                      attributes:@{NSFilePosixPermissions:permission}];
}

#pragma mark - update
- (BOOL)updateDirectory:(NSString *)dirPath
              permisson:(NSNumber *)permission
{
    if (![self checkPath:dirPath])
    {
        NSLog(@"The path dose not exists");
        return NO;
    }
    
    return [[NSFileManager new] createDirectoryAtPath:[self joinFileName:dirPath inDirPath:_rootPath]
                          withIntermediateDirectories:YES
                                           attributes:@{NSFilePosixPermissions: permission}
                                                error:nil];
}

- (BOOL)updateFileWithData:(NSData *)fileData
                  filePath:(NSString *)filePath
                 permisson:(NSNumber *)permission
{
    if (![self checkPath:filePath])
    {
        NSLog(@"The path dose not exists");
        return NO;
    }
    
    return [[NSFileManager new] createFileAtPath:[self joinFileName:filePath inDirPath:_rootPath]
                                        contents:fileData
                                      attributes:@{NSFilePosixPermissions:permission}];
    
}

#pragma mark - fetch
- (NSData *)fetchFileDataWithPath:(NSString *)path
{
    if (![self checkPath:path])
    {
        NSLog(@"The path dose not exists");
        return nil;
    }
    return [[NSFileManager new] contentsAtPath:[self joinFileName:path inDirPath:_rootPath]];
}

- (NSArray *)fetchFileNameListsWithDirPath:(NSString *)dirPath
{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
}

#pragma mark - check
- (BOOL)checkPath:(NSString *)path
{
    return [[NSFileManager new] fileExistsAtPath:[self joinFileName:path inDirPath:_rootPath]];
}

#pragma mark - delete
- (BOOL)deletePath:(NSString *)path
{
    if (![self checkPath:path])
    {
        NSLog(@"The path dose not exists");
        return NO;
    }
    return [[NSFileManager new] removeItemAtPath:[self joinFileName:path inDirPath:_rootPath] error:nil];
}

#pragma mark - move
- (BOOL)moveFromPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    if (![self checkPath:fromPath])
    {
        NSLog(@"The path dose not exists");
        return NO;
    }
    if ([self checkPath:toPath])
    {
        NSLog(@"The path already exists");
    }

    return [[NSFileManager new] moveItemAtPath:[self joinFileName:fromPath inDirPath:_rootPath]
                                        toPath:[self joinFileName:toPath inDirPath:_rootPath] error:nil];
}

#pragma mark - copy
- (BOOL)copyFrompath:(NSString *)fromPath toPath:(NSString *)toPath
{
    if (![self checkPath:fromPath])
    {
        NSLog(@"The path dose not exists");
        return NO;
    }
    if ([self checkPath:toPath])
    {
        NSLog(@"The path already exists");
    }
    
   return [[NSFileManager new] copyItemAtPath:[self joinFileName:fromPath inDirPath:_rootPath]
                                       toPath:[self joinFileName:toPath inDirPath:_rootPath] error:nil];
}

#pragma mark - join
- (NSString *)joinFileName:(NSString *)fileName
                 inDirPath:(NSString *)dirPath
{
    return [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
}
@end
