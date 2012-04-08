//
//  VIVisualEventProcessor.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEventProcessor.h"

typedef enum {
    VIVisualModeVisual,         // v
    VIVisualModeVisualLine,     // V
    VIVisualModeVisualBlock     // C+v
} VIVisualMode;

static NSString *VIVisualModeString[] = {@"-- VISUAL --",@"-- VISUAL LINE --",@"-- VISUAL BLOCK --"};

@interface VIVisualEventProcessor : VIEventProcessor {
    VIVisualMode _visualMode;
}

@property (nonatomic,readwrite)VIVisualMode visualMode;

+ (id)processorWithMotionManager:(id)motionManager visualMode:(VIVisualMode)aMode;


@end
