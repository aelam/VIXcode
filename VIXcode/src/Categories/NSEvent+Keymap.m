//
//  NSEvent+Keymap.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSEvent+Keymap.h"
#import "MacKeyMap.h"

@implementation NSEvent (Keymap)

-(unichar)charcode {
    unichar charcode = [[self charactersIgnoringModifiers] characterAtIndex:0];

    return charcode;
}

- (BOOL)isESC {
    if (self.keyCode == KEY_ESC) {
        return YES;
    }
    return NO;
}

@end
