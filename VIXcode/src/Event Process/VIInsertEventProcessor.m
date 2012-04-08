//
//  VIInsertEventProcessor.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIInsertEventProcessor.h"
#import "VINormalEventProcessor.h"

@implementation VIInsertEventProcessor

+ (id)processorWithMotionManager:(VIMotionManager <VIEventDelegate>*)motionManager {
    return [[[self alloc] initWithMotionManager:motionManager] autorelease];
}

- (id)initWithMotionManager:(VIMotionManager<VIEventDelegate> *)motionManager {
    if (self = [super initWithMotionManager:motionManager]) {
        self.state = VIMStateInsert;
        
        [self.cmdString appendString:@"--INSERT--"];
    }
    return self;
}

- (BOOL)handleKeyEvent:(NSEvent *)theEvent {
    
    if([theEvent isESC]) {
        NIF_INFO(@"ESC pressed!!");
        [self.motionManager.sourceView moveBackward:self];
        [self.motionManager setEventProcessor:[VINormalEventProcessor processorWithMotionManager:self.motionManager]];
        return YES;
    } else {
        NIF_INFO(@"NOT ESC pressed!!");
        // Let system handle other event
        return NO;
    }

}

@end
