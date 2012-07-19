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

- (MDKFileManager *)applicationFileManager
{
    return nil;
}

@end
