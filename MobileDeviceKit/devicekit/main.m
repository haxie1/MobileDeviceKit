//
//  main.m
//  devicekit
//
//  Created by Kam Dahlin on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDKDeviceManager.h"
@interface Dele : NSObject <MDKDeviceManagerDelegate>
@end

@implementation Dele

- (void)deviceManager:(MDKDeviceManager *)manager foundDevice:(MDKDevice *)device
{
    NSLog(@"found a device: %@", device.name);
}

- (void)deviceManager:(MDKDeviceManager *)manager lostDevice:(MDKDevice *)device
{
    NSLog(@"lost device: %@", device.name);
}
@end
int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    Dele *dele = [[Dele alloc] init];
    MDKDeviceManager *manager = [MDKDeviceManager sharedManager];
    manager.delegate = dele;
    [manager startSearchingForDevices];
    
    [[NSRunLoop mainRunLoop] run];
    [pool drain];
    return 0;
}

