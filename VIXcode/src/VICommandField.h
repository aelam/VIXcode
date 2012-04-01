//
//  VICommandField.h
//  VIXcode
//
//  Created by Ryan Wang on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define VICommandFieldTag 1000

@interface VICommandField : NSTextField

+ (VICommandField *)sharedInstance;

@end
