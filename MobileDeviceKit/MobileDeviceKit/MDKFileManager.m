//
//  MDKFileManager.m
//  devicekit
//
//  Created by Kam Dahlin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MDKFileManager.h"
#import "MDKApplication.h"
#import "DTDeviceKit.h"

@interface MDKFileManager ()
@property (nonatomic, retain) DTDKApplicationPackage *applicationDirectory;

- (NSArray *)rootDirectoryContents;
- (DTDKApplicationDirectory *)applicationDirectoryListWithPath:(NSString *)path;
@end

@implementation MDKFileManager
@synthesize applicationDirectory = _applicationDirectory;

- (id)initWithApplicationDirectory:(DTDKApplicationPackage *)app
{
    if (! (self = [super init])) {
        return nil;
    }
    
    _applicationDirectory = app;
    return self;
}

- (BOOL)downloadRemoteURL:(NSURL *)file toLocalPath:(NSURL *)localPath error:(NSError **)error
{
    return NO;
}

- (BOOL)uploadLocalURL:(NSURL *)file toRemotePath:(NSURL *)remotePath error:(NSError **)error
{
    return NO;
}

- (NSArray *)directoryContents:(NSURL *)remoteURL; // passing nil will list applications root
{
    if(remoteURL == nil) {
        return [self rootDirectoryContents];
    }
    
    NSString *rootDirName = [remoteURL relativePath];
    NSLog(@"rootDirName: %@", rootDirName);
    DTDKApplicationDirectory *dir = [self applicationDirectoryListWithPath:rootDirName];
    NSLog(@"dir is: %@", [dir subPath]);
    return nil;
}

- (NSArray *)rootDirectoryContents
{
    __block NSMutableArray *contents = nil;
    [[[self.applicationDirectory sandboxFileBases] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *path = [obj subPath];
        NSURL *url = [NSURL fileURLWithPath:path isDirectory:[obj isLeaf]];
        [contents addObject:url];
        
    }];
    
    return contents;
}

- (DTDKApplicationDirectory *)applicationDirectoryListWithPath:(NSString *)path;
{
    __block DTDKApplicationDirectory *dir = nil;
    NSArray *bases = [[self.applicationDirectory sandboxFileBases] allObjects];
    [bases enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSRange range = [path rangeOfString:[obj subPath]];
        if (range.length > 0) {
            dir = obj;
            *stop = YES;
        }
    }];
    return dir;
}
@end
