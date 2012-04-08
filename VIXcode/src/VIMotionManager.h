//
//  VIMotionManager.h
//  VIXcode
//
//  Created by Ryan Wang on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "VIEventProcessor.h"
#import "VIEventProtocol.h"

@class DVTSwizzleSourceTextView;
@class VICommandView;
@protocol VIEventDelegate;
@class VIEventProcessor;

typedef enum {
    VIMStateNormal,
    VIMStateInsert,
    VIMStateVisual,
    VIMStateExit
}VIMState;

@interface VIMotionManager : NSObject <VIEventDelegate>{
@private
    __weak VICommandView *_cmdView;
    VIEventProcessor *_eventProcessor;
}

@property (nonatomic,readonly,weak) NSTextView *sourceView;
@property (nonatomic,retain) VIEventProcessor *eventProcessor;

+ (VIMotionManager *)managerWithSourceTextView:(id)sourceView;

- (id)initWithSourceView:(id)sourceView;

- (BOOL)handleKeyEvent:(NSEvent *)theEvent;

- (void)setupUIStaff;


- (void)reset;

@end
