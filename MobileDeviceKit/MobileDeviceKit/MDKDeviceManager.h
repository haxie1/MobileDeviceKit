//
//  MDKDeviceManager.h
//  devicekit
//
//  Created by Kam Dahlin on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDKDevice.h"

@protocol MDKDeviceManagerDelegate;

@interface MDKDeviceManager : NSObject
@property (nonatomic, assign) id <MDKDeviceManagerDelegate> delegate;

+ (MDKDeviceManager *)sharedManager;

- (NSArray *)devices;

- (void)startSearchingForDevices;
- (void)stopSearchingForDevices;

@end

@protocol MDKDeviceManagerDelegate <NSObject>
@optional
- (void)deviceManager:(MDKDeviceManager *)manager foundDevice:(MDKDevice *)device;
- (void)deviceManager:(MDKDeviceManager *)manager lostDevice:(MDKDevice *)device;
- (void)deviceManagerStartedSearching:(MDKDeviceManager *)manager;
- (void)deviceManagerStoppedSearching:(MDKDeviceManager *)manager;
@end