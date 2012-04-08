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
