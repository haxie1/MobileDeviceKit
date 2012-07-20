//
//  MDKFileManager.h
//  devicekit
//
//  Created by Kam Dahlin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DTDKApplicationPackage;
@interface MDKFileManager : NSObject
- (id)initWithApplicationDirectory:(DTDKApplicationPackage *)app;

- (BOOL)downloadRemoteURL:(NSURL *)file toLocalPath:(NSURL *)localPath error:(NSError **)error;
- (BOOL)uploadLocalURL:(NSURL *)file toRemotePath:(NSURL *)remotePath error:(NSError **)error;

- (NSArray *)directoryContents:(NSURL *)remoteURL; // passing nil will list applications root

@end
