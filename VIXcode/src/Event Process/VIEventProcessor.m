//
//  VIEventProcessor.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEventProcessor.h"

@implementation VIEventProcessor

@synthesize currentSourceView = _currentSourceView;
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
        _state = VIMStateNormal;
        NIF_INFO(@"state : %lu",_state);

        _showcmdBuffer = [[NSMutableString alloc] init];
        _appendString = [[NSMutableString alloc] init];

    }
    return self;
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
