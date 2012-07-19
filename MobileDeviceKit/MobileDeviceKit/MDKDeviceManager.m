//
//  MDKDeviceManager.m
//  devicekit
//
//  Created by Kam Dahlin on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MDKDeviceManager.h"
#import "DTDeviceKit.h"

@interface MDKDevice (Private)
-(id)_initWithDeviceToken:(DTDKRemoteDeviceToken *)token;
@end

@interface MDKDeviceManager () <DTDKRemoteDeviceDataListenerDelegate>
@property (nonatomic, retain) DTDKRemoteDeviceDataListener *listener;
@property (nonatomic, retain) NSMutableArray *foundDevices;
- (MDKDevice *)_deviceForToken:(DTDKRemoteDeviceToken *)token;
@end

@implementation MDKDeviceManager
@synthesize listener = _listener;
@synthesize foundDevices = _foundDevices;
@synthesize delegate = _delegate;
+ (MDKDeviceManager *)sharedManager
{
    static dispatch_once_t pred;
    static MDKDeviceManager *deviceManager = nil;
    
    dispatch_once(&pred, ^{ deviceManager = [[self alloc] init]; });
    return deviceManager;
}

- (void)dealloc
{
    [self stopSearchingForDevices];
    [_foundDevices release];
    _delegate = nil;
    
    [super dealloc];
    
}

- (NSArray *)devices
{
    return self.foundDevices;
}

- (void)startSearchingForDevices
{
    if(! self.listener) {
        self.listener = [DTDKRemoteDeviceDataListener sharedInstance];
        self.listener.delegate = self;
    }
    
    [self.listener startListening];
    if([self.delegate respondsToSelector:@selector(deviceManagerStartedSearching:)]) {
        [self.delegate deviceManagerStartedSearching:self];
    }
}

- (void)stopSearchingForDevices
{
    [self.listener stopListening];
    if([self.delegate respondsToSelector:@selector(deviceManagerStoppedSearching::)]) {
        [self.delegate deviceManagerStoppedSearching:self];
    }
}

- (MDKDevice *)_deviceForToken:(DTDKRemoteDeviceToken *)token
{
    __block MDKDevice *foundDevice = nil;
    [self.foundDevices enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        foundDevice = (MDKDevice *)obj;
        if([foundDevice.serialNumber isEqualToString:token.deviceSerialNumber]) {
            *stop = YES;
        }
    }];
     
    return foundDevice;
}

#pragma mark - DTDKRemoteDeviceDataListenerDelegate
- (void)deviceAttached:(DTDKRemoteDeviceToken *)deviceToken
{
    if(! self.foundDevices) {
        self.foundDevices = [NSMutableArray array];
    }
    
    MDKDevice *device = [self _deviceForToken:deviceToken];
    if(device) {
        // we already have this one, so lets bail?
        // we should actually never receive a duplicate device, but just in case.
        return;
    }
    
    device = [[MDKDevice alloc] _initWithDeviceToken:deviceToken];
    [self.foundDevices addObject:device];
    
    if([self.delegate respondsToSelector:@selector(deviceManager:foundDevice:)]) {
        [self.delegate deviceManager:self foundDevice:device];
    }
    
    [device release];
    
}

- (void)deviceDetached:(DTDKRemoteDeviceToken *)deviceToken
{
    MDKDevice *device = [self _deviceForToken:deviceToken];
    if(device) {
        [self.foundDevices removeObject:device];
    }
    
    if([self.delegate respondsToSelector:@selector(deviceManager:lostDevice:)]) {
        [self.delegate deviceManager:self lostDevice:device];
    }
    
}
@end
