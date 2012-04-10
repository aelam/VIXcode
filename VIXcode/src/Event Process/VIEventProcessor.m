//
//  VIEventProcessor.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEventProcessor.h"

@implementation VIEventProcessor

@synthesize motionManager = _motionManager;
@synthesize isInitialized = _isInitialized;
@synthesize state = _state;
@synthesize cmdString = _cmdString;
@synthesize appendString = _appendString;
@synthesize repeat = _repeat;

+ (id)processorWithMotionManager:(VIMotionManager <VIEventDelegate>*)motionManager {
    return [[[self alloc] initWithMotionManager:motionManager] autorelease];
}

- (id)initWithMotionManager:(VIMotionManager<VIEventDelegate> *)motionManager {
    if (self = [super init]) {
        _motionManager = motionManager;
        _isInitialized = YES;
        _state = VIMStateNormal;
        
        _cmdString = [[NSMutableString alloc] init];
        _appendString = [[NSMutableString alloc] init];
        
    }
    return self;
}

- (void)updateCMD:(NSString *)newString keepOld:(BOOL)keep{
    if (keep) {
        if (newString) {
            [_cmdString appendString:newString];        
        } else {
            [_cmdString setString:@""];
        }        
    } else {
        [_cmdString setString:newString?newString:@""];
    }
        
    [self.motionManager stateWillChange:self];
}

- (void)updateAppendInfo:(NSString *)appendInfo keepOld:(BOOL)keep{
    if (keep) {
        if (appendInfo) {
            [_appendString appendString:appendInfo];        
        } else {
            [_appendString setString:@""];
        }        
    } else {
        [_appendString setString:appendInfo?appendInfo:@""];

    }
    
    [self.motionManager stateWillChange:self];
}




- (BOOL)handleKeyEvent:(NSEvent *)event {
    
    return YES;
}

- (void)resetEvent {
    _isInitialized = YES;
}

- (void)dealloc {
    [_cmdString release];
    [_appendString release];
    [_motionManager release];
    [super dealloc];
}

@end
