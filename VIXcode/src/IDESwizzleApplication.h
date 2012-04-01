//
//  IDEApplication.h
//  VIXcode
//
//  Created by Ryan Wang on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VICommandField.h"

@protocol IDEApplicationSwizzle <NSObject>

@optional
- (void)origin_sendEvent:(NSEvent *)theEvent;

@end

@interface IDESwizzleApplication : NSApplication<IDEApplicationSwizzle>


- (void)sendEvent:(NSEvent *)theEvent;

@end
