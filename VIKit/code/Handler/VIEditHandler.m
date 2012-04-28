//
//  VIEditHandler.m
//  VIXcode
//
//  Created by Ryan Wang on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEditHandler.h"
#import "NSEvent+Keymap.h"
#include "vim.h"
#import "VIEventProcessor.h"

@implementation VIEditHandler

+ (VIEditHandler *)handler {
    VIEditHandler *handler = [[[self alloc] init] autorelease];    
    return handler;
}


- (BOOL)handleEvent:(NSEvent *)event {
    
    int c = (int)ASCIIValueForEvent(event);

    if (c == ESC) {
        [VIEventProcessor sharedProcessor].state = NORMAL;
        NIF_INFO(@"%@",[[self textView] selectedRanges]);
        
//        [[self textView] moveToRightEndOfLine:self];
    }
    
    return NO;
}

@end
