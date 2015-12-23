### PEAR-FileManager-iOS [![GitHub license](https://img.shields.io/badge/LICENSE-MIT%20LICENSE-blue.svg)](https://github.com/HirokiUmatani/PEAR-FileManager-iOS/LICENSE) [![CocoaPods](https://img.shields.io/badge/platform-ios-lightgrey.svg)](https://cocoapods.org/pods/PEAR-FileManager-iOS) [![CocoaPods](https://img.shields.io/cocoapods/v/PEAR-FileManager-iOS.svg)](https://cocoapods.org/pods/PEAR-FileManager-iOS)  

====
### Overview
This is the ios library to manipulate directories and files in application.

### Installation
<code>
pod 'PEAR-FileManager-iOS'
</code>

### Usage

##### initial
```
PEARFileManager *fileManager = [PEARFileManager sharedInstatnce];
fileManager.rootDir = k_ROOT_DIR_LIBRARY;

```
##### Create 
```
[fileManager createDirectory:DIR_PATH permisson:PERMISSION];

```
```
[fileManager createFileWithData:pearImageData
                           filePath:[fileManager joinFileName:FILE_NAME inDirPath:DIR_PATH]
                          permisson:PERMISSION];


```
##### Copy 
```
[fileManager copyFrompath:[fileManager joinFileName:FILE_NAME inDirPath:DIR_PATH]
                       toPath:[fileManager joinFileName:COPY_FILE_NAME inDirPath:DIR_PATH]];

```
##### Move 
```
[fileManager moveFromPath:DIR_PATH
                       toPath:MOVE_DIR_PATH];

```
##### Delete 
```
[fileManager deletePath:[fileManager joinFileName:FILE_NAME inDirPath:DIR_PATH]];

```

### Documents
[library document](http://cocoadocs.org/docsets/PEAR-FileManager-iOS)

### Licence
[MIT](https://github.com/HirokiUmatani/PEAR-FileManager-iOS/blob/master/LICENSE)

### Author
[Hiroki Umatani](https://github.com/HirokiUmatani)
