//
//  VIEventProcessor.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEventProcessor.h"
#import "VIKitConstants.h"
#import "VIEventHandler.h"
#import "VINormalHandler.h"
#import "NSEvent+Keymap.h"
#import "vim.h"
#import "structs.h"
#import "VINormalHandler.h"
#import "VIEditHandler.h"


BOOL VIModeEnabled = YES;

id VIEP = nil;

@implementation VIEventProcessor

@synthesize currentTextView = _currentTextView;
@synthesize currentCommandView = _currentCommandView;
//@synthesize state = _state;
@synthesize eventHandler = _eventHandler;
@synthesize currentLineColor = _currentLineColor;

+ (VIEventProcessor *)sharedProcessor {
    @synchronized(self) {
        if (VIEP == nil) {
            VIEP = [[self alloc]init];
        }
        
        return VIEP;
    }
}

- (id)init {
    if (self = [super init]) {
        
        State = NORMAL;
        NIF_INFO(@"state : %d",State);
        NIF_INFO(@"VIModeEnabled = %d",VIModeEnabled);
        
        _currentLineColor = [[NSColor colorWithDeviceRed:0 green:0.6 blue:0 alpha:0.5] retain];

    }
    return self;
}

- (void)setCurrentTextView:(NSTextView *)currentTextView {
    if (_currentTextView != currentTextView) {
        [_currentTextView release];
        _currentTextView = [currentTextView retain];
    }
    
    if (![_currentTextView viewWithTag:COMMAND_VIEW_TAG]) {
        _currentCommandView = [[[VICommandView alloc] initWithTextView:_currentTextView] autorelease];
    }
    [_currentCommandView addMeOnTextView];
}


- (BOOL)handleKeyEvent:(NSEvent *)event {

    NIF_INFO(@"%@",self.eventHandler);
    unichar value = [event ASCIIValue];
    if (State & NORMAL) {
        return [self.eventHandler handleEvent:event];
        
    } 
    else if (State & INSERT) {
        BOOL s = [self.eventHandler handleEvent:event];
        if (s && value == ESC) {
            [self setState:NORMAL];
        }
        
        return s;

    } else  {
        
        return YES;
    }
    
    return YES;
}

- (void)setState:(NSUInteger)flag {
//    _state = flag;
    State = flag;
    if (State & INSERT) {
        if (![self.eventHandler isKindOfClass:[VIEditHandler class]]) {
            self.eventHandler = [VIEditHandler handler];
        }
    }
    else if (State & NORMAL) {
        if (![self.eventHandler isKindOfClass:[VINormalHandler class]]) {
            self.eventHandler = [VINormalHandler handler];            
        }
    }      
}

- (VIEventHandler *)eventHandler {
    if (_eventHandler == nil) {
        _eventHandler = [[VINormalHandler alloc] init];
    }
    return _eventHandler;
}

- (void)clearShowcmd {
    
}

- (void)clearCommandArgs {
//    memset(&_commandArgs, 0, sizeof(CommandArgs));
}

- (void)dealloc {
    [_currentLineColor release];
    [super dealloc];
}

@end
