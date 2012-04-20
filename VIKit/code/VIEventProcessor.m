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

@implementation VIEventProcessor

@synthesize currentTextView = _currentTextView;
@synthesize currentCommandView = _currentCommandView;
@synthesize state = _state;
//@synthesize showcmdBuffer = _showcmdBuffer;
//@synthesize appendString = _appendString;
@synthesize eventHandler = _eventHandler;
//@synthesize commandArgs = _commandArgs;

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
        NIF_INFO(@"state : %d",State);

        init_normal_cmds();

//        OperatorArgs op_args;
//        memset(&op_args, 0, sizeof(OperatorArgs));

//        memset(&_commandArgs, 0, sizeof(CommandArgs));

//        _commandArgs.op_args = op_args;
        
//        
//        CommandArgs args;
//        _commandArgs = args;
//        CommandArgs  args;
//        NIF_INFO(@"CommandArgs         _commandArgs %p",args);
//
//        _commandArgs = args;
////        OperatorArgs op;
//        
//        NIF_INFO(@"init %p",_commandArgs);
////        _commandArgs.op_args = &op;
//        
//        NIF_INFO(@"init %p",_commandArgs);
//        NIF_INFO(@"init %p",_commandArgs);

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

//    NIF_INFO(@"_commandArgs === %p",_commandArgs);
    
    if (_state & INSERT) {
        if (value == ESC) {
            _state = NORMAL;
        }

        return NO;
    } else if (_state & NORMAL) {
        [self.eventHandler handleEvent:event];
        
    } else {
        
        return YES;
    }
    
    return YES;
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
//    [_showcmdBuffer release];
//    [_appendString release];
    [super dealloc];
}

@end
