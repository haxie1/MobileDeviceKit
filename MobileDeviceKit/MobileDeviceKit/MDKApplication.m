//
//  MDKApplication.m
//  devicekit
//
//  Created by Kam Dahlin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MDKApplication.h"
#import "DTDeviceKit.h"
#import "MDKFileManager.h"

@interface MDKApplication ()
@property (nonatomic, retain) DTDKApplication *application;
@property (nonatomic, retain) MDKFileManager *fileManager;
- (id)initWithDTDKApplication:(DTDKApplication *)app;
@end

@implementation MDKApplication
@synthesize application = _application;

- (id)initWithDTDKApplication:(DTDKApplication *)app
{
    if (! (self = [super init])) {
        return nil;
    }
    
    _application = [app retain];
    
    return self;
}

- (void)dealloc
{
    [_application release];
    [_fileManager release];
    [super dealloc];
}

- (NSString *)name
{
    return self.application.name;
}

- (NSString *)identifier
{
    return self.application.identifier;
}

- (NSString *)devicePath
{
    return self.application.devicePath;
}

- (NSDictionary *)infoPlist
{
    return self.application.plist;
}

@synthesize fileManager = _fileManager;
- (MDKFileManager *)applicationFileManager
{
    if (! self.fileManager) {
        DTDKApplicationPackage *root = [self.application.children anyObject];
        self.fileManager = [[[MDKFileManager alloc] initWithApplicationDirectory:root] autorelease];
    }
    
    return self.fileManager;
}

@end
