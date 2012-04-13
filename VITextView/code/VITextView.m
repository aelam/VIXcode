//
//  VITextView.m
//  VIXcode
//
//  Created by Ryan Wang on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VITextView.h"
#import <VIKit/VIKit.h>

@implementation VITextView

- (void)keyDown:(NSEvent *)theEvent {
    
    VIEventProcessor *eventProcesser = [VIEventProcessor sharedProcessor];
    
    if ([eventProcesser handleKeyEvent:theEvent]) {
        
    } else {
        [super keyDown:theEvent];
    }
}

@end
