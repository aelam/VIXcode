//
//  VIEventProcessor.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIMotionManager.h"
#import "VIEventProtocol.h"
#import "NSEvent+Keymap.h"
#import "MacKeyMap.h"

@class VIMotionManager;

@interface VIEventProcessor : NSObject {
    VIMotionManager<VIEventDelegate> *_motionManager;
    BOOL             _isInitialized;
    
    VIMState         _state;

@protected
    NSMutableString *_cmdString;
    NSMutableString *_appendString;
    
}


@property (nonatomic,readonly) VIMotionManager<VIEventDelegate> *motionManager;
@property (nonatomic,readwrite) BOOL             isInitialized;
@property (nonatomic,readwrite) VIMState        state;
@property (nonatomic,retain) NSMutableString *cmdString;
@property (nonatomic,retain) NSMutableString *appendString;
@property (nonatomic,readonly) NSUInteger   repeat;


+ (id)processorWithMotionManager:(VIMotionManager <VIEventDelegate>*)motionManager;

- (id)initWithMotionManager:(VIMotionManager <VIEventDelegate>*)motionManager;

- (void)updateCMD:(NSString *)newString keepOld:(BOOL)keep;
- (void)updateAppendInfo:(NSString *)appendInfo keepOld:(BOOL)keep;

- (BOOL)handleKeyEvent:(NSEvent *)event;


@end
