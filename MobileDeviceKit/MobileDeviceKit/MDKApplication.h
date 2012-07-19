//
//  MDKApplication.h
//  devicekit
//
//  Created by Kam Dahlin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MDKFileManager;

@interface MDKApplication : NSObject
@property (readonly) NSString *name;
@property (readonly) NSString *identifier;
@property (readonly) NSString *devicePath;
@property (readonly) NSDictionary *infoPlist;

- (MDKFileManager *)applicationFileManager;
@end
