//
//  VICommandView.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class VIEventProcessor;

/**
 * cmd field 
 * append field 
 *
 */
@interface VICommandView : NSView {
@private
    NSTextField *_cmdField;
    NSTextField *_appendField;
}

@property (nonatomic,retain) VIEventProcessor *eventProcessor;
@property (nonatomic,weak)  NSTextView *textView;
@property (nonatomic,getter = isActived) BOOL active;

+ (id)commandViewWithTextView:(id)sourceView;
- (id)initWithTextView:(id)sourceView;

/**
 *     
 *  Recommend
 *  When NSTextView's delegate  - (void)viewDidMoveToSuperview invoked to invoke this method
 *  You need handle this
 *
 */
- (void)addMeOnTextView;

- (void)updateCommand:(NSString *)cmd;
- (void)updateAppendInfo:(NSString *)info;

- (void)clear;

@end
