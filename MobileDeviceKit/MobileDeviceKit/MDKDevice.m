//
//  MDKDevice.m
//  devicekit
//
//  Created by Kam Dahlin on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MDKDevice.h"
#import "DTDeviceKit.h"
#import "MDKApplication.h"

@interface MDKApplication (Private)
- (id)initWithDTDKApplication:(DTDKApplication *)app;
@end

@interface MDKDevice ()
@property (nonatomic, retain) DTDKRemoteDeviceToken *deviceToken;
@property (nonatomic, retain) NSMutableArray *mdkApplications;
- (id)_initWithDeviceToken:(DTDKRemoteDeviceToken *)token;
@end

@implementation MDKDevice
@synthesize deviceToken = _deviceToken;
@synthesize mdkApplications = _mdkApplications;
- (id)_initWithDeviceToken:(DTDKRemoteDeviceToken *)token
{
    if(! (self = [super init])) {
        return nil;
    }
    
    _deviceToken = [token retain];
    return self;
}

- (void)dealloc
{
    [_deviceToken release];
    [_mdkApplications release];
    
    [super dealloc];
}

- (NSString *)name
{
    return self.deviceToken.deviceName;
}

- (NSString *)identifier
{
    return self.deviceToken.deviceIdentifier;
}

- (NSString *)serialNumber
{
    return self.deviceToken.deviceSerialNumber;
}

- (NSDictionary *)deviceInfo
{
    
    return [self.deviceToken propertyListRepresentation];
}

- (NSArray *)applications
{
    if (! self.mdkApplications) {
        self.mdkApplications = [NSMutableArray array];
    
        NSArray *apps = [[self.deviceToken applications] allObjects];
        [apps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DTDKApplication *app = (DTDKApplication *)obj;
            MDKApplication *mdkApp = [[MDKApplication alloc] initWithDTDKApplication:app];
            [self.mdkApplications addObject:mdkApp];
            [mdkApp release];
        
        }];
    }
    
    // should we check for changes before we return? 
    return self.mdkApplications;
}

- (MDKApplication *)applicationWithName:(NSString *)name
{
    __block MDKApplication *app = nil;
    [[self applications] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MDKApplication *lApp = (MDKApplication *)obj;
        if ([lApp.name isEqualToString:name]) {
            app = lApp;
            *stop = YES;
        }
    }];
    
    return app;
}

- (MDKApplication *)applicationWithIdentifier:(NSString *)identifier
{
    __block MDKApplication *app = nil;
    [[self applications] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MDKApplication *lApp = (MDKApplication *)obj;
        if ([lApp.identifier isEqualToString:identifier]) {
            app = lApp;
            *stop = YES;
        }
    }];
    
    return app;
}

- (BOOL)installApplication:(MDKApplication *)application error:(NSError **)error
{
    return NO;
}
@end
