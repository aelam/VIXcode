//
//  NSEvent+Keymap.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSEvent (Keymap)

- (unichar)charcode;

- (BOOL)isESC;

@end
