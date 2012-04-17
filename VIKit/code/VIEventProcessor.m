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
//#import "VIEditHandler.h"
#import "NSEvent+Keymap.h"
#import "vim.h"
#import "structs.h"
#import "VINormalHandler.h"

@implementation VIEventProcessor

@synthesize currentTextView = _currentTextView;
@synthesize currentCommandView = _currentCommandView;
@synthesize state = _state;
@synthesize showcmdBuffer = _showcmdBuffer;
@synthesize appendString = _appendString;
@synthesize eventHandler = _eventHandler;

static oparg_T	oa;				/* operator arguments */


static VIEventProcessor *sharedProcessor = nil;

+ (VIEventProcessor *)sharedProcessor {
    @synchronized(self) {
        if (sharedProcessor == nil) {
            sharedProcessor = [[self alloc]init];
            
            init_normal_cmds();
            
        }
        
        return sharedProcessor;
    }
}

- (id)init {
    if (self = [super init]) {
        
        //EXTERN int State INIT(= NORMAL);	/* This is the current state of the command interpreter. */
        _state = NORMAL;
        NIF_INFO(@"state : %d",State);
                
        _showcmdBuffer = [[NSMutableString alloc] init];
        _appendString = [[NSMutableString alloc] init];

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
    
    unichar value = [event ASCIIValue];

    
    if (State & INSERT) {
        if (value == ESC) {
            State = NORMAL;
        }

        return NO;
    } else if (State & NORMAL) {
        normal_cmd(&oa,TRUE,event);
    } else {
        
        return YES;
    }
    
    return YES;
}

//- (VIEventHandler *)eventHandler {
//    if (_eventHandler == nil) {
//        _eventHandler = [[VINormalHandler alloc] init];
//    }
//    return _eventHandler;
//}

- (void)clearShowcmd {
    
}

/**
 * delete cmd buffer 
 */
- (void)delFromShowcmd:(NSUInteger)len {
    
    int old_len = _showcmdBuffer.length;
    if (len > old_len) {
        len = old_len;
    }
    [_showcmdBuffer deleteCharactersInRange:NSMakeRange(old_len - len,len)];
    
    [self refreshCommandView];
}

- (void)refreshCommandView {
    if (_showcmdBuffer == nil || _showcmdBuffer.length == 0) {
        _showcmdBufferCleared = YES;
    } else {
        _showcmdBufferCleared = NO;
    }
}

- (void)dealloc {
    [_showcmdBuffer release];
    [_appendString release];
    [super dealloc];
}

@end
