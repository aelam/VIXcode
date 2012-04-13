//
//  VIEventProcessor.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEventProcessor.h"
#import "VIKitConstants.h"

@implementation VIEventProcessor

@synthesize currentTextView = _currentTextView;
@synthesize currentCommandView = _currentCommandView;
@synthesize state = _state;
@synthesize showcmdBuffer = _showcmdBuffer;
@synthesize appendString = _appendString;
@synthesize repeat = _repeat;


static VIEventProcessor *sharedProcessor = nil;

+ (VIEventProcessor *)sharedProcessor {
    @synchronized(self) {
        if (sharedProcessor == nil) {
            sharedProcessor = [[self alloc]init];
        }
        
        return sharedProcessor;
    }
}

- (id)init {
    if (self = [super init]) {
        
        //EXTERN int State INIT(= NORMAL);	/* This is the current state of the command interpreter. */
        _state = NORMAL;
        NIF_INFO(@"state : %lu",_state);

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
    
    return YES;
}

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
