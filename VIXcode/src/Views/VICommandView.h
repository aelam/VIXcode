//
//  VICommandView.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "VIEventProtocol.h"

@class DVTSwizzleSourceTextView;
@protocol VIEventDelegate;
@class VIEventProcessor;

/**
 * cmd field 
 * append field 
 *
 */
@interface VICommandView : NSView <VIEventDelegate>{
@private
    NSTextField *_cmdField;
    NSTextField *_appendField;
}

@property (nonatomic,retain) VIEventProcessor *eventProcessor;
@property (nonatomic,weak) DVTSwizzleSourceTextView *sourceView;
@property (nonatomic,getter = isActived) BOOL active;

+ (id)commandViewWithSourceTextView:(id)sourceView;
- (id)initWithSourceTextView:(id)sourceView;

- (void)addMe;

- (void)updateCommand:(NSString *)cmd;
- (void)updateAppendInfo:(NSString *)info;

- (void)clear;

@end
