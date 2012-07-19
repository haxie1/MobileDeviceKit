//
//  MDKDevice.h
//  devicekit
//
//  Created by Kam Dahlin on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MDKApplication;

@interface MDKDevice : NSObject
@property (readonly) NSString *name;
@property (readonly) NSString *identifier;
@property (readonly) NSString *serialNumber;
@property (readonly) NSDictionary *deviceInfo;

- (NSArray *)applications;

- (MDKApplication *)applicationWithName:(NSString *)name;
- (MDKApplication *)applicationWithIdentifier:(NSString *)identifier;

- (BOOL)installApplication:(MDKApplication *)application error:(NSError **)error;

@end
